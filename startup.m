% startup.m
% Startup orchestrator for MATLAB and VS Code.
% All path configuration lives in startup_vscode.m

if isdeployed
    return;
end

% Detect VS Code environment
isVSCode = ~usejava('desktop') ...
    || ~isempty(getenv('VSCODE_PID')) ...
    || ~isempty(getenv('VSCODE_IPC_HOOK_CLI'));

% If running in desktop, remove any VS Code language-server shadow path entries
% so builtin functions (edit, restoredefaultpath, etc.) are used.
if ~isVSCode
    P = strsplit(path, pathsep);
    mask = contains(P, 'mathworks.language-matlab');
    if any(mask)
        for k = find(mask)
            try
                rmpath(P{k});
            catch
                % ignore failures; continue removing others
            end
        end
        rehash toolboxcache;
    end
end

% Optionally attempt engine sharing only for VS Code (safe to ignore failures)
if isVSCode
    try
        matlab.engine.shareEngine;
    catch
        % continue if unavailable
    end
else

    % Call the main startup routine and pass a flag indicating environment
    % startup_vscode should accept an optional input 'isVSCode' (true/false)
    try
        startup_vscode;
    catch ME
        warning('startup_vscode failed: %s', ME.message);
    end
end

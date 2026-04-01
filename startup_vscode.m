% startup_vscode.m
% Robust startup script used interactively in MATLAB Desktop (macOS).
% When running under VS Code, this script exits immediately to avoid interactive prompts.
%
% Place this in your userpath. If you want to run it manually from VS Code later,
% call it explicitly from an interactive MATLAB session (not from the language server).

% --- Graphics defaults ----------------------------------------------------
reset(groot);
set(groot, 'DefaultAxesFontsize', 16);
set(groot, 'DefaultAxesFontName', 'Georgia');
set(groot, 'DefaultAxesTickDir', 'out');
set(groot, 'DefaultAxesLineWidth', 1.2);

set(groot, 'DefaultFigureUnits', 'normalized');
set(groot, 'DefaultFigurePosition', [0.0070, 0.55, 0.28, 0.36]);

co = [1 0 0; 0 1 0; 0 0 1; 1 0 1; 0 1 1; 0 0 0];
set(groot, 'defaultAxesColorOrder', co);

set(groot, 'DefaultLineLineWidth', 1.2);

% Livescripts font size.
s = settings;
s.matlab.fonts.editor.normal.Size.PersonalValue = 16;
clear s;

%% Helper: expand ~ to macOS home directory
home = getenv('HOME');  % macOS-only
expandUser = @(p) regexprep(p, '^~', home);

%% Environment detection
if ~exist('isVSCode', 'var')
    isVSCode = ~usejava('desktop') || ~isempty(getenv('VSCODE_PID')) || ~isempty(getenv('VSCODE_IPC_HOOK_CLI'));
end

% If running under VS Code (language server), do not run the interactive startup.
if isVSCode
    fprintf('VS Code environment detected: skipping interactive startup_vscode.\n');
    return;
end

%% Safe initialization for Desktop sessions
shadowPaths = which('restoredefaultpath', '-all');
isShadowed = ~isempty(shadowPaths) && any(contains(shadowPaths, 'mathworks.language-matlab'));
if ~isShadowed
    try
        restoredefaultpath;
        savepath;
    catch ME
        warning('restoredefaultpath failed: %s', ME.message);
    end
else
    warning('Skipping restoredefaultpath because MATLAB Language Server shadow is on path.');
end

% Prefer the startup script location over userpath for matlabpaths.
startupDir = fileparts(mfilename('fullpath'));
addpath(startupDir);

% Use the first userpath entry as the base directory.
userPathEntries = strsplit(userpath, pathsep);
userBaseDir = userPathEntries{1};

% If repos are siblings of matlabpaths, prefer those locations.
workspaceBaseDir = fileparts(startupDir);

%% Directories (example layout: adapt to your system)
isetcamDir   = fullfile(workspaceBaseDir, 'isetcam');
if ~isfolder(isetcamDir), isetcamDir = fullfile(userBaseDir, 'isetcam'); end

isetvalidateDir = fullfile(workspaceBaseDir, 'isetvalidate');
if ~isfolder(isetvalidateDir), isetvalidateDir = fullfile(userBaseDir, 'isetvalidate'); end

isetbioDir   = fullfile(workspaceBaseDir, 'isetbio');
if ~isfolder(isetbioDir), isetbioDir = fullfile(userBaseDir, 'isetbio'); end

isetbioCSFDir   = fullfile(userBaseDir, 'isetbiocsf');
isetlensDir     = fullfile(userBaseDir, 'isetlens');
iset3dDir       = fullfile(userBaseDir, 'iset3d');

isetautoDir     = fullfile(userBaseDir, 'isetprojects', 'isetauto');
isetcalibrateDir= fullfile(userBaseDir, 'isetcalibrate');
isetfluorescenceDir = fullfile(userBaseDir, 'isetprojects', 'isetfluorescence');

isethyperspectral = fullfile(userBaseDir, 'isethyperspectral');
mquestplus        = fullfile(userBaseDir, 'mQUESTPlus');
cniDir            = fullfile(userBaseDir, 'cni');

cocoDir           = fullfile(userBaseDir, 'external', 'cocoapi');

oraleyeDir        = fullfile(userBaseDir, 'isetprojects', 'oraleye');
oeTongueLipDir    = fullfile(userBaseDir, 'isetprojects', 'oe_tongue_lip');
oraleyelabimagesDir = fullfile(userBaseDir, 'idm', 'oraleye-lab-images');

vistaDir          = fullfile(userBaseDir, 'vistasoft');
vistaDataDir      = fullfile(userBaseDir, 'vistadata');
PRFmodel          = fullfile(userBaseDir, 'MRI', 'PRFmodel');
BrainBDir         = fullfile(userBaseDir, 'MRI', 'BrainBeat');

spmDir            = fullfile(userBaseDir, 'MRI', 'spm8');
knkDir            = fullfile(userBaseDir, 'MRI', 'knkutils');
ophDIR            = fullfile(userBaseDir, 'scitranApps', 'ophthalmology');
vlfeatDir         = fullfile(userBaseDir, 'external', 'ophvlfeat');
retinaTOMEDir     = fullfile(userBaseDir, 'external', 'retinaTOMEAnalysis');

teachmriDir       = fullfile(userBaseDir, 'teach', 'teachmri');
teachiseDir       = fullfile(userBaseDir, 'teach', 'psych221');

stAppsDir         = fullfile(userBaseDir, 'scitranApps');
jsonioDir         = fullfile(userBaseDir, 'tools', 'JSONio');
psychtoolboxDir   = fullfile(userBaseDir, 'tools', 'Psychtoolbox-3');

%% Notify of tools always added
disp('Adding Unit, Scitran, Example');

unitTestDir = fullfile(userBaseDir, 'tools', 'UnitTestToolbox');
if isfolder(unitTestDir), addpath(genpath(unitTestDir)); end

stDir = fullfile(userBaseDir, 'scitran');
if isfolder(stDir), addpath(genpath(stDir)); end

ettbDir = fullfile(userBaseDir, 'tools', 'ExampleTestToolbox');
if isfolder(ettbDir), addpath(genpath(ettbDir)); end

% Local FISE dirs (allow use of ~)
fiseDir1 = expandUser('~/Documents/FISE-git/code');
if isfolder(fiseDir1), addpath(genpath(fiseDir1)); end

fiseDir2 = expandUser('~/Documents/FISE-git/matlab');
if isfolder(fiseDir2), addpath(genpath(fiseDir2)); end

%% Additional choices (interactive)
fprintf('***Path selection****\n');

pathOptions = {'ISET3D', ...
    'ISET3D-TEACHISE', ...
    'ISET3D-ISETAUTO', ...
    'ISETBIO', ...
    'ISETBIO-ISET3D', ...
    'ISETBIO-ISET3D-TEACHISE', ...
    'VISTA-OPH-BB', ...
    'VISTA-PRFmodel-SPM', ...
    'VISTA-CNI', ...
    'VISTA-TEACHMRI', ...
    'TEACHMRI', ...
    'ISETFLUOR-OE', ...
    'ISET3dV4', ...
    'None'};

for ii = 1:length(pathOptions)
    fprintf('%d:\t%s\n', ii, pathOptions{ii});
end

% Desktop: interactive prompt and validation
R = input('Enter choice number: ');
if isempty(R) || ~isnumeric(R) || R < 1 || R > numel(pathOptions)
    error('Invalid selection. Aborting startup_vscode.');
end
fprintf('Selected: %s\n', pathOptions{R});

%% Set the paths
switch pathOptions{R}
    case 'ISETBIO'
        addpath(genpath(isetcamDir));
        addpath(genpath(isetbioDir));
        chdir(isetbioDir);

    case 'ISETBIO-ISET3D'
        addpath(genpath(isetcamDir));
        addpath(genpath(isetbioDir));
        addpath(genpath(iset3dDir));
        chdir(isetbioDir);

    case 'ISETBIO-ISET3D-ISETLENS'
        addpath(genpath(isetcamDir));
        addpath(genpath(isetbioDir));
        addpath(genpath(iset3dDir));
        addpath(genpath(isetlensDir));
        chdir(isetbioDir);

    case 'ISET3dV4'
        addpath(genpath(isetcamDir));
        % addpath(genpath(iset3dv4Dir)); % adapt if you maintain this

    case 'ISETLENS'
        addpath(genpath(isetcamDir));
        addpath(genpath(isetlensDir));
        chdir(isetlensDir);

    case 'ISETFLUOR'
        addpath(genpath(isetcamDir));
        addpath(genpath(isetfluorescenceDir));
        chdir(isetfluorescenceDir);

    case 'ISETFLUOR-OE'
        addpath(genpath(isetcamDir));
        addpath(genpath(isetfluorescenceDir));
        addpath(genpath(oraleyeDir));
        addpath(genpath(oeTongueLipDir));
        addpath(genpath(oraleyelabimagesDir));
        chdir(oraleyelabimagesDir);

    case 'ISETCAM-HYPERSPECTRAL'
        addpath(genpath(isetcamDir));
        addpath(genpath(isethyperspectral));
        chdir(isethyperspectral);

    case 'TEACHISE-ISETCAL'
        addpath(genpath(isetcamDir));
        addpath(genpath(teachiseDir));
        addpath(genpath(isetcalibrateDir));
        chdir(teachiseDir);

    case 'ISET3D'
        addpath(genpath(isetcamDir));
        addpath(genpath(iset3dDir));

    case 'ISET3D-TEACHISE'
        addpath(genpath(isetcamDir));
        addpath(genpath(iset3dDir));
        addpath(genpath(teachiseDir));

    case 'ISET3D-ISETAUTO'
        addpath(genpath(isetcamDir));
        addpath(genpath(iset3dDir));
        addpath(genpath(isetautoDir));
        addpath(genpath(cocoDir));
        chdir(isetautoDir);

    case 'ISET3D-ISETLENS'
        addpath(genpath(isetcamDir));
        addpath(genpath(iset3dDir));
        addpath(genpath(isetlensDir));
        chdir(iset3dDir);

    case 'VISTA-SPM-PRFmodel-KNK-PTB'
        addpath(genpath(spmDir));
        addpath(genpath(knkDir));
        addpath(genpath(psychtoolboxDir));
        addpath(genpath(PRFmodel));
        addpath(genpath(vistaDataDir));
        addpath(genpath(vistaDir));
        addpath(genpath(jsonioDir));
        chdir(PRFmodel);

    case 'SCIAPPS-VISTA-SPM'
        addpath(genpath(jsonioDir));
        addpath(genpath(spmDir));
        addpath(genpath(stAppsDir));
        addpath(genpath(vistaDataDir));
        addpath(genpath(vistaDir));
        chdir(vistaDir);

    case 'VISTA-PRFmodel-SPM'
        addpath(genpath(spmDir));
        addpath(genpath(PRFmodel));
        addpath(genpath(vistaDataDir));
        addpath(genpath(vistaDir));
        addpath(genpath(jsonioDir));
        chdir(PRFmodel);

    case 'VISTA-CNI'
        addpath(genpath(vistaDataDir));
        addpath(genpath(vistaDir));
        addpath(genpath(cniDir));
        addpath(genpath(jsonioDir));
        chdir(cniDir);

    case 'VISTA-OPH-BB'
        addpath(genpath(vistaDir));
        addpath(genpath(BrainBDir));
        addpath(genpath(ophDIR));
        addpath(genpath(jsonioDir));
        addpath(genpath(vlfeatDir));
        addpath(genpath(retinaTOMEDir));
        chdir(ophDIR);

    case 'VISTA-TEACHMRI'
        addpath(genpath(teachmriDir));
        addpath(genpath(vistaDataDir));
        addpath(genpath(vistaDir));
        addpath(genpath(jsonioDir));
        chdir(teachmriDir);

    case 'TEACHMRI'
        addpath(genpath(teachmriDir));
        chdir(teachmriDir);

    otherwise
        disp('Default Matlab path.');
end

%% If ISET is present, add validation directory
tst = which('isetRootPath');
if ~isempty(tst)
    disp('Adding isetvalidate.');
    addpath(genpath(isetvalidateDir));
end

%% Eliminate .git directories from path (assumes gitRemovePath is on path)
curDir = pwd;
try
    gitRemovePath;
catch
    warning('gitRemovePath not found or failed.');
end
chdir(curDir);
fprintf('Current directory: %s\n', pwd);

%% Clear variables used by this script
clearvars -except isVSCode;

% End of startup_vscode.m

% Startup.m
%
%   Brian Wandell
%
if isdeployed
    % Do nothing
else
    %%
    set(0,'DefaultAxesFontsize',16)
    set(0,'DefaultAxesFontName','Georgia')
    
    %%
    restoredefaultpath;
    addpath(fullfile(userpath,'matlabpaths'));
    
    %%  My directories
    %
    % Should be using ToolboxToolbox, I know.
    
    isetcamDir   = fullfile(userpath,'isetcam');
    isetlensDir  = fullfile(userpath,'isetlens');
    iset3dDir    = fullfile(userpath,'iset3d');
    isetcloudDir = fullfile(userpath,'isetcloud');
    isetL3Dir    = fullfile(userpath,'isetL3');
    isetbioDir   = fullfile(userpath,'isetbio');
    
    wlDir        = fullfile(userpath,'LABS','WL');
    % We might want to specify these sub-directories
    % wlTalksDir   = fullfile(userpath,'LABS''WL','WLTalks');
    % wlGaborDir   = fullfile(userpath,'LABS','WL','WLGabor');
    % wlVernierDir = fullfile(userpath,'LABS','WL','WLVernier');
    % oraleyeDir = fullfile(userpath,'LABS','WL','oraleye');
    
    vistaDir    = fullfile(userpath,'vistasoft');
    spmDir      = fullfile(userpath,'MRI','spm8');
    
    teachmriDir  = fullfile(userpath,'teach','teachmri');
    teachiseDir  = fullfile(userpath,'teach','psych221');
    
    stDir        = fullfile(userpath,'scitran');
    % sdkDir       = fullfile(userpath,'flywheelsdk','445');
    stAppsDir    = fullfile(userpath,'scitranApps');
    
    % Utilities
    jsonioDir    = fullfile(userpath,'tools','JSONio');
    examplesDir  = fullfile(userpath,'tools','ExampleTestToolbox');
    unitTestDir  = fullfile(userpath,'tools','UnitTestToolbox');
    rdDir        = fullfile(userpath,'tools','RemoteDataToolbox');
    
    %%
    fprintf('***Path selection****\n');
    pathOptions = {'ISETBIO-ISET3D',...
        'ISETBIO-WL', ...
        'ISETCAM-TEACH',...
        'ISETCAM-WL', ...
        'ISETCAM-ISET3D',...
        'ISETCAM-ISETLENS',...
        'ISETCAM-ISET3D-ISETLENS',...
        'ISETCAM-ISET3D-ISETCLOUD',...
        'GRAPHICS',...
        'SCIAPPS-VISTA-SPM',...
        'VISTA-TEACH',...
        'TEACHMRI',...
        'None'};
    
    %% Print options and get a response
    for ii=1:length(pathOptions)
        fprintf('%d %s\n',ii,pathOptions{ii});
    end
    
    R = input('Enter choice number:  ');
    
    %% Notify of tools
    
    disp(pathOptions{R})
    disp('Adding RDT, UTT, Examples, JSONio, Scitran, Add-Ons')
    addpath(genpath(rdDir));
    addpath(genpath(unitTestDir));
    addpath(genpath(examplesDir));
    addpath(genpath(jsonioDir));
    addpath(genpath(stDir));
    % addpath(genpath(sdkDir)); disp(sdkDir)
    % addpath(genpath(fullfile(userpath,'Add-Ons','Toolboxes')));
    
    %%
    
    switch pathOptions{R}
        
        case 'ISETBIO-ISET3D'
            addpath(genpath(isetbioDir));
            addpath(genpath(iset3dDir));
            chdir(iset3dDir);
        case 'ISETBIO-WL'
            addpath(genpath(isetbioDir));
            addpath(genpath(wlDir));
            chdir(isetbioDir);
        case 'ISETCAM-TEACH'
            addpath(genpath(isetcamDir));
            addpath(genpath(teachiseDir));
            chdir(teachiseDir);
        case 'ISETCAM-WL'
            addpath(genpath(isetcamDir));
            addpath(genpath(wlDir));
            chdir(isetcamDir);
        case 'ISETCAM-ISET3D'
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dDir));
            chdir(iset3dDir);
        case 'ISETCAM-ISET3D-ISETLENS'
            addpath(genpath(isetcamDir));
            addpath(genpath(isetlensDir));
            addpath(genpath(iset3dDir));
            chdir(isetcamDir);
        case 'ISETCAM-ISET3D-ISETCLOUD'
            addpath(genpath(isetcamDir));
            addpath(genpath(isetcloudDir));
            addpath(genpath(iset3dDir));
            chdir(isetcamDir);
        case 'ISETCAM-ISETLENS'
            addpath(genpath(isetcamDir));
            addpath(genpath(isetlensDir));
            chdir(isetlensDir);
            
        case 'GRAPHICS'
            % Experiments with graphics and Flywheel
            addpath(genpath(iset3dDir));
            addpath(genpath(isetcloudDir));
            addpath(genpath(isetcamDir));
            
        case 'SCIAPPS-VISTA-SPM'
            % Scitran and Vistasoft
            addpath(genpath(spmDir));
            addpath(genpath(stAppsDir));
            addpath(genpath(vistaDir));  % Make sure this is last
            chdir(vistaDir);
            
        case 'VISTA-TEACH'
            % Scitran and Vistasoft
            addpath(genpath(spmDir));
            addpath(genpath(teachmriDir));
            addpath(genpath(vistaDir));  % Make sure this is last
            chdir(teachmriDir);
            
        case 'TEACHMRI'
            % Scitran and Vistasoft
            addpath(genpath(teachmriDir));
            chdir(teachmriDir);
            
        otherwise
            disp('Default Matlab path.')
    end
    
    %% Eliminates the .git directories from the path.
    
    curDir = pwd;
    gitRemovePath;
    chdir(curDir);
    
    fprintf('Current directory: %s\n',pwd)
    %% Clear variables
    
    clear R isetcamDir isetbioDir wlDir rtbDir piDir
    clear unitTestDir rdDir s3dDir
    clear vistaDir spmDir teachmriDir
    clear wlDir wlGaborDir wlTalksDir
    clear stDir stAppsDir jsonioDir wltalksDir curDir ii pathOptions c
end

%%
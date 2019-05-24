% Startup.m
%
%   Brian Wandell
%
if isdeployed
    % Do nothing
else
    %%
    set(groot,'DefaultAxesFontsize',16)
    set(groot,'DefaultAxesFontName','Georgia')
    co = [1 0 0; 0 1 0 ; 0 0 1; 1 0 1; 0 1 1; 0 0 0];
    set(groot,'defaultAxesColorOrder',co)

    %%
    restoredefaultpath;
    addpath(fullfile(userpath,'matlabpaths'));
    
    %%  My directories
    %
    % Should be using ToolboxToolbox, I know.
    
    % Maybe these should all be inside of an ISET subdirectory.
    isetcamDir   = fullfile(userpath,'isetcam');
    isetbioDir   = fullfile(userpath,'isetbio');
    isetlensDir  = fullfile(userpath,'isetlens');
    iset3dDir    = fullfile(userpath,'iset3d');
    isetcloudDir = fullfile(userpath,'isetcloud');
    isetL3Dir    = fullfile(userpath,'isetL3');
    iset360Dir   = fullfile(userpath,'iset360');
    isetautoDir  = fullfile(userpath,'isetauto');
    isetmosaicsDir        = fullfile(userpath,'isetmosaics');
    isetmultispectralDir  = fullfile(userpath,'isetmultispectral');
    isetcalibrateDir      = fullfile(userpath,'isetcalibrate');
    isetfluorescenceDir   = fullfile(userpath,'isetfluorescence');

    % We might want to specify individual sub-directories
    wlDir        = fullfile(userpath,'LABS','WL');
    % wlTalksDir   = fullfile(userpath,'LABS''WL','WLTalks');
    % wlGaborDir   = fullfile(userpath,'LABS','WL','WLGabor');
    % wlVernierDir = fullfile(userpath,'LABS','WL','WLVernier');
    % oraleyeDir   = fullfile(userpath,'LABS','WL','oraleye');
    % wlDiscriminationNetworkDir = fullfile(userpath,'LABS','WL','wlDiscriminationNetwork');
    % WLDichromacyAppearanceDir
    
    % Maybe this should all be inside of the MRI
    vistaDir    = fullfile(userpath,'vistasoft');
    PRFmodel    = fullfile(userpath,'MRI','PRFmodel');
    spmDir      = fullfile(userpath,'MRI','spm8');
    knkDir      = fullfile(userpath,'MRI','knkutils');
    
    % Teach subdirectory
    teachmriDir  = fullfile(userpath,'teach','teachmri');
    teachiseDir  = fullfile(userpath,'teach','psych221');
    
    % Utilities - Maybe scitran related should be inside of tools
    stDir        = fullfile(userpath,'scitran');
    stAppsDir    = fullfile(userpath,'scitranApps');
    
    jsonioDir    = fullfile(userpath,'tools','JSONio');
    examplesDir  = fullfile(userpath,'tools','ExampleTestToolbox');
    unitTestDir  = fullfile(userpath,'tools','UnitTestToolbox');
    rdDir        = fullfile(userpath,'tools','RemoteDataToolbox');
    psychtoolboxDir = fullfile(userpath,'tools','Psychtoolbox-3');
    
    %%
    fprintf('***Path selection****\n');
    pathOptions = {'ISETBIO-ISET3D',...
        'ISETBIO-WL', ...
        'ISETCAM-TEACH',...
        'ISETCAM-WL', ...
        'ISETCAM-ISET3D',...
        'ISETCAM-ISETLENS',...
        'ISETCAM-ISETFLUOR',...
        'ISETCAM-ISET3D-ISETLENS',...
        'ISETCAM-ISET3D-ISETCLOUD',...
        'ISETCAM-CALIBRATE-WL',...
        'GRAPHICS',...
        'SCIAPPS-VISTA-SPM',...
        'PRFmodel-VISTA-SPM-KNK-PTB',...
        'PRFmodel-VISTA-SPM', ...
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
    disp('Adding RDT, UTT, Examples, JSONio, Scitran')
    addpath(genpath(rdDir));
    addpath(genpath(unitTestDir));
    addpath(genpath(examplesDir));
    addpath(genpath(jsonioDir));
    addpath(genpath(stDir));
    
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
        case 'ISETCAM-CALIBRATE-WL'
            addpath(genpath(isetcamDir));
            addpath(genpath(wlDir));
            addpath(genpath(isetcalibrateDir));
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
        case 'ISETCAM-ISETFLUOR'
            addpath(genpath(isetcamDir));
            addpath(genpath(isetfluorescenceDir));
            chdir(isetfluorescenceDir);
            
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
            
        case 'PRFmodel-VISTA-SPM-KNK-PTB'
            % Scitran and Vistasoft
            addpath(genpath(spmDir));
            addpath(genpath(knkDir));
            addpath(genpath(psychtoolboxDir));
            addpath(genpath(PRFmodel));
            addpath(genpath(vistaDir));  % Make sure this is last
            chdir(PRFmodel);
            
        case 'PRFmodel-VISTA-SPM'
            % Scitran and Vistasoft
            addpath(genpath(spmDir));
            addpath(genpath(PRFmodel));
            addpath(genpath(vistaDir));  % Make sure this is last
            chdir(PRFmodel);
            
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
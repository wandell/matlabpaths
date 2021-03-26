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
    % restoredefaultpath; savepath;
    % addpath(fullfile(userpath,'SupportPackages','R2020a'));
    
    addpath(fullfile(userpath,'matlabpaths'));
    
    %%  My directories
    %
    % Should be using ToolboxToolbox, I know.
    
    % Maybe these should all be inside of an ISET subdirectory.
    isetcamDir   = fullfile(userpath,'isetcam');
    isetbioDir   = fullfile(userpath,'isetbio');
    isetbioCSFDir   = fullfile(userpath,'isetbiocsf');

    isetbiolivescriptDir   = fullfile(userpath,'isetbiolivescript');
    isetlensDir  = fullfile(userpath,'isetlens');
    iset3dDir    = fullfile(userpath,'iset3d');
    isetcloudDir = fullfile(userpath,'isetcloud');
    isetcalibrateDir      = fullfile(userpath,'isetcalibrate');
    isetfluorescenceDir   = fullfile(userpath,'isetfluorescence');
    isethyperspectral     = fullfile(userpath,'isethyperspectral');
    isetgDir              = fullfile(userpath,'isetg');
    isetverseDir          = fullfile(userpath,'isetverse');
    
    %{
    isetL3Dir    = fullfile(userpath,'isetL3');
    iset360Dir   = fullfile(userpath,'iset360');
    isetautoDir  = fullfile(userpath,'isetauto');
    isetmosaicsDir        = fullfile(userpath,'isetmosaics');
    isetmultispectralDir  = fullfile(userpath,'isetmultispectral');
    isetflywheelDir   = fullfile(userpath,'isetflywheel');
    %}
    
    % We might want to specify individual sub-directories
    wlDir        = fullfile(userpath,'LABS','WL');
    oraleyeDir   = fullfile(userpath,'LABS','WL','oraleye');
    cniDir       = fullfile(userpath,'LABS','CNI');
    
    %{
     wlTalksDir   = fullfile(userpath,'LABS''WL','WLTalks');
     wlGaborDir   = fullfile(userpath,'LABS','WL','WLGabor');
     wlVernierDir = fullfile(userpath,'LABS','WL','WLVernier');
     wlDiscriminationNetworkDir = fullfile(userpath,'LABS','WL','wlDiscriminationNetwork');
     WLDichromacyAppearanceDir
    %}
    
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
    
    %% CNI related
    jsonioDir    = fullfile(userpath,'tools','JSONio');
    % examplesDir  = fullfile(userpath,'tools','ExampleTestToolbox');
    unitTestDir  = fullfile(userpath,'tools','UnitTestToolbox');
    % rdDir        = fullfile(userpath,'tools','RemoteDataToolbox');
    psychtoolboxDir = fullfile(userpath,'tools','Psychtoolbox-3');
    
    %%
    fprintf('***Path selection****\n');
    pathOptions = {'ISETBIO-ISET3D',...
        'ISETBIO-WL', ...
        'ISETBIO-TEACH',...
        'ISETCAM-TEACH',...
        'ISETCAM-ISETCAL', ...
        'ISETCAM-ISET3D',...
        'ISETCAM-ISET3D-ISETCLOUD',...
        'ISETCAM-ISETFLUOR-OE',...
        'ISETCAM-ISETLENS',...
        'ISETCAM-ISET3D-ISETLENS',...
        'ISETCAM-ISET3D-ISETFLUOR',...
        'ISETCAM-TEACH-ISETCAL',...
        'ISETCAM-HYPERSPECTRAL',...
        'ISETCAM-ISETG',...
        'ISETCAM-ISET3D-ISETVERSE',...
        'VISTA-CNI',...
        'VISTA-PRFmodel-SPM', ...
        'VISTA-PRFmodel-SPM-KNK-PTB',...
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
    disp('Adding UTT, JSONio, Scitran')
    % addpath(genpath(rdDir));
    addpath(genpath(unitTestDir));
    % addpath(genpath(examplesDir));
    addpath(genpath(jsonioDir));
    addpath(genpath(stDir));
    
    %%
    
    switch pathOptions{R}
        %  ISETBio
        case 'ISETBIO-ISET3D'
            addpath(genpath(isetbioDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetcamDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(iset3dDir));
            addpath(genpath(isetbioCSFDir));
            chdir(isetbioDir);
        case 'ISETBIO-WL'
            addpath(genpath(isetbioDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetcamDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(wlDir));
            addpath(genpath(isetbioCSFDir));
            chdir(isetbioDir);
        case 'ISETBIO-WL-FLY'
            % Putting pre-computed data into Flywheel
            addpath(genpath(isetbioDir));
            addpath(genpath(isetbioCSFDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetcamDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(wlDir));
            addpath(genpath(isetflywheelDir));
            chdir(isetbioDir);
        case 'ISETBIO-TEACH'
            addpath(genpath(isetbioDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetcamDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(teachiseDir));
            addpath(genpath(isetbioCSFDir));
            chdir(isetbioDir);
        case 'ISETBIO-LIVESCRIPT'
            addpath(genpath(isetbioDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetcamDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(isetbiolivescriptDir));
            chdir(isetbioDir);
            
            %  ISETCam
        case 'ISETCAM-TEACH'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(teachiseDir));
            chdir(teachiseDir);
        case 'ISETCAM-TEACH-ISETCAL'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(teachiseDir));
            addpath(genpath(isetcalibrateDir));
            chdir(teachiseDir);
        case 'ISETCAM-WL'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(wlDir));
            chdir(isetcamDir);
        case 'ISETCAM-ISET3D'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(iset3dDir));
            chdir(iset3dDir);
        case 'ISETCAM-ISET3D-FLY'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(iset3dDir));
            addpath(genpath(isetflywheelDir));
            chdir(isetcamDir);
        case 'ISETCAM-CALIBRATE-WL'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(wlDir));
            addpath(genpath(isetcalibrateDir));
            chdir(isetcamDir);
        case 'ISETCAM-ISET3D-ISETLENS'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(isetlensDir));
            addpath(genpath(iset3dDir));
            chdir(isetcamDir);
        case 'ISETCAM-ISET3D-ISETFLUOR'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(isetfluorescenceDir));
            addpath(genpath(iset3dDir));
            chdir(isetcamDir);
        case 'ISETCAM-ISET3D-ISETCLOUD'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(isetcloudDir));
            addpath(genpath(iset3dDir));
            chdir(isetcamDir);
        case 'ISETCAM-ISETLENS'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(isetlensDir));
            chdir(isetlensDir);
        case 'ISETCAM-ISETFLUOR'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(isetfluorescenceDir));
            chdir(isetfluorescenceDir);
        case 'ISETCAM-ISETFLUOR-OE'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(isetfluorescenceDir));
            addpath(genpath(oraleyeDir));
            chdir(isetfluorescenceDir);
        case 'ISETCAM-HYPERSPECTRAL'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(isethyperspectral));
            chdir(isethyperspectral);
        case 'ISETCAM-ISETG'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(isetgDir));
            chdir(isetgDir);
        case 'ISETCAM-ISET3D-ISETVERSE'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(iset3dDir));
            addpath(genpath(isetverseDir));
            chdir(isetverseDir);
            
        case 'GRAPHICS'
            % Experiments with graphics and Flywheel
            addpath(genpath(iset3dDir));
            addpath(genpath(isetcloudDir));
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            
        case 'SCIAPPS-VISTA-SPM'
            % Scitran and Vistasoft
            addpath(genpath(spmDir));
            addpath(genpath(stAppsDir));
            addpath(genpath(vistaDir));  % Make sure this is last
            chdir(vistaDir);
            
        case 'VISTA-SPM-PRFmodel-KNK-PTB'
            % Scitran and Vistasoft
            addpath(genpath(spmDir));
            addpath(genpath(knkDir));
            addpath(genpath(psychtoolboxDir));
            addpath(genpath(PRFmodel));
            addpath(genpath(vistaDir));  % Make sure this is last
            chdir(PRFmodel);
            
        case 'VISTA-PRFmodel-SPM'
            % Scitran and Vistasoft
            addpath(genpath(spmDir));
            addpath(genpath(PRFmodel));
            addpath(genpath(vistaDir));  % Make sure this is last
            chdir(PRFmodel);
            
        case 'VISTA-CNI'
            % CNI TSNR calculations.  Threw in Vista just in case.
            addpath(genpath(vistaDir));
            addpath(genpath(cniDir));
            chdir(cniDir);
            
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
    
    clear isetbioDir isetbiolivescriptDir
    clear R isetcamDir wlDir rtbDir piDir iset360Dir iset3dDir
    clear isetL3Dir isetautoDir isetcalibrateDir isetcloudDir isetfluorescenceDir
    clear isetflywheelDir isetlensDir isetmosaicsDir isetmultispectralDir
    clear unitTestDir rdDir s3dDir psychtoolboxDir teachiseDir
    clear vistaDir spmDir teachmriDir knkDir examplesDir
    clear wlDir wlGaborDir wlTalksDir
    clear stDir stAppsDir jsonioDir wltalksDir curDir ii pathOptions c
end

%%

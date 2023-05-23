% Startup.m
%
%   Brian Wandell
%
%{
% When using the ISET3d-v4 with a GPU we need to do something like
% this.  These are the key/value options that we pass in piRender when
% running with the GPU
%
% This sticks across Matlab sessions.  So you don't need to run it
% every time.  This requires the 'vistalab' repository, however!
%
%  dockerWrapper.setParams('remoteRoot','/home/wandell');
%  dockerWrapper.setParams('whichGPU',0);
%  dockerWrapper.setParams('remoteUser','wandell');
%
%}

if isdeployed
    % Do nothing
else
    %%
    set(groot,'DefaultAxesFontsize',16)
    set(groot,'DefaultAxesFontName','Georgia')
    co = [1 0 0; 0 1 0 ; 0 0 1; 1 0 1; 0 1 1; 0 0 0];
    set(groot,'defaultAxesColorOrder',co);
    set(0,'DefaultLineLineWidth',1);
    
    %%
    restoredefaultpath; savepath;
    % addpath(fullfile(userpath,'SupportPackages','R2020a'));
    
    addpath(fullfile(userpath,'matlabpaths'));
    
    %%  My directories
    %
    % Should be using ToolboxToolbox, I know.
    
    % Maybe these should all be inside of an ISET subdirectory.
    isetcamDir   = fullfile(userpath,'isetcam');
    isetbioDir   = fullfile(userpath,'isetbio');
    isetbioCSFDir   = fullfile(userpath,'isetbiocsf');

    isetbiolivescriptDir   = fullfile(userpath,'isetbioprojects','isetbiolivescript');
    isetlensDir  = fullfile(userpath,'isetlens');
    iset3dV3Dir    = fullfile(userpath,'isetprojects','iset3d-v3');
    iset3dV4Dir    = fullfile(userpath,'iset3d-v4');
    % isetVistalab = fullfile(userpath,'vistalab');
    
    isetautoDir           = fullfile(userpath,'isetprojects','isetauto');
    cocoDir               = fullfile(userpath,'external','cocoapi');
    isetcloudDir          = fullfile(userpath,'isetcloud');
    isetcalibrateDir      = fullfile(userpath,'isetcalibrate');
    isetfluorescenceDir   = fullfile(userpath,'isetfluorescence');
    isethyperspectral     = fullfile(userpath,'isethyperspectral');
    isetgDir              = fullfile(userpath,'isetg');
    mquestplus            = fullfile(userpath,'mQUESTPlus');
    %{
    isetL3Dir    = fullfile(userpath,'isetL3');
    iset360Dir   = fullfile(userpath,'iset360');
    isetmosaicsDir        = fullfile(userpath,'isetmosaics');
    isetmultispectralDir  = fullfile(userpath,'isetmultispectral');
    isetflywheelDir   = fullfile(userpath,'isetflywheel');
    isetverseDir          = fullfile(userpath,'isetverse');
    %}
    
    % We might want to specify individual sub-directories
    wlDir        = fullfile(userpath,'LABS','WL');
    oraleyeDir   = fullfile(userpath,'LABS','WL','oraleye');
    cniDir       = fullfile(userpath,'cni');
    
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
    BrainBDir   = fullfile(userpath,'MRI','BrainBeat');

    spmDir      = fullfile(userpath,'MRI','spm8');
    knkDir      = fullfile(userpath,'MRI','knkutils');
    ophDIR      = fullfile(userpath,'scitranApps','ophthalmology');
    vlfeatDir     = fullfile(userpath,'external','ophvlfeat');  % A binary download
    retinaTOMEDir = fullfile(userpath,'external','retinaTOMEAnalysis');  % A binary download

    % Teach subdirectory
    teachmriDir  = fullfile(userpath,'teach','teachmri');
    teachiseDir  = fullfile(userpath,'teach','psych221');
    
    % Utilities - Maybe scitran related should be inside of tools
    stDir        = fullfile(userpath,'scitran');
    stAppsDir    = fullfile(userpath,'scitranApps');
    
    %% CNI related
    jsonioDir    = fullfile(userpath,'tools','JSONio');
    unitTestDir  = fullfile(userpath,'tools','UnitTestToolbox');
    psychtoolboxDir = fullfile(userpath,'tools','Psychtoolbox-3');

    % examplesDir  = fullfile(userpath,'tools','ExampleTestToolbox');
    rdDir        = fullfile(userpath,'tools','RemoteDataToolbox');

    %%
    fprintf('***Path selection****\n');
    pathOptions = {'ISETCAM-ISET3DV4',...
        'ISETCAM-TEACH-ISET3DV4',...
        'ISETCAM-ISET3DV4-ISETLENS',...
        'ISETCAM-ISET3DV4-ISETAUTO',...
        'ISETCAM-HYPERSPECTRAL',...
        'ISETCAM-ISET3DV4-TEACH',...
        'ISETBIO-ISET3DV4-TEACH', ... 
        'ISETBIO-ISET3DV4-ISETCAM', ...
        'VISTA-OPH-BB',...
        'VISTA-PRFmodel-SPM', ...
        'VISTA-CNI',...
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
    disp('Adding UTT, Scitran')
    addpath(genpath(unitTestDir));
    addpath(genpath(stDir));
    % addpath(genpath(rdDir));
    % addpath(genpath(examplesDir));
    % addpath(genpath(jsonioDir));
    
    %%
    
    switch pathOptions{R}
        %  ISETBio
        case 'ISETBIO-ISET3DV4-ISETLENS'
            addpath(genpath(isetbioDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetcamDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(isetlensDir));
            addpath(genpath(iset3dV4Dir));
            addpath(genpath(jsonioDir));
            addpath(genpath(isetbioCSFDir));
            addpath(genpath(mquestplus));

            chdir(isetbioDir);  
        case 'ISETBIO-WL'
            addpath(genpath(isetbioDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetcamDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(jsonioDir));
            addpath(genpath(wlDir));
            addpath(genpath(isetbioCSFDir));
            addpath(genpath(mquestplus));
            chdir(isetbioDir);
        case 'ISETBIO-WL-FLY'
            % Putting pre-computed data into Flywheel
            addpath(genpath(isetbioDir));
            addpath(genpath(isetbioCSFDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetcamDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(jsonioDir));
            addpath(genpath(wlDir));
            addpath(genpath(mquestplus));
            
            addpath(genpath(isetflywheelDir));
            chdir(isetbioDir);
        case 'ISETBIO-ISET3DV4-TEACH'
            addpath(genpath(isetbioDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetcamDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(jsonioDir));
            addpath(genpath(teachiseDir));
            addpath(genpath(isetbioCSFDir));
            addpath(genpath(iset3dV4Dir));
            addpath(genpath(mquestplus));
            chdir(isetbioDir);
        case 'ISETBIO-ISET3DV4-ISETCAM'
            % For isetcam branch of isetbio
            addpath(genpath(isetbioDir));
            addpath(genpath(isetcamDir));
            addpath(genpath(jsonioDir));
            addpath(genpath(isetbioCSFDir));
            addpath(genpath(iset3dV4Dir));
            addpath(genpath(mquestplus));            
            chdir(isetbioDir);
        case 'ISETBIO-LIVESCRIPT'
            addpath(genpath(isetbioDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetcamDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(jsonioDir));
            addpath(genpath(isetbiolivescriptDir));
            addpath(genpath(mquestplus));
            chdir(isetbioDir);
            
            %  ISETCam
        case 'ISETCAM-TEACH'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(teachiseDir));
            chdir(teachiseDir);
        case 'ISETCAM-TEACH-ISET3DV4'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(teachiseDir));
            addpath(genpath(iset3dV4Dir));
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
        case 'ISETCAM-ISET3DV4'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(iset3dV4Dir));
            chdir(iset3dV4Dir);
        case 'ISETCAM-ISET3DV4-ISETAUTO'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(iset3dV4Dir));
            addpath(genpath(isetautoDir));
            addpath(genpath(cocoDir));            
        case 'ISETCAM-ISET3DV4-ISETLENS'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');            
            addpath(genpath(iset3dV4Dir));
            addpath(genpath(isetlensDir));
            chdir(iset3dV4Dir);
        case 'ISETCAM-ISET3DV4-FLY'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(iset3dV4Dir));
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
        case 'ISETCAM-ISET3DV3-ISETFLUOR'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(isetfluorescenceDir));
            addpath(genpath(iset3dV3Dir));
            chdir(isetcamDir);
        case 'ISETCAM-ISET3DV3'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(iset3dV3Dir));
            addpath(genpath(isetautoDir));
            chdir(isetautoDir);
        case 'ISETCAM-ISET3DV3-ISETAUTO'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(iset3dV3Dir));
            addpath(genpath(isetautoDir));
            chdir(isetautoDir);
        case 'ISETCAM-ISET3DV3-ISETCLOUD'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(isetcloudDir));
            addpath(genpath(iset3dV3Dir));
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
        case 'ISETCAM-ISET3DV3-ISETVERSE'
            addpath(genpath(isetcamDir));
            warning('off','MATLAB:rmpath:DirNotFound');
            rmpath(genpath(isetbioDir));
            warning('on','MATLAB:rmpath:DirNotFound');
            addpath(genpath(iset3dV3Dir));
            addpath(genpath(isetverseDir));
            chdir(isetverseDir);
                       
        case 'SCIAPPS-VISTA-SPM'
            % Scitran and Vistasoft
            addpath(genpath(jsonioDir));
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
            addpath(genpath(jsonioDir));
            chdir(PRFmodel);
            
        case 'VISTA-PRFmodel-SPM'
            % Scitran and Vistasoft
            addpath(genpath(spmDir));
            addpath(genpath(PRFmodel));
            addpath(genpath(vistaDir));  % Make sure this is last
            addpath(genpath(jsonioDir));

            chdir(PRFmodel);
            
        case 'VISTA-CNI'
            % CNI TSNR calculations.  Threw in Vista just in case.
            addpath(genpath(vistaDir));
            addpath(genpath(cniDir));
            addpath(genpath(jsonioDir));
            chdir(cniDir);
            
        case 'VISTA-OPH-BB'
            addpath(genpath(vistaDir));
            addpath(genpath(BrainBDir));
            addpath(genpath(ophDIR));
            addpath(genpath(jsonioDir));
            addpath(genpath(vlfeatDir)); % Produces warnings for det and cummax
            addpath(genpath(retinaTOMEDir)); % Produces warnings for det and cummax
            chdir(ophDIR);
            
        case 'VISTA-TEACH'
            % Scitran and Vistasoft
            addpath(genpath(spmDir));
            addpath(genpath(teachmriDir));
            addpath(genpath(vistaDir));  % Make sure this is last
            addpath(genpath(jsonioDir));

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
    clear R isetcamDir wlDir rtbDir piDir iset360Dir iset3dV3Dir
    clear isetL3Dir isetautoDir isetcalibrateDir isetcloudDir isetfluorescenceDir
    clear isetflywheelDir isetlensDir isetmosaicsDir isetmultispectralDir
    clear unitTestDir rdDir s3dDir psychtoolboxDir teachiseDir
    clear vistaDir spmDir teachmriDir knkDir examplesDir
    clear wlDir wlGaborDir wlTalksDir
    clear stDir stAppsDir jsonioDir wltalksDir curDir ii pathOptions c
    

end

%%

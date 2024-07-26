% Startup.m
%
%  Used by Brian Wandell
%  Should be using ToolboxToolbox, I suppose
%

if isdeployed
    % Do nothing if this is for compilation and deployment.
else
    % Plot and root graphics defaults
    set(groot,'DefaultAxesFontsize',16)
    set(groot,'DefaultAxesFontName','Georgia')

    % Color ordering
    co = [1 0 0; 0 1 0 ; 0 0 1; 1 0 1; 0 1 1; 0 0 0];
    set(groot,'defaultAxesColorOrder',co);

    % Line width
    set(0,'DefaultLineLineWidth',1);
    
    % Livescripts font size.
    s = settings;
    s.matlab.fonts.editor.normal.Size.PersonalValue = 16;
    clear s;

    %%  Initialize
    restoredefaultpath; savepath;
    addpath(fullfile(userpath,'matlabpaths'));
    
    % addpath(fullfile(userpath,'SupportPackages','R2020a'));
    
    %%  My directories
    %
    % Should be using ToolboxToolbox, I know.
    
    % Maybe these should all be inside of an ISET subdirectory.
    isetcamDir   = fullfile(userpath,'isetcam');
    isetvalidateDir = fullfile(userpath,'isetvalidate');

    isetbioDir   = fullfile(userpath,'isetbio');
    isetbioCSFDir   = fullfile(userpath,'isetbiocsf');

    isetlensDir  = fullfile(userpath,'isetlens');
    iset3dV4Dir    = fullfile(userpath,'iset3d-v4');
    iset3dTinyDir  = fullfile(userpath,'iset3d-tiny');

    isetautoDir           = fullfile(userpath,'isetprojects','isetauto');
    isetcalibrateDir      = fullfile(userpath,'isetcalibrate');

    isetfluorescenceDir   = fullfile(userpath,'isetfluorescence');
    isethyperspectral     = fullfile(userpath,'isethyperspectral');
    mquestplus            = fullfile(userpath,'mQUESTPlus');
    cniDir                = fullfile(userpath,'cni');

    % Tools and external
    cocoDir               = fullfile(userpath,'external','cocoapi');

    % Older
    %
    % isetVistalab = fullfile(userpath,'vistalab');
    % isetcloudDir = fullfile(userpath,'isetcloud');
    % isetgDir     = fullfile(userpath,'isetg');
    % wlDir        = fullfile(userpath,'LABS','WL');
    % oraleyeDir   = fullfile(userpath,'LABS','WL','oraleye');   
    % isetbiolivescriptDir   = fullfile(userpath,'isetbioprojects','isetbiolivescript');
    % iset3dV3Dir    = fullfile(userpath,'isetprojects','iset3d-v3');
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
    stAppsDir       = fullfile(userpath,'scitranApps');    
    jsonioDir       = fullfile(userpath,'tools','JSONio');
    psychtoolboxDir = fullfile(userpath,'tools','Psychtoolbox-3');
    isetonlineDir   = fullfile(userpath,'isetonline');

    %% Notify of tools always added
    disp('Adding UTT, Scitran, ETT, ISETOnline')

    unitTestDir     = fullfile(userpath,'tools','UnitTestToolbox');
    addpath(genpath(unitTestDir)); % Unit test

    stDir = fullfile(userpath,'scitran');
    addpath(genpath(stDir));     % Scitran

    ettbDir = fullfile(userpath,'tools','ExampleTestToolbox');
    addpath(genpath(ettbDir));   % Example Toolbox

    %% Additional choices, requires a user response  
    fprintf('***Path selection****\n');

    pathOptions = {'ISETCAM-ISET3DTiny',...
        'ISETCAM-ISET3DTiny-TEACH',...
        'ISETCAM-ISET3DTiny-ISETLENS',...
        'ISETCAM-ISET3DTiny-ISETAUTO',...
        'ISETBIO', ...
        'ISETBIO-ISET3DTiny-TEACH', ... 
        'VISTA-OPH-BB',...
        'VISTA-PRFmodel-SPM', ...
        'VISTA-CNI',...
        'VISTA-TEACH',...
        'TEACHMRI',...         
        'None'};

    for ii=1:length(pathOptions)
        fprintf('%d:\t%s\n',ii,pathOptions{ii});
    end    
    R = input('Enter choice number:  ');
    disp(pathOptions{R})

    %% Set the paths

    % Older path options are in a comment towards the end
    switch pathOptions{R}
        %  ISETBio        
        case 'ISETBIO'
            addpath(genpath(isetbioDir));
            addpath(genpath(isetcamDir));            
        case 'ISETBIO-WL'
            addpath(genpath(isetbioDir));
            addpath(genpath(isetcamDir));
            addpath(genpath(wlDir));
            addpath(genpath(isetbioCSFDir));
            addpath(genpath(mquestplus));
            chdir(isetbioDir);
        case 'ISETBIO-WL-FLY'
            % Putting pre-computed data into Flywheel
            addpath(genpath(isetbioDir));
            addpath(genpath(isetcamDir));
            addpath(genpath(isetbioCSFDir));
            addpath(genpath(wlDir));
            addpath(genpath(mquestplus));            
            addpath(genpath(isetflywheelDir));
            chdir(isetbioDir);
        case 'ISETBIO-ISET3DTiny-TEACH'
            addpath(genpath(isetbioDir));
            addpath(genpath(isetcamDir));
            addpath(genpath(teachiseDir));
            addpath(genpath(isetbioCSFDir));
            addpath(genpath(iset3dTinyDir));
            addpath(genpath(mquestplus));
            chdir(isetbioDir);
        case 'ISETBIO-ISET3DTiny'
            addpath(genpath(isetbioDir));
            addpath(genpath(isetcamDir));
            addpath(genpath(isetbioCSFDir));
            addpath(genpath(iset3dTinyDir));
            addpath(genpath(mquestplus));            
            chdir(isetbioDir);
        case 'ISETBIO-ISET3DTiny-ISETLENS'
            addpath(genpath(isetbioDir));
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dTinyDir));
            addpath(genpath(isetlensDir));
            addpath(genpath(isetbioCSFDir));
            addpath(genpath(mquestplus));
            chdir(isetbioDir);  

            %  ISETCam
        case 'ISETCAM'
            addpath(genpath(isetcamDir));
            chdir(isetcamDir);
        case 'ISETCAM-TEACH'
            addpath(genpath(isetcamDir));
            addpath(genpath(teachiseDir));
            chdir(teachiseDir);
        case 'ISETCAM-CALIBRATE-WL'
            addpath(genpath(isetcamDir));
            addpath(genpath(wlDir));
            addpath(genpath(isetcalibrateDir));
            chdir(isetcamDir);
        case 'ISETCAM-ISETLENS'
            addpath(genpath(isetcamDir));
            chdir(isetlensDir);
        case 'ISETCAM-ISETFLUOR'
            addpath(genpath(isetcamDir));
            chdir(isetfluorescenceDir);
        case 'ISETCAM-ISETFLUOR-OE'
            addpath(genpath(isetcamDir));
            addpath(genpath(isetfluorescenceDir));
            addpath(genpath(oraleyeDir));
            chdir(isetfluorescenceDir);
        case 'ISETCAM-HYPERSPECTRAL'
            addpath(genpath(isetcamDir));
            addpath(genpath(isethyperspectral));
            chdir(isethyperspectral);
        case 'ISETCAM-TEACH-ISETCAL'
            addpath(genpath(isetcamDir));
            addpath(genpath(teachiseDir));
            addpath(genpath(isetcalibrateDir));
            chdir(teachiseDir);
        case 'ISETCAM-WL'
            addpath(genpath(isetcamDir));
            addpath(genpath(wlDir));
            chdir(isetcamDir);

        case 'ISETCAM-ISET3DV4-TEACH' 
            addpath(genpath(isetcamDir));
            addpath(genpath(teachiseDir));
            addpath(genpath(iset3dV4Dir));
            chdir(teachiseDir);
        case 'ISETCAM-ISET3DV4'
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dV4Dir));
            chdir(iset3dV4Dir);
        case 'ISETCAM-ISET3DV4-ISETAUTO'
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dV4Dir));
            addpath(genpath(isetautoDir));
            addpath(genpath(cocoDir));     
            chdir(isetautoDir);    
        case 'ISETCAM-ISET3DV4-ISETLENS'
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dV4Dir));
            addpath(genpath(isetlensDir));
            chdir(iset3dV4Dir);
        case 'ISETCAM-ISET3DV4-FLY'
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dV4Dir));
            addpath(genpath(isetflywheelDir));
            chdir(isetcamDir);

        case 'ISETCAM-ISET3DTiny'
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dTinyDir));
        case 'ISETCAM-ISET3DTiny-ISETLens'
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dTinyDir));
            addpath(genpath(isetlensDir));
        case 'ISETCAM-ISET3DTiny-ISETAUTO'
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dTinyDir));
            addpath(genpath(isetautoDir));
            addpath(genpath(cocoDir));     
            chdir(isetautoDir);    
        case 'ISETCAM-ISET3DTiny-ISETLENS'
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dTinyDir));
            addpath(genpath(isetlensDir));
            chdir(iset3dTinyDir);

            %  Vista
        case 'VISTA-SPM-PRFmodel-KNK-PTB'
            % Scitran and Vistasoft
            addpath(genpath(spmDir));
            addpath(genpath(knkDir));
            addpath(genpath(psychtoolboxDir));
            addpath(genpath(PRFmodel));
            addpath(genpath(vistaDir));  % Make sure this is last
            addpath(genpath(jsonioDir));
            chdir(PRFmodel);            
        case 'SCIAPPS-VISTA-SPM'
            % Scitran and Vistasoft
            addpath(genpath(jsonioDir));
            addpath(genpath(spmDir));
            addpath(genpath(stAppsDir));
            addpath(genpath(vistaDir));  % Make sure this is last
            chdir(vistaDir);            
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
            
            % Teach
        case 'TEACHMRI'
            % Scitran and Vistasoft
            addpath(genpath(teachmriDir));
            chdir(teachmriDir);
            
        otherwise
            disp('Default Matlab path.')
    end
    
    %% If ISET, add the validation directory

    tst = which('isetRootPath');
    if ~isempty(tst)
        disp('Adding isetvalidate.')
        addpath(genpath(isetvalidateDir)); 
    end

    %% Eliminate the .git directories from the path.
    
    curDir = pwd;
    gitRemovePath;
    chdir(curDir);
    fprintf('Current directory: %s\n',pwd)
    
    %% Clear variables

    clear isetbioDir isetbiolivescriptDir isetbioCSFDir iset3dTinyDir isetonlineDir p
    clear R isetcamDir wlDir iset3dV3Dir iset3dV4Dir isetvalidateDir isethyperspectral
    clear isetL3Dir isetautoDir isetcalibrateDir isetcloudDir isetfluorescenceDir
    clear isetflywheelDir isetlensDir isetmosaicsDir
    clear unitTestDir rdDir s3dDir psychtoolboxDir teachiseDir
    clear vistaDir spmDir teachmriDir knkDir examplesDir
    clear wlDir wlGaborDir wlTalksDir tst co
    clear isetonelineDir cocoDir cniDir BrainBDir PRFmodel mquestplus ophDIR retinaTOMEDir
    clear stDir stAppsDir jsonioDir curDir ii pathOptions c vlfeatDir ettbDir
    
    %{
         case 'ISETCAM-ISET3DV3-ISETFLUOR'
            addpath(genpath(isetcamDir));
            addpath(genpath(isetfluorescenceDir));
            addpath(genpath(iset3dV3Dir));
            chdir(isetcamDir);
        case 'ISETCAM-ISET3DV3'
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dV3Dir));
            addpath(genpath(isetautoDir));
            chdir(isetautoDir);
        case 'ISETCAM-ISET3DV3-ISETAUTO'
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dV3Dir));
            addpath(genpath(isetautoDir));
            chdir(isetautoDir);
        case 'ISETCAM-ISET3DV3-ISETCLOUD'
            addpath(genpath(isetcamDir));
            addpath(genpath(isetcloudDir));
            addpath(genpath(iset3dV3Dir));
            chdir(isetcamDir);
        case 'ISETCAM-ISETG'
            addpath(genpath(isetcamDir));
            addpath(genpath(isetgDir));
            chdir(isetgDir);            
        case 'ISETCAM-ISET3DV3-ISETVERSE'
            addpath(genpath(isetcamDir));
            addpath(genpath(iset3dV3Dir));
            addpath(genpath(isetverseDir));
            chdir(isetverseDir);
    %}

end

%%

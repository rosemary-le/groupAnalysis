%sets all the variables and paths for the pRF2sel function

% % % % %% general
% codedir
% codedir =
% '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
codedir='~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
addpath(codedir);
% sessiondir
% sessiondir ='/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/';
sessiondir ='~/projects/Prosopagnosia/fMRIData/';

savedir = [codedir 'RMECCLOCfiles/'];


% % % % % VIEW
vw = 'Gray';

% % % % GLM
% set of sessions for GLM
LOCsessions  = {
'112909whFMRI'
'082509_nj_proso'
'020209_mr_fmri'
'0100609jm'
'102909mb'
'11109km_proso'
'52309AF'
    };


% scan with correct GLM data
LOCscans = [
8 9; %WH
1 2; %NJ
2 3; %MR
1 2; %JM
1 2; %MB
1 2; %KM
1 2; %AF
];

ECCsessions = {
'112909whFMRI'
'082509_nj_proso'
'020209_mr_fmri'
'0100609jm'
'102909mb'
'11109km_proso'
'52309AF'
    };

ECCscans = [
2 3; %WH
4 5; %NJ
4 5; %MR
4 5; %JM
4 5; %MB
4 5; %KM
4 5;%AF
];


% corresponding dataTypes with Time series data
GLMdataTypes = 'MotionComp_RefScan1';

% alternatively the parameter map of interest, though MV tools will
% generate the desired contrast



% % % % RETMODEL
% sessions for retmodel
retsessions = {
'112909whFMRI'
'082509_nj_proso'
'020209_mr_fmri'
'0100609jm'
'102909mb'
'11109km_proso'
'52309AF'
    };


% corresponding dataTypes with retmodel
retdts = {
    'Averages' 
    'Averages' 
    'Averages' 
    'Averages' 
    'Averages' 
    'Averages' 
    'Averages' 
    'Averages' 
};

% names of retmodels for each subject
retmodels = {
'12degreesPRFfit-hrfFit.mat' %WH
'12degreesPRFfit-hrfFit.mat' %NJ
'12degreesPRFfit-hrfFit.mat' %MR
'12degreesPRFfit-hrfFit.mat' %JM
'12degreesPRFfit-hrfFit.mat' %MB
'retModel-20140501-183203-hrfFit.mat' %KM
'12degreesPRFfit-hrfFit.mat' %AF
    };
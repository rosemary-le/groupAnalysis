% this script is accurate as of 3/11/14 nw


%ADULTS
% sessions for various analyses
%subject directories
% all ret sessions are now in the localizer scan
adult_retsessions = {
'112909whFMRI'
'082509_nj_proso'
'020209_mr_fmri'
'0100609jm'
'102909mb'
'11109km_proso'
'52309AF'
    };

% '42811_TA'

adult_locsessions = {
'112909whFMRI'
'082509_nj_proso'
'020209_mr_fmri'
'0100609jm'
'102909mb'
'11109km_proso'
'52309AF'
    };


% want to move these so they are also all in the localizer scan

adult_catVSeccsessions = {
'112909whFMRI'
'082509_nj_proso'
'020209_mr_fmri'
'0100609jm'
'102909mb'
'11109km_proso'
'52309AF'
    };


%mesh for each subject to display
%left
adult_lmeshes = {
'wh_left_smoothed_400_1.mat'
'nj_lh_smoothed_400_1.mat'
'mr_lh_smoothed_400_1.mat'
'jm_lh_400_1.mat'
'mb_smooth_400_1_lh.mat'
'lh_km_smooth_400_1.mat'
'af_lh_smoothed_400_1.mat'
    };


%right
adult_rmeshes = {
   'wh_rh_smoothed_400_1.mat'
'nj_rh_smoothed_400_1.mat'
'mr_rh_smoothed_400_1.mat'
'jm_rh_400_1.mat'
'mb_smooth_400_1_rh.mat'
'rh_km_smooth_400_1.mat'
'af_rh_smoothed_400_1.mat'
    };




% names of prfModels
input.prfModels = {
'retModel-20131018-115057-hrfFit.mat' %WH
'retModel-20131018-103717-hrfFit.mat' %NJ
'retModel-20131025-130225-hrfFit.mat' %MR
'retModel-20131019-145830-hrfFit.mat' %JM
'retModel-20131020-103046-hrfFit.mat'  %MB
'retModel-20131020-152905-hrfFit.mat' %KM
'retModel-20131020-221744-hrfFit.mat' %AF
    };


% datatypes for the various analyses

prfdataType = {
'Averages'
'Averages'
'Averages'
'Averages'
'Averages'
'Averages'
'Averages'
    };


locdataType = 'GLMs';


eccdataType = {
    
};


catVSeccdataType = {'MotionComp_RefScan1'};



% scans for the various analyses

prfscans = ones(1,13);

catVSeccscans = ones(1,13);%this is a coranal that lives in motcomprefscan1 in all subjects and the map is attached to the first scan

locscans = [ 1 1 1 1 1 1 1 1 1 4 1 1 1 1];

% eccbias

% adult_sessions = {
%     'adult_jc_27yo_052408'
%     '42111_MN'
%     '42611_AH'
%     '43011_YW'
%     '81511_NL'
%     'adult_al_22yo_051108'
%     'adult_amk_27yo_042910'
%     'adult_ca_22yo_061908'
%     'adult_cmb_23yo_070608'
%     'adult_dy_25yo_041908'
%     'adult_jw_36yo_061608'
%     'adult_kll_18yo_052408'
%     'adult_kw_25yo_090308'
%     'adult_rb_22yo_101908'
%     'adult_mem_18yo_062608'
%     '42811_TA'
%     '41711_JR'
%     '41711_TM'};
%
% dtn = 'GLMs';
%
% eccbias_scan = [3 5 4 4 4 4 6 6 9 2 5 3 2 3 3 4 5 6];

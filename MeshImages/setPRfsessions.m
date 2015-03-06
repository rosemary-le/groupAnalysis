% this script is accurate as of 3/11/14 nw


%ADULTS
% sessions for various analyses
%subject directories
% all ret sessions are now in the localizer scan
adult_retsessions  = {
    '42111_MN'
    '42611_AH'
    '43011_YW'
    '81511_NL'
        'adult_al_22yo_051108'
    'adult_amk_27yo_042910'
    'adult_cmb_23yo_070608'
    'adult_dy_25yo_041908'
    'adult_jw_36yo_061608'
    'adult_kll_18yo_052408'
    'adult_kw_fmri2_27yo_092910'
    'adult_mem_18yo_062608'
    'adult_jc_27yo_052408'
    'adult_rb_22yo_101908'
    'adult_acg_39yo_012008'
    'adult_ca_22yo_061908'
    '41711_TM'
    '42811_TA'
    };


adult_locsessions  = {
    '42111_MN'
    '42611_AH'
    '43011_YW'
        '81511_NL'
        'adult_al_22yo_051108'
    'adult_amk_27yo_042910'
    'adult_cmb_23yo_070608'
    'adult_dy_25yo_041908'
    'adult_jw_36yo_061608'
    'adult_kll_18yo_052408'
    'adult_kw_fmri2_27yo_092910'
    'adult_mem_18yo_062608'
    'adult_jc_27yo_052408'
    'adult_rb_22yo_101908'
    'adult_acg_39yo_012008'
    'adult_ca_22yo_061908'
    '41711_TM'
    '42811_TA'
    };



% scan with correct GLM data
LOCscans = [
    1 2; %mn
    1 2; %ah
    1 2; %yw
    1 2;%     nl
    1 2;% al
    1 2; %amk
    1 2; %cmb
    1 2; %dy
    1 2; %jw
    1 2; %kll
    1 2; %kw
    1 2; %mem
    1 2; %jc
    1 2; %rb
    1 2; %acg
    1 2; %ca
    1 2; %tm
    1 2]; %ta





% want to move these so they are also all in the localizer scan

adult_catVSeccsessions = {
    '42111_MN'
    '42611_AH'
    '43011_YW'
    '81511_NL'
    'adult_al_22yo_051108'
    'adult_amk_27yo_042910'
    'adult_cmb_23yo_070608'
    'adult_dy_25yo_041908'
    'adult_jw_36yo_061608'
    'adult_kll_18yo_052408'
    'adult_kw_25yo_090308'
    'adult_mem_18yo_062608'
    'adult_jc_27yo_052408'
     'adult_rb_22yo_101908'
    'adult_acg_39yo_012008'
    'adult_ca_22yo_061908'
        '41711_TM'
    '42811_TA'
    };


%mesh for each subject to display
%left
adult_lmeshes = {
    'left_mesh_400.mat'
    'left_mesh_400_1.mat'
    'left_mesh_smoothed_400.mat'
    'left_smoothed400.mat'
    'al_lh_smoothed_400_1.mat'
    'ak_lh_smoothed_400_1.mat'
    'cmb_lh_smoothed_400_1.mat'
    'dy_lh_smoothed_400_1.mat'
    'jw_lh_smoothed_400_1.mat'
    'kll_lh_smoothed_400_1.mat'
    'kw_lh_smoothed_400_1.mat'
    'mem_left_smoothed_400_1.mat'
    'jc_lh_smoothed_400_1.mat'
    'rb_lh_smoothed_400_1.mat'
    'acg_lh_smoothed_400_1.mat'
    'ca_lh_smoothed_400_1.mat'   
    'left_mesh_400.mat' %TM
    'left_mesh_smoothed_400.mat' %TA
    };


%right
adult_rmeshes = {
    'right_mesh_400.mat'
    'right_mesh_400.mat'
    'right_mesh_smoothed_400.mat'
    'right_smoothed400_1.mat'
    'al_rh_smoothed_400_1.mat'
    'ak_rh_smoothed_400_1.mat'
    'cmb_rh_smoothed_400_1.mat'
    'dy_rh_smoothed_400_1.mat'
    'jw_rh_smoothed_400_1.mat'
    'kll_rh_smoothed_400_1.mat'
    'kw_rh_smoothed_400_1.mat'
    'mem_right_smoothed_400_1.mat'
    'jc_rh_smoothed_400_1.mat'
    'rb_rh_smoothed_400_1.mat'
    'acg_rh_smoothed_400_1.mat'
    'ca_rh_smoothed_400_1.mat'
    'right_mesh_400.mat' %TM
    'right_mesh_smoothed_400.mat' %TA
    };




% names of prfModels
% input.prfModels = {
%     '12degreesPRFfit-hrfFit.mat' %mn
%     '12degreesPRFfit-hrfFit.mat' %ah
%     '12degreesPRFfit-hrfFit.mat' %yw
%     %     'retModel-20130711-083422-hrfFit.mat' %nl
%     %     'retModel-20130731-133102-hrfFit.mat' %al
%     '12degreesPRFfit-hrfFit.mat' %amk
%     '12degreesPRFfit-hrfFit.mat' %cmb
%     '12degreesPRFfit-hrfFit.mat' %dy
%     '12degreesPRFfit-hrfFit.mat' %jw
%     '12degreesPRFfit-hrfFit.mat' %kll
%     '12degreesPRFfit-hrfFit.mat' %kw
%     '12degreesPRFfit-hrfFit.mat' %mem
%     'rmImported_retModel-20081015-070833-fFit.mat'  %jc
%     '12degreesPRFfit-hrfFit.mat' %rb
%     '12degreesPRFfit-hrfFit.mat' %acg
%     '12degreesPRFfit-hrfFit.mat' %ca
% %     '12degreesPRFfit-hrfFit.mat' %tm
% %     '12degreesPRFfit-hrfFit.mat' %ta
%     };



% names of prfModels
input.prfModels = {
    '15degreesPRFfit-fFit.mat' %mn
    '15degreesPRFfit-fFit.mat' %ah
    '15degreesPRFfit-fFit.mat' %yw
        'retModel-20130711-083422-hrfFit.mat' %nl
    '15degreesPRFfit-fFit.mat' %al
    '15degreesPRFfit-fFit.mat' %amk
    '15degreesPRFfit-fFit.mat' %cmb
    '15degreesPRFfit-fFit.mat' %dy
    '15degreesPRFfit-fFit.mat' %jw
    '15degreesPRFfit-fFit.mat' %kll
    '15degreesPRFfit-fFit.mat' %kw
    '15degreesPRFfit-fFit.mat' %mem
    'rmImported_retModel-20081015-070833-fFit.mat'  %jc
    '15degreesPRFfit-fFit.mat' %rb
    '15degreesPRFfit-fFit.mat' %acg
    '15degreesPRFfit-fFit.mat' %ca
    '15degreesPRFfit-hrfFit.mat' %tm
    '15degreesPRFfit-hrfFit.mat' %ta
    };


% datatypes for the various analyses
% imported ret models to localizer scan glm data type for some subjects
prfdataType = {
    'Averages' %mn
    'Averages' %ah
    'Averages' %yw
        'Averages' %nl
        'Averages_nw' %al
    'Averages_nw' %ak
    'Averages_nw' %cmb
    'GLMs' %dy
    'Averages' %jw
    'Averages' %kll
    'GLMs' %kw
    'Averages_nw' %mem
    'GLMs' %jc
    'GLMs' %rb
    'Averages_nw' %acg
    'Averages_nw' %ca
    'Averages' %tm
    'Averages' %ta
    };


locdataType = 'GLMs';


eccdataType = {};


catVSeccdataType = {'MotionComp_RefScan1'};



% scans for the various analyses

prfscans = ones(1,length(prfdataType));

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

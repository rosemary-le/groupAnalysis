%sets all the variables and paths for the pRF2sel function

% % % % %% general
% codedir
% codedir =
% '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
codedir='~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
addpath(codedir);
% sessiondir
% sessiondir ='/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/';
sessiondir ='~/projects/retinotopy/adult_ecc_karen/';

savedir = [codedir 'RMECCLOCfiles/'];


% % % % % VIEW
vw = 'Gray';

% % % % GLM
% set of sessions for GLM
LOCsessions = {
    '42111_MN'
    '42611_AH'
    '43011_YW'
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
    

ECCsessions = {
    '42111_MN'
    '42611_AH'
    '43011_YW'
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

ECCscans = [
    4 5; %mn
    4 5; %ah
    4 5; %yw
    4 5; %amk
    3 4; %cmb
    3 4; %dy
    6 7; %jw
    3 4; %kll
    3 4; %kw
    3 4; %mem
    3 4; %jc
    3 4; %rb
    1 2; %acg
    3 4; %ca
    4 5; %tm
    4 5]; %ta
%     '81511_NL'
%     'adult_al_22yo_051108'


% corresponding dataTypes with Time series data
GLMdataTypes = 'MotionComp_RefScan1';



% all ret sessions are now in the localizer scan
retsessions = {
    '42111_MN'
    '42611_AH'
    '43011_YW'
    % '81511_NL'
    %     'adult_al_22yo_051108'
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
    };

% corresponding dataTypes with retmodel
% retdts =        [5 5 5 10 11 7 5 6 8 7 5 7 11 7];
% imported ret models to localizer scan glm data type for some subjects
retdts = {
    'Averages' %mn
    'Averages' %ah
    'Averages' %yw
    %     'Averages' %nl
    %     'Averages' %al
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

% names of retmodels for each subject
retmodels = {
    '12degreesPRFfit-hrfFit.mat' %mn
    '12degreesPRFfit-hrfFit.mat' %ah
    '12degreesPRFfit-hrfFit.mat' %yw
    %     'retModel-20130711-083422-hrfFit.mat' %nl
    %     'retModel-20130731-133102-hrfFit.mat' %al
    '12degreesPRFfit-hrfFit.mat' %amk
    '12degreesPRFfit-hrfFit.mat' %cmb
    '12degreesPRFfit-hrfFit.mat' %dy
    '12degreesPRFfit-hrfFit.mat' %jw
    '12degreesPRFfit-hrfFit.mat' %kll
    '12degreesPRFfit-hrfFit.mat' %kw
    '12degreesPRFfit-hrfFit.mat' %mem
    'rmImported_retModel-20081015-070833-fFit.mat'  %jc
    '12degreesPRFfit-hrfFit.mat' %rb
    '12degreesPRFfit-hrfFit.mat' %acg
    '12degreesPRFfit-hrfFit.mat' %ca
    '12degreesPRFfit-hrfFit.mat' %tm
    '12degreesPRFfit-hrfFit.mat' %ta
    };
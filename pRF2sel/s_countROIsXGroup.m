% want to know how many subjects had each roi


 set(0,'defaulttextinterpreter','none');

% directory with code
% codeDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
codeDir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
addpath(codeDir);

% directory with data
% dataDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
% dataDir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';


dataDir =  '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

% subjects to use
h.controlsessions = {
    %    controls
        '42111_MN'
    '42611_AH'
    '43011_YW'
    'adult_amk_27yo_042910'
      'adult_al_22yo_051108'
    'adult_cmb_23yo_070608'
    'adult_dy_25yo_041908'
    'adult_jw_36yo_061608'
    'adult_kll_18yo_052408'
    'adult_kw_fmri2_27yo_092910'
    'adult_mem_18yo_062608'
    %         'adult_jc_27yo_052408'
    'adult_rb_22yo_101908'
    'adult_acg_39yo_012008'
    'adult_ca_22yo_061908'
    '41711_TM'
    '42811_TA'};

h.prososessions = {
    %     prosos
    '112909whFMRI'
    '082509_nj_proso'
    '020209_mr_fmri'
    '0100609jm'
    '102909mb'
    '11109km_proso'
    '52309AF'
    };




rois = {  
%     
'lV1_all_nw.mat','lV1_all_nw.Prosos.mat','lV1'
'lV2_all_nw.mat','lV2_all_nw.Prosos.mat','lV2'
'lV3_all_nw.mat','lV3_all_nw.Prosos.mat','lV3';
'lV4_all_nw.mat','lV4_all_nw.Prosos.mat','lV4';
'l_V4_fVp_001_nw.mat','l_V4_fVp_001_nw.Prosos.mat','lIOG';
'l_mfus_fVp_001_nw.mat','l_mfus_fVp_001_nw.Prosos.mat','lmFus';
'l_pfus_fVp_001_nw.mat','l_pfus_fVp_001_nw.Prosos.mat','lpFus';
'lVO1_all_nw.mat','lVO1_all_nw.Prosos.mat','lVO1';
'r_mfus_fVp_001_nw.mat','r_mfus_fVp_001_nw.Prosos.mat','rmFus';
'r_pfus_fVp_001_nw.mat','r_pfus_fVp_001_nw.Prosos.mat','rpFus';
'rV1_all_nw.mat','rV1_all_nw.Prosos.mat','rV1';
'rV2_all_nw.mat','rV2_all_nw.Prosos.mat','rV2';
'rV3_all_nw.mat','rV3_all_nw.Prosos.mat','rV3';
'rV4_all_nw.mat','rV4_all_nw.Prosos.mat','rV4';
'r_V4_fVp_001_nw.mat','r_V4_fVp_001_nw.Prosos.mat','rIOG';
'rVO1_all_nw.mat', 'rVO1_all_nw.Prosos.mat', 'rVO1';
};

% make place holder for table

roicounts = zeros(2,length(rois));


for r=1:length(rois)
%     for r =1

load([dataDir char(rois(r,1))]);

% get only subjects we are interested in 
% find index to rms we want to keep
rmindex = [];
% for each rm
for m=1:length(rm)
%     check for matching session name
    for s=1:length(h.controlsessions)
%         if it matches add rm to sbindx
        if strcmp(h.controlsessions(s),rm{m}.session)
            rmindex = [rmindex m];
        end
    end

end
% get our control data
controls = rm(rmindex);

%  count number of subjects with roi
roicounts(1,r) = length(controls);


% delete some variables
clear ECCmv rm mv
% controls

% load proso roi
load([dataDir char(rois(r,2))]);
prosos = rm;

% count number of prosos with rois
roicounts(2,r) = length(prosos);


end


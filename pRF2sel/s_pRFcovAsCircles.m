% plot visual field coverage as empty circles at sigma.  do for both the
% individuals and for the group
% need to set alpha so that density is reflected in overlap.






% directory with code
% codeDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
codeDir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
addpath(genpath(codeDir));

% directory with data
% dataDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
% dataDir =
% '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';

dataDir ='~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

% dataDir =
% '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

% rois
% these need to appear as matched triplets
% control data      prosos data        roiname
rois = {
        'lV1.flippedrV1.mat' , 'lV1.flippedrV1.Prosos.mat'    'V1';
    %     % ventral %
%         'lV2v.flippedrV2v.mat','lV2v.flippedrV2v.Prosos.mat'         'V2v';
%         'lV2d.flippedrV2d.mat' 'lV2d.flippedrV2d.Prosos.mat'     'V2d';
    %     'lV3v.flippedrV3v.mat', 'lV3v.flippedrV3v.Prosos.mat',  'V3v';
    %     'lV3d.flippedrV3d.mat' 'lV3d.flippedrV3d.Prosos.mat' 'V3d';
    %
        'lV2.flippedrV2.mat','lV2.flippedrV2.Prosos.mat' 'V2';
        'lV3.flippedrV3.mat' 'lV3.flippedrV3.Prosos.mat' 'V3';
    %
    %
        'lV4.flippedrV4.mat','lV4.flippedrV4.Prosos.mat' 'hV4';
        'lVO1.flippedrVO1.mat', 'lVO1.flippedrVO1.Prosos.mat', 'VO1';
    %
    %
    %     'lVO2.flippedrVO2.mat' 'lVO2.flippedrVO2.Prosos.mat' 'VO2FlippedLeft';
    %     % lateral
    %
    %     % faces ventral
        'l_V4_fVp.flippedr_V4_fVp.mat', 'l_V4_fVp.flippedr_V4_fVp.Prosos.mat' 'IOG';
        'l_pfus.flippedr_pfus.mat','l_pfus.flippedr_pfus.Prosos.mat'  'pFus';
        'l_mfus.flippedr_mfus.mat' 'l_mfus.flippedr_mfus.Prosos.mat' 'mFus';
    %
    %
    %     %
        'l_cos.flippedr_cos.mat', 'l_cos.flippedr_cos.Prosos.mat' 'CoSplacesflippedleft';
    %
    
    %      left and right
    %     'rV1_all_nw.mat', 'rV1_all_nw.Prosos.mat', 'rV1';
    %     'lV1_all_nw.mat', 'lV1_all_nw.Prosos.mat', 'lV1';
    %     'rV2v_all_nw.mat', 'rV2v_all_nw.Prosos.mat', 'rV2v';
    %     'lV2v_all_nw.mat', 'lV2v_all_nw.Prosos.mat', 'lV2v';
    %     'rV3v_all_nw.mat', 'rV3v_all_nw.Prosos.mat', 'rV3v';
    %     'lV3v_all_nw.mat', 'lV3v_all_nw.Prosos.mat', 'lV3v';
    %     'rV2d_all_nw.mat', 'rV2d_all_nw.Prosos.mat', 'rV2d';
    %     'lV2d_all_nw.mat', 'lV2d_all_nw.Prosos.mat', 'lV2d';
    %     'rV3d_all_nw.mat', 'rV3d_all_nw.Prosos.mat', 'rV3d';
    %     'lV3d_all_nw.mat', 'lV3d_all_nw.Prosos.mat', 'lV3d';
    %     'rV4_all_nw.mat', 'rV4_all_nw.Prosos.mat', 'rV4';
    %     'lV4_all_nw.mat', 'lV4_all_nw.Prosos.mat', 'lV4';
    %     'rVO1_all_nw.mat', 'rVO1_all_nw.Prosos.mat', 'rVO1';
    %     'lVO1_all_nw.mat', 'lVO1_all_nw.Prosos.mat', 'lVO1';
    %     'rVO2_all_nw.mat', 'rVO2_all_nw.Prosos.mat', 'rVO2';
    %     'lVO2_all_nw.mat', 'lVO2_all_nw.Prosos.mat', 'lVO2';
    %
    %     'l_V4_fVp_001_nw.mat', 'l_V4_fVp_001_nw.Prosos.mat', 'lIOG';
    %     'r_V4_fVp_001_nw.mat', 'r_V4_fVp_001_nw.Prosos.mat', 'rIOG';
    %     'l_pfus_fVp_001_nw.mat', 'l_pfus_fVp_001_nw.Prosos.mat', 'lpfus';
    %     'r_pfus_fVp_001_nw.mat', 'r_pfus_fVp_001_nw.Prosos.mat', 'rpfus';
    %     'l_mfus_fVp_001_nw.mat', 'l_mfus_fVp_001_nw.Prosos.mat', 'lmfus';
    %     'r_mfus_fVp_001_nw.mat', 'r_mfus_fVp_001_nw.Prosos.mat', 'rmfus';
    
    %     directly compare right and left prosos and controls
    %         'rV1_all_nw.mat', 'lV1_all_nw.mat', 'cV1';
    %    'rV1_all_nw.Prosos.mat', 'lV1_all_nw.Prosos.mat', 'pV1';
    %     'rV2v_all_nw.mat', 'lV2v_all_nw.mat', 'cV2v';
    %      'rV2v_all_nw.Prosos.mat', 'lV2v_all_nw.Prosos.mat', 'pV2v';
    %     'rV3v_all_nw.mat', 'lV3v_all_nw.mat', 'cV3v';
    %    'rV3v_all_nw.Prosos.mat', 'lV3v_all_nw.Prosos.mat', 'pV3v';
    %     'rV2d_all_nw.mat', 'lV2d_all_nw.mat', 'cV2d';
    %      'rV2d_all_nw.Prosos.mat', 'lV2d_all_nw.Prosos.mat', 'pV2d';
    %     'rV3d_all_nw.mat','lV3d_all_nw.mat', 'cV3d';
    %     'rV3d_all_nw.Prosos.mat', 'lV3d_all_nw.Prosos.mat', 'pV3d';
    %     'rV4_all_nw.mat', 'lV4_all_nw.mat', 'cV4';
    %     'rV4_all_nw.Prosos.mat', 'lV4_all_nw.Prosos.mat', 'pV4';
    %     'rVO1_all_nw.mat', 'lVO1_all_nw.mat', 'cVO1';
    %     'rVO1_all_nw.Prosos.mat', 'lVO1_all_nw.Prosos.mat', 'pVO1';
    %     'rVO2_all_nw.mat', 'lVO2_all_nw.mat', 'cVO2';
    %     'rVO2_all_nw.Prosos.mat', 'lVO2_all_nw.Prosos.mat', 'pVO2';
    
    %     'l_V4_fVp_001_nw.mat','r_V4_fVp_001_nw.mat', 'cIOG';
    %      'l_V4_fVp_001_nw.Prosos.mat', 'r_V4_fVp_001_nw.Prosos.mat', 'pIOG';
    %     'l_pfus_fVp_001_nw.mat','r_pfus_fVp_001_nw.mat', 'cpfus';
    %      'l_pfus_fVp_001_nw.Prosos.mat', 'r_pfus_fVp_001_nw.Prosos.mat', 'ppfus';
    %     'l_mfus_fVp_001_nw.mat', 'r_mfus_fVp_001_nw.mat', 'cmfus';
    %     'l_mfus_fVp_001_nw.Prosos.mat', 'r_mfus_fVp_001_nw.Prosos.mat',
    %     'pmfus';
    
%     % left vs right but don't split dorsal and ventral v2/v3
%     'rV1_all_nw.mat', 'lV1_all_nw.mat', 'cV1';
%     'rV2_all_nw.mat', 'lV2_all_nw.mat', 'cV2';
%     'rV3_all_nw.mat', 'lV3_all_nw.mat', 'cV3';
%     'rV4_all_nw.mat', 'lV4_all_nw.mat', 'cV4';
%     'rVO1_all_nw.mat', 'lVO1_all_nw.mat', 'cVO1';
%     'rVO2_all_nw.mat', 'lVO2_all_nw.mat', 'cVO2';
%     'r_V4_fVp_001_nw.mat','l_V4_fVp_001_nw.mat', 'cIOG';
%     'r_pfus_fVp_001_nw.mat', 'l_pfus_fVp_001_nw.mat', 'cpfus';
%     'r_mfus_fVp_001_nw.mat', 'l_mfus_fVp_001_nw.mat',  'cmfus';
%     
%      'rV1_all_nw.Prosos.mat', 'lV1_all_nw.Prosos.mat', 'cV1';
%     'rV2_all_nw.Prosos.mat', 'lV2_all_nw.Prosos.mat', 'cV2';
%     'rV3_all_nw.Prosos.mat', 'lV3_all_nw.Prosos.mat', 'cV3';
%     'rV4_all_nw.Prosos.mat', 'lV4_all_nw.Prosos.mat', 'cV4';
%     'rVO1_all_nw.Prosos.mat', 'lVO1_all_nw.Prosos.mat', 'cVO1';
%     'rVO2_all_nw.Prosos.mat', 'lVO2_all_nw.Prosos.mat', 'cVO2';
%     'r_V4_fVp_001_nw.Prosos.mat','l_V4_fVp_001_nw.Prosos.mat', 'cIOG';
%     'r_pfus_fVp_001_nw.Prosos.mat', 'l_pfus_fVp_001_nw.Prosos.mat', 'cpfus';
%     'r_mfus_fVp_001_nw.Prosos.mat', 'l_mfus_fVp_001_nw.Prosos.mat',  'cmfus';
    };


% thresholds on roi and plotting
% optimally, this could be done once but its a lot of working code to fix
% threshold
h.threshco = 0;
h.threshecc = [0 24];
h.threshsigma = [0 24];
h.binsize = 1;
h.minvoxelcount = 0;

% should be datadir FullAnalysis / threshold / SubjectsUsed / ROI/
threshstring =  ['co' num2str(h.threshco) ...
    '.ecc' num2str(h.threshecc(1)) '_' num2str(h.threshecc(2)) '.sig' ...
    num2str(h.threshsigma(1)) '_' num2str(h.threshsigma(2)) '/'];


% subjects to use
h.sessions = {
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
    %             'adult_jc_27yo_052408'
    'adult_rb_22yo_101908'
    'adult_acg_39yo_012008'
    'adult_ca_22yo_061908'
    '41711_TM'
    '42811_TA'
    
    
    
    %     prosos
    '112909whFMRI'
    '082509_nj_proso'
    '020209_mr_fmri'
    '0100609jm'
    '102909mb'
    '11109km_proso'
    '52309AF'
    };


subsused = 'Allsubs/';
% subsused ='subsNoKWKLLTMDY/';
% subsused = 'subsNocakwcmbmemV1varmatched/';

h.saveDir = [dataDir 'FullAnalysis/' threshstring subsused];


% load rms from controls into workspace
load([dataDir char(rois(1,1))]);

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

% load proso roi
load([dataDir char(rois(1,2))]);
prosos = rm;

% unload excess variables
clear mv rm ECCmv;


% threshold data




% make individual plots






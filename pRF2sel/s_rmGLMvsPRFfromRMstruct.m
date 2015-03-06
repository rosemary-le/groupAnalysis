
% want to be able to extract somemething from a set of voxels for a glm and
% a prf and compare them

%want to compare a measure from the glm to a measure from the prf fits for
%the same voxels


%clean up plots
 set(0,'defaulttextinterpreter','none');

% directory with code
% codeDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
codeDir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
addpath(codeDir);

% directory with data (where are pRF2Sel files are)
% dataDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
% dataDir =
% '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
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


% rois
% these need to appear as matched triplets
% apparently when I made the both ROI I didn't combine the mv and ECC files
% as well  so another bookkeeping problem to solve
% control data      prosos data        roiname
rois = {  
%        'bothV1_all_nw.mat', 'bothV1_all_nw.Prosos.mat', 'bothV1';
% 'rV1_all_nw.mat', 'rV1_all_nw.Prosos.mat','rV1';
%   'bothV2_all_nw.mat','bothV2_all_nw.Prosos.mat','bothV2';
%    'bothV3_all_nw.mat','bothV3_all_nw.Prosos.mat','bothV3';
% % %    'bothV2v_all_nw','bothV2v_all_nw.Prosos','bothV2v';
% % %     'bothV3v_all_nw','bothV3v_all_nw.Prosos','bothV3v';
%     'bothV4_all_nw.mat','bothV4_all_nw.Prosos.mat','bothV4';
% % %     'bothV2d_all_nw','bothV2d_all_nw.Prosos','bothV2d';
% % %   'bothV3d_all_nw','bothV3d_all_nw.Prosos','bothV3d';
% % % % % %     % ventral
%   'bothVO1_all_nw.mat','bothVO1_all_nw.Prosos.mat','bothVO1';
%   'bothVO2_all_nw.mat','bothVO2_all_nw.Prosos.mat','bothVO2';
% % % % % %     face rois
% %     % % face rois
%     'both_V4_fVp_001_nw.mat','both_V4_fVp_001_nw.Prosos.mat','bothIOG';
%     'r_V4_fVp_001_nw.mat','r_V4_fVp_001_nw.Prosos.mat','rIOG';

%     'both_V4_fVp_001_nw.mat','both_V4_fVp_001_nw.Prosos.mat','bothIOG';
%    'both_pfus_fVp_001_nw.mat','both_pfus_fVp_001_nw.Prosos.mat','bothpFus';
%   'r_pfus_fVp_001_nw.mat','r_pfus_fVp_001_nw.Prosos.mat','rPfus';
%      'both_mfus_fVp_001_nw.mat','both_mfus_fVp_001_nw.Prosos.mat','bothmFus';
   'r_cos_pVf_001_nw.mat','r_cos_pVf_001_nw.Prosos.mat','rCos';
};



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
controlrms = rm(rmindex);
controllocs = mv(rmindex);
controlecc = ECCmv(rmindex);

% load proso roi
load([dataDir char(rois(1,2))]);
prosorms = rm;
prosolocs = mv;
prosoecc = ECCmv;

% unload excess variables
clear mv rm ECCmv;

% should threshold our pRFs however we would like

% threshold
h.threshco = 0.1;
h.threshecc = [0 12];
h.threshsigma = [1 24];
h.minvoxelcount = 10; %minimum number of voxels in roi

% threshold the data
th_controls = f_thresholdRMData(controlrms,h);

th_prosos = f_thresholdRMData(prosorms,h);


% now need to threshold glm data we are interested in

% % need to compute a contrast for each glm
% function mv = mvContrastCompute(mv,cname,condnames1, condnames2);
for g=1:length(controllocs)
controllocs(g) = mvContrastCompute(controllocs(g),'facesVSscenes',...
        {'man' 'child'},{'indoor','outdoor'});
end



% have a function called mvVSrmPlot.m
% function mvVSrmPlot(mv, rm, mvVar, rmVar, cname, rmvarthresh, eccbounds)

% mvVSrmPlot(controllocs, controlrms, 'tval','sigma','facesVSscenes',.1,[0 12])
mvVSrmPlot(controllocs, controlrms, 'tval','ecc','facesVSscenes',.1,[0 12])


% now need to threshold glm data we are interested in



% % need to compute a contrast for each glm
% function mv = mvContrastCompute(mv,cname,condnames1, condnames2);
for g=1:length(prosolocs)
prosolocs(g) = mvContrastCompute(prosolocs(g),'facesVSscenes',...
        {'man' 'child'},{'indoor','outdoor'});
end
% have a function called mvVSrmPlot.m
% function mvVSrmPlot(mv, rm, mvVar, rmVar, cname, rmvarthresh, eccbounds)

mvVSrmPlot(prosolocs, prosorms, 'tval','ecc','facesVSscenes',.1,[0 12])


% would be nice if had dist

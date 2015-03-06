% function PRF_sizeXeccPlotsFromROI(roiFile,thresh,savedir)

% want this funtion to take a .mat file as an argument.
% that file should contain the rm params for n subjects
% given that and some parameters (thresholds), make a group size vs.
% eccentricity plot, as well as subplots for each subject.
% roiFile is path to roi that looks like


% thresh is a struct with the followin fields
% thresh.varexp  minimum variance explained by model in each voxel 0-1
% default is .1
% thresh.sig  min and max sigma (size) to use [0 14]
% default is [.5 28]
% thresh.ecc is mim and max ecc to use, default is [.5 13.5]
% thresh.binsize =  how to bin on x axis 0.5


% set some variables
% directory with .mat files
roidir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
% roidir ='~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';


% roi names
%
%
% % % % % % % % % % % % % % % % % % % % % % % controls
% % % % % % % % % % % % % % % % % % % % % % %
% rois = {
% 'bothV1_all_nw.mat'
% % ventral
% 'bothV2v_all_nw.mat'
% 'bothV3v_all_nw.mat'
% 'bothV4_all_nw.mat'
% 'bothVO1_all_nw.mat'
% %     'bothVO2_all_nw.mat','bothVO2_all_nw.Prosos.mat';
% %     'bothVO2_all_nw.mat','bothVO2_all_nw.Prosos.mat';
% % lateral
% 'bothV2d_all_nw.mat'
% 'bothV3d_all_nw.mat'
% 'bothLO1_all_nw.mat'
% 'bothLO2_all_nw.mat'
% 'bothV3ab_all_nw.mat'
% 'bothIPS0_all_nw.mat'
% % ventral
% % 'rV1_all_nw.mat'
% % 'lV1_all_nw.mat'
% % % ventral
% % 'rV2v_all_nw.mat'
% % 'lV2v_all_nw.mat'
% % 'rV3v_all_nw.mat'
% % 'lV3v_all_nw.mat'
% % 'rV4_all_nw.mat'
% % 'lV4_all_nw.mat'
% % 'rVO1_all_nw.mat'
% % 'lVO1_all_nw.mat'
% % 'rVO2_all_nw.mat'
% % 'lVO2_all_nw.mat'
% % % lateral
% % 'rV2d_all_nw.mat'
% % 'lV2d_all_nw.mat'
% % 'rV3d_all_nw.mat'
% % 'lV3d_all_nw.mat'
% % 'rLO1_all_nw.mat'
% % 'lLO1_all_nw.mat'
% % 'rLO2_all_nw.mat'
% % 'lLO2_all_nw.mat'
% % % parietal
% % 'rV3ab_all_nw.mat'
% % 'lV3ab_all_nw.mat'
% % 'rIPS0_all_nw.mat'
% % 'lIPS0_all_nw.mat'
% % 'rIPS1_all_nw.mat'
% % 'lIPS1_all_nw.mat'
% % % faces ventral
% 'l_mfus_fVp_001_nw.mat'
% 'l_pfus_fVp_001_nw.mat'
% 'l_V4_fVp_001_nw.mat'
% 'r_mfus_fVp_001_nw.mat'
% 'r_pfus_fVp_001_nw.mat'
% 'r_V4_fVp_001_nw.mat'
% 'lPHC2pVf.flippedrPHC2pVf.mat'
% 'lPHC1pVf.flippedrPHC1pVf.mat'
% 'lVO2pVf.flippedrVO2pVf.mat'
% 'lVO1pVf.flippedrVO1pVf.mat'
%     'lV4.flippedrV4.mat'
%         'l_cos.flippedr_cos.mat'
% % % places ventral
% % 'l_cos_pVf_001_nw.mat'
% % 'r_cos_pVf_001_nw.mat'
% 'both_PHCanatXcospvf_nw'
% 'both_VOanatXcospvf_nw'
% 'l_antHIPPanatXcospvf_nw'
% 'l_PHCanatXcospvf_nw'
% 'l_VOanatXcospvf_nw'
% 'r_antHIPPanatXcospvf_nw'
% 'r_PHCanatXcospvf_nw'
% 'r_VOanatXcospvf_nw'
% 'rVO1_all_and_pVf_001_nw'
% 'lVO1_all_and_pVf_001_nw'
% 'rVO2_all_and_pVf_001_nw'
% 'lVO2_all_and_pVf_001_nw'
% 'rPHC1_all_and_pVf_001_nw'
% 'lPHC1_all_and_pVf_001_nw'
% 'rPHC2_all_and_pVf_001_nw'
% 'lPHC2_all_and_pVf_001_nw'
% 'both_V4_all_and_pVf_001_nw'
% 'both_VO1_all_and_pVf_001_nw'
% 'both_VO2_all_and_pVf_001_nw'
% 'both_PHC1_all_and_pVf_001_nw'
% 'both_PHC2_all_and_pVf_001_nw'
% 'r_PHC_all_and_pVf_001_nw'
% 'l_PHC_all_and_pVf_001_nw'
% 'r_VO_all_and_pVf_001_nw'
% 'l_VO_all_and_pVf_001_nw'

% };
% % % %
% % % % % savedirectory
% savedir = [roidir 'sizeXeccplotsVSS1sigma/'];
%



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % prosos
rois = {
%     'bothV1_all_nw.Prosos.mat'
%     % ventral
%     'bothV2v_all_nw.Prosos.mat'
%     'bothV3v_all_nw.Prosos.mat'
%     'bothV4_all_nw.Prosos.mat'
%     'bothVO1_all_nw.Prosos.mat'
%     %     'bothVO2_all_nw.mat','bothVO2_all_nw.Prosos.mat';
%     %     'bothVO2_all_nw.mat','bothVO2_all_nw.Prosos.mat';
%     % lateral
%     'bothV2d_all_nw.Prosos.mat'
%     'bothV2d_all_nw.Prosos.mat'
%     'bothV3d_all_nw.Prosos.mat'
%     'bothV3d_all_nw.Prosos.mat'
%     'bothLO1_all_nw.prosos.mat'
%     'bothLO2_all_nw.prosos.mat'
%     'bothV3ab_all_nw.prosos.mat'
%     'bothIPS0_all_nw.prosos.mat'
%     'rV1_all_nw.Prosos.mat'
%     'lV1_all_nw.Prosos.mat'
%     % % ventral
%     'rV2v_all_nw.Prosos.mat'
%     'lV2v_all_nw.Prosos.mat'
%     'rV3v_all_nw.Prosos.mat'
%     'lV3v_all_nw.Prosos.mat'
%     'rV4_all_nw.Prosos.mat'
%     'lV4_all_nw.Prosos.mat'
%     'rVO1_all_nw.Prosos.mat'
%     'lVO1_all_nw.Prosos.mat'
%     'rVO2_all_nw.Prosos.mat'
%     'lVO2_all_nw.Prosos.mat'
%     % % lateral
%     'rV2d_all_nw.Prosos.mat'
%     'lV2d_all_nw.Prosos.mat'
%     'rV3d_all_nw.Prosos.mat'
%     'lV3d_all_nw.Prosos.mat'
%     'rLO1_all_nw.Prosos.mat'
%     'lLO1_all_nw.Prosos.mat'
%     'rLO2_all_nw.Prosos.mat'
%     'lLO2_all_nw.Prosos.mat'
%     % parietal
%     'rV3ab_all_nw.Prosos.mat'
%     'lV3ab_all_nw.Prosos.mat'
%     'rIPS0_all_nw.Prosos.mat'
%     'lIPS0_all_nw.Prosos.mat'
% %     'rIPS1_all_nw.14-Apr-2014.Prosos.mat'
% %     'lIPS1_all_nw.14-Apr-2014.Prosos.mat'
%     % faces ventral
    'l_mfus_fVp_001_nw.Prosos.mat'
%     'l_pfus_fVp_001_nw.Prosos.mat'
%     'l_V4_fVp_001_nw.Prosos.mat'
    'r_mfus_fVp_001_nw.Prosos.mat'
%     'r_pfus_fVp_001_nw.Prosos.mat'
%     'r_V4_fVp_001_nw.Prosos.mat'
%     % places ventral
%     'l_cos_pVf_001_nw.Prosos.mat'
%     'r_cos_pVf_001_nw.Prosos.mat'
    };
% % savedirectory
savedir = [roidir 'sizeXeccplotsProsos/'];

% theshold to use
thresh.varexp =.1;
thresh.sig = [1 24];
thresh.ecc = [0 11.5];
thresh.binsize =  1;



for r=1:length(rois)
    %     make sure savedir exists
%     if ~exist(savedir)
%         mkdir(savedir)
%     end
    %     set path to roi .mat file
    roiFile=[roidir rois{r}];
    %     make and save plots
    PRF_sizeXeccPlotsFromROI(roiFile,thresh,savedir)
end
%  script which given a .mat file containing the prf models for an roi
%  generates various histograms of a pRF parameter

% add our code to the path
% addpath('/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');
addpath('~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');


% assumes we are in directory with these variables
% cd '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
cd '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';


% roi
rois = {
%     'lV1.flippedrV1.mat'
% %     %     ventral
%     'lV2v.flippedrV2v.mat'
%     'lV3v.flippedrV3v.mat'
    'lV4.flippedrV4.mat'
%     'lVO1.flippedrVO1.mat'
%     'lVO2.flippedrVO2.mat'
%     'lPHC1.flippedrPHC1.mat'
%     'lPHC2.flippedrPHC2.mat';
%     % lateral
%     'lV2d.flippedrV2d.mat'
%     'lV3d.flippedrV3d.mat'
%     'lLO1.flippedrLO1.mat'
%     'lLO2.flippedrLO2.mat'
%     %     % parietal
%     'lV3ab.flippedrV3ab.mat'
%     'lIPS0.flippedrIPS0.mat'
%     'lIPS1.flippedrIPS1.mat'
%     %     % faces ventral
%     'l_mfus.flippedr_mfus.mat'
%     'l_pfus.flippedr_pfus.mat'
%     'l_V4_fVp.flippedr_V4_fVp.mat'
%     %     % places ventral
%     'l_cos.flippedr_cos.mat'
%     'r_cos_pVf_001_nw.mat'
%     'r_mfus_fVp_001_nw.mat'
%     'r_pfus_fVp_001_nw.mat'
%     'r_V4_fVp_001_nw.mat'
%     'rV1_all_nw.mat'
%     'rV2v_all_nw.mat'
%     'rV2d_all_nw.mat'
%     'rV3v_all_nw.mat'
%     'rV3d_all_nw.mat'
%     'rV4_all_nw.mat'
%     'rVO1_all_nw.mat'
%     'rVO2_all_nw.mat'
%     'rPHC1_all_nw.mat'
%     'rPHC2_all_nw.mat'
%     'rV3ab_all_nw.mat'
%     'rLO1_all_nw.mat'
%     'rLO2_all_nw.mat'
%     'rTO1_all_nw.mat'
%     'rTO2_all_nw.mat'
%     'l_cos_pVf_001_nw.mat'
%     'l_mfus_fVp_001_nw.mat'
%     'l_pfus_fVp_001_nw.mat'
%     'l_V4_fVp_001_nw.mat'
%     'lV1_all_nw.mat'
%     'lV2v_all_nw.mat'
%     'lV2d_all_nw.mat'
%     'lV3v_all_nw.mat'
%     'lV3d_all_nw.mat'
%     'lV4_all_nw.mat'
%     'lVO1_all_nw.mat'
%     'lVO2_all_nw.mat'
%     'lPHC1_all_nw.mat'
%     'lPHC2_all_nw.mat'
%     'lV3ab_all_nw.mat'
%     'lLO1_all_nw.mat'
%     'lLO2_all_nw.mat'
%     'lTO1_all_nw.mat'
%     'lTO2_all_nw.mat'
    % %     'bothIPS0_all_nw.mat'
    % %     'bothIPS1_all_nw.mat'
    % %     'bothLO1_all_nw.mat'
    % %     'bothLO2_all_nw.mat'
    % %     'bothPHC1_all_nw.mat'
    % %     'bothPHC2_all_nw.mat'
    % %     'bothTO1_all_nw.mat'
    % %     'bothTO2_all_nw.mat'
    % %     'bothV1_all_nw.mat'
    % %     'bothV2d_all_nw.mat'
    % %     'bothV2v_all_nw.mat'
    % %     'bothV3ab_all_nw.mat'
    % %     'bothV3d_all_nw.mat'
    % %     'bothV3v_all_nw.mat'
    % %     'bothV4_all_nw.mat'
    % %     'bothVO1_all_nw.mat'
%     'both_PHCanatXcospvf_nw'
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
% % 'both_V4_all_and_pVf_001_nw'
% 'both_VO1_all_and_pVf_001_nw'
% 'both_VO2_all_and_pVf_001_nw'
% 'both_PHC1_all_and_pVf_001_nw'
% 'both_PHC2_all_and_pVf_001_nw'
% 'r_PHC_all_and_pVf_001_nw'
% 'l_PHC_all_and_pVf_001_nw'
% 'r_VO_all_and_pVf_001_nw'
% 'l_VO_all_and_pVf_001_nw'
'lPHC2pVf.flippedrPHC2pVf.mat'
'lPHC1pVf.flippedrPHC1pVf.mat'
'lVO2pVf.flippedrVO2pVf.mat'
'lVO1pVf.flippedrVO1pVf.mat'
% 'l_antHIPPanatXcospvf.flippedr.mat'
    };

% param to plot

h.param = 'ecc';

% co coherence
% sigma1 sigma
% x0 x position
% y0 yposition
% ph phase
% ecc eccentricity

h.max = 24;

% bins
h.bins = [0 12];

% binsize
h.binsize = 3;

% for uneven binsizes
h.ubins = [h.bins(1):h.binsize:h.bins(2)-h.binsize h.max]; 

% threshold
h.threshco = 0.1;
h.threshecc = [0 12];
h.threshsigma = [0 24];


% directory to save figures in

% h.savedir='/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/combinedhistssigma1/';
h.savedir ='~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/combinedhistssigma1ubins/';

if ~exist(h.savedir)
    mkdir(h.savedir);
end


% do it!

for i = 1:length(rois)
    makePRFhists(rois{i},h);
end
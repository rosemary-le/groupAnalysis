% want to take some rois, let's say right in this case, and flip the x
% value (i.e. multiply by -1).  while there are some left right differences
% for the purposes of some figures its nice to be able to average across
% all the rois.

clx

% directory with .mat files
roidir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';

% rois we want to flip.  let's do right flipped for now
roistoflip ={
%             'rV1_all_nw.mat'
% %         'lV1_all_nw.mat'
% %         % ventral
%         'rV2v_all_nw.mat'
% %         'lV2v_all_nw.mat'
%         'rV3v_all_nw.mat'
% %         'lV3v_all_nw.mat'
%         'rV4_all_nw.mat'
% %         'lV4_all_nw.mat'
%         'rVO1_all_nw.mat'
% %         'lVO1_all_nw.mat'
%         'rVO2_all_nw.mat'
% %         'lVO2_all_nw.mat'
%         'rPHC1_all_nw.mat'
%         'rPHC2_all_nw.mat'
% %         % lateral
%         'rV2d_all_nw.mat'
% %         'lV2d_all_nw.mat'
%         'rV3d_all_nw.mat'
% %         'lV3d_all_nw.mat'
%         'rLO1_all_nw.mat'
% %         'lLO1_all_nw.mat'
%         'rLO2_all_nw.mat'
% %         'lLO2_all_nw.mat'
%         'rTO1_all_nw.mat'
%         'rTO1_all_nw.mat'
% %     %     % parietal
%     'rV3ab_all_nw.mat'
% %     'lV3ab_all_nw.mat'
%     'rIPS0_all_nw.mat'
% %     'lIPS0_all_nw.mat'
%     'rIPS1_all_nw.mat'
% %     'lIPS1_all_nw.mat'
% %     % faces ventral
% %     'l_mfus_fVp_001_nw.mat'
% %     'l_pfus_fVp_001_nw.mat'
% %     'l_V4_fVp_001_nw.mat'
%     'r_mfus_fVp_001_nw.mat'
%     'r_pfus_fVp_001_nw.mat'
%     'r_V4_fVp_001_nw.mat'
% %     % places ventral
% %     'l_cos_pVf_001_nw.mat'
%     'r_cos_pVf_001_nw.mat'
    
% % % % % % % % % % % % % % % %     
% % % % % % % % prosos
% % % % % % % % % 
'r_cos_pVf_001_nw.Prosos.mat'
    'r_mfus_fVp_001_nw.Prosos.mat'
    'r_pfus_fVp_001_nw.Prosos.mat'
    'r_V4_fVp_001_nw.Prosos.mat'
    'rV1_all_nw.Prosos.mat'
    'rV2v_all_nw.Prosos.mat'
    'rV2d_all_nw.Prosos.mat'
    'rV3v_all_nw.Prosos.mat'
    'rV3d_all_nw.Prosos.mat'
    'rV4_all_nw.Prosos.mat'
    'rVO1_all_nw.Prosos.mat'
    'rVO2_all_nw.Prosos.mat'
    'rPHC1_all_nw.Prosos.mat'
    'rPHC2_all_nw.Prosos.mat'
    'rV3ab_all_nw.Prosos.mat'
    'rLO1_all_nw.Prosos.mat'
    'rLO2_all_nw.Prosos.mat'
    'rTO1_all_nw.Prosos.mat'
    'rTO2_all_nw.Prosos.mat'
    
    
    
    };

% go to the directory
cd(roidir);

for r=1:length(roistoflip)
%     load the roi
    load(roistoflip{r});
%     flip the x values in the rm struct
    for i=1:length(rm)
        rm{i}.x0=-1*rm{i}.x0;
    end
%     save with new name
   save(['flippedx0.' roistoflip{r}]);
end
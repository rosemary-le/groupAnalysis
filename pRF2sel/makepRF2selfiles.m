% script for generating .mat files which contain for a given roi (eg V1)
% the prf models for each voxel, the localizer glm for each voxel, and the
% eccentricity glm for each voxel.


% first set some variables for creating the files, paths to data, sessions
% for each type of analysis etc

set_pRF2selVars;


% set_pRF2selVarsProsos;

% list of rois to generate files for
% % ret rois
rois ={
    %     % confluent
%     'bothV1_all_nw'
%     'bothV2v_all_nw'
%     'bothV3v_all_nw'
%     'bothV4_all_nw'
%     'bothV2d_all_nw'
%     'bothV3d_all_nw'
% % %     % ventral
%     'bothVO1_all_nw'
%     'bothVO1_all_nw'
%     'bothPHC1_all_nw'
%     'bothPHC2_all_nw'
% %     %lateral
%     'bothTO1_all_nw'
%     'bothTO2_all_nw'
%     'bothLO1_all_nw'
%     'bothLO2_all_nw'
% %     %dorsal
%     'bothV3ab_all_nw'
%     'bothIPS0_all_nw'
%     'bothIPS1_all_nw'
%     'rIPS2_all_nw'
%     'rIPS3_all_nw'
%     'rIPS4_all_nw'
%     'rIPS5_all_nw'
%     'rIPS6_all_nw'
%     'lV3ab_all_nw'
%     'lIPS0_all_nw'
%     'lIPS1_all_nw'

% %     % confluent
%     'rV1_all_nw'
%     'lV1_all_nw'
%     'rV2v_all_nw'
%     'lV2v_all_nw'
%     'rV3v_all_nw'
%     'lV3v_all_nw'
%     'rV4_all_nw'
%     'lV4_all_nw'
%     'rV2d_all_nw'
%     'rV3d_all_nw'
%     'lV2d_all_nw'
%     'lV3d_all_nw'
% % % %     % ventral
%     'rVO1_all_nw'
%     'rVO2_all_nw'
%     'lVO1_all_nw'
%     'lVO2_all_nw'
%     'rPHC1_all_nw'
%     'rPHC2_all_nw'
%     'lPHC1_all_nw'
%     'lPHC2_all_nw'
% % %     %lateral
%     'rTO1_all_nw'
%     'rTO2_all_nw'
%     'lTO1_all_nw'
%     'lTO2_all_nw'
%     'rLO1_all_nw'
%     'rLO2_all_nw'
%     'lLO1_all_nw'
%     'lLO2_all_nw'
% % %     %dorsal
%     'rV3ab_all_nw'
%     'rIPS0_all_nw'
%     'rIPS1_all_nw'
% % %     'rIPS2_all_nw'
% % %     'rIPS3_all_nw'
% % %     'rIPS4_all_nw'
% % %     'rIPS5_all_nw'
% % %     'rIPS6_all_nw'
%     'lV3ab_all_nw'
%     'lIPS0_all_nw'
%     'lIPS1_all_nw'
% %     'lIPS2_all_nw'
% %     'lIPS3_all_nw'
% %     'lIPS4_all_nw'
% %     'lIPS5_all_nw'
% %     'lIPS6_all_nw'
% % ret vs cat rois
% % 'both_PHC1_and_pVf_001_all_nw'
% % 'both_PHC1_and_pVo_001_all_nw'
% % 'both_PHC2_and_pVf_001_all_nw'
% % 'both_PHC_and_pVf_001_all_nw'
% % 'both_PHC_and_pVo_001_all_nw'
% % 'both_VO1_and_pVf_001_all_nw'
% % 'both_VO1_and_pVo_001_all_nw'
% % 'both_VO2_and_pVf_001_all_nw'
% % 'both_VO2_and_pVo_001_all_nw'
% % 'both_VO_and_pVf_001_all_nw'
% % 'both_VO_and_pVo_001_all_nw'
% % 'both_anthipp_pVf_001_all_nw'
% % 'both_nonret_ppa_pVf_001_all_nw'
% % 
% % 'lVO1_and_pVf_001_all_nw'
% % 'lVO1_and_pVo_001_all_nw'
% % 
% % 'lVO2_and_pVf_001_all_nw'
% % 'lVO2_and_pVo_001_all_nw'
% % 
% % 'lPHC1_and_pVf_001_all_nw'
% % 'lPHC1_and_pVo_001_all_nw'
% % 
% % 'lPHC2_and_pVf_001_all_nw'
% % 'lPHC2_and_pVo_001_all_nw'
% % 
% % 'rVO1_and_pVf_001_all_nw'
% % 'rVO1_and_pVo_001_all_nw'
% % 
% % 'rVO2_and_pVf_001_all_nw'
% % 'rVO2_and_pVo_001_all_nw'
% % 
% % 'rPHC1_and_pVf_001_all_nw'
% % 'rPHC1_and_pVo_001_all_nw'
% % 
% % 'rPHC2_and_pVf_001_all_nw'
% % 'rPHC2_and_pVo_001_all_nw'
% % 
% % 'r_anthipp_pVf_001_all_nw'
% % 
% % 'r_LO1_and_pVf_p001_all_nw';
% % 'r_LO2_and_pVf_p001_all_nw';
% % 'r_TO1_and_pVf_p001_all_nw';
% % 'r_TO2_and_pVf_p001_all_nw';
% % 'r_V3ab_and_pVf_p001_all_nw';
% % 'r_IPS0_and_pVf_p001_all_nw';
% % 'r_IPS1_and_pVf_p001_all_nw';
% % 'r_IPS2_and_pVf_p001_all_nw';
% % 'r_IPS3_and_pVf_p001_all_nw';
% % 'l_LO1_and_pVf_p001_all_nw';
% % 'l_LO2_and_pVf_p001_all_nw';
% % 'l_TO1_and_pVf_p001_all_nw';
% % 'l_TO2_and_pVf_p001_all_nw';
% % 'l_V3ab_and_pVf_p001_all_nw';
% % 'l_IPS0_and_pVf_p001_all_nw';
% % 'l_IPS1_and_pVf_p001_all_nw';
% % 'l_IPS2_and_pVf_p001_all_nw';
% % 'l_IPS3_and_pVf_p001_all_nw';
% % 
% 
% % face rois
% % 
% 'l_V4_fVp_001_nw'
% 'r_V4_fVp_001_nw'
% 'l_pfus_fVp_001_nw'
% 'r_pfus_fVp_001_nw'
% 'l_mfus_fVp_001_nw'
% 'r_mfus_fVp_001_nw'
% 'r_fusiform_fVp_nw'
% 'l_fusiform_fVp_nw'
% 'all_fusiform_fVp_nw'
% 'r_ventral_fVp_nw'
% 'l_ventral_fVp_nw'
% 'all_ventral_fVp_nw'
% % % 
% % % % % % place rois
% % % 
% 'l_cos_pVf_001_nw'
% 'r_cos_pVf_001_nw'
% 
% % anat + ret cos rois layer 1
% 'both_antHIPPanatXcospvf_all_nw'
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
% 'both_ffa_fVp_001_nw'
% 'both_mfus_fVp_001_nw'
% 'both_pfus_fVp_001_nw'
% 'both_V4_fVp_001_nw'
'rV2_all_nw'
'lV2_all_nw'
'rV3_all_nw'
'lV3_all_nw'
};



% make the files
for r = 1:length(rois)
    roi=rois{r};
    pRF2sel;
    save([savedir roi '.mat' ], 'rm', 'ECCmv', 'mv');
    % clear all
    clear rm ECCmv mv hV
end



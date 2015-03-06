% sometimes it is simplest to combine the prf2sel output for different
% rois.  for example, to do v1 without respect to hemisphere, we can just
% combine lV1 and flippedx.rV1.


clx

% directory with .mat files
% roidir =
% '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles';
% roidir =
% '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles';
roidir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles';

% rois to combine
% example
% roi1 = 'lV1_all_nw.mat';
% roi2 = 'flippedx0.rV1_all_nw.mat';
% saveroi = 'lV1.flippedrV1.mat';



roi1 ={
% %     'lV1_all_nw.mat'
% %     % ventral
% %     'lV2v_all_nw.mat'
% %     'lV3v_all_nw.mat'
    'lV4_all_nw.mat'
    'lVO1_all_nw.mat'
% %     'lVO2_all_nw.mat'
% %         'lPHC1_all_nw.mat'
% %     'lPHC2_all_nw.mat'
%     % lateral
% %     'lV2d_all_nw.mat'
% %     'lV3d_all_nw.mat'
% %     'lLO1_all_nw.mat'
% %     'lLO2_all_nw.mat'
% %     %     % parietal
% %     'lV3ab_all_nw.mat'
% %     'lIPS0_all_nw.mat'
% %     'lIPS1_all_nw.mat'
% %     % faces ventral
% %     'l_mfus_fVp_001_nw.mat'
% %     'l_pfus_fVp_001_nw.mat'
% %     'l_V4_fVp_001_nw.mat'
% %         'l_ventral_fVp_nw.mat
% %     % places ventral
% %     'l_cos_pVf_001_nw.mat'
% % 'lPHC2_all_and_pVf_001_nw.mat'
% % 'lPHC1_all_and_pVf_001_nw.mat'
% % 'lVO2_all_and_pVf_001_nw.mat'
% % 'lVO1_all_and_pVf_001_nw.mat'
% % 'l_antHIPPanatXcospvf_nw.mat'
% 'l_cos_pVf_001_nw.Prosos.mat';
% 'l_mfus_fVp_001_nw.Prosos.mat';
% 'l_pfus_fVp_001_nw.Prosos.mat';
% 'l_V4_fVp_001_nw.Prosos.mat';
%         'l_ventral_fVp_nw.Prosos.mat';
% 'lV1_all_nw.Prosos.mat';
% 'lV2v_all_nw.Prosos.mat';
% 'lV2d_all_nw.Prosos.mat';
% 'lV3v_all_nw.Prosos.mat';
% 'lV3d_all_nw.Prosos.mat';
% 'lV4_all_nw.Prosos.mat';
% 'lVO1_all_nw.Prosos.mat';
% 'lVO2_all_nw.Prosos.mat';
% % 'lPHC1_all_nw.Prosos.mat';
% % 'lPHC2_all_nw.Prosos.mat';
% % % 'lV3ab_all_nw.Prosos.mat';
% 'lLO1_all_nw.Prosos.mat';
% 'lLO2_all_nw.Prosos.mat';
% 'lTO1_all_nw.Prosos.mat';
% 'lTO2_all_nw.Prosos.mat';

% % % % combined dorsal/ventral v32/v3
%  'lV2_all_nw.mat';
%  'lV2_all_nw.Prosos.mat';
%  'lV3_all_nw.mat';
%  'lV3_all_nw.Prosos.mat';
 
    };

roi2 ={
%     'flippedx0.rV1_all_nw.mat'
%     % ventral
%     'flippedx0.rV2v_all_nw.mat'
%     'flippedx0.rV3v_all_nw.mat'
    'flippedx0.rV4_all_nw.mat'
    'flippedx0.rVO1_all_nw.mat'
%     'flippedx0.rVO2_all_nw.mat'
%     'flippedx0.rPHC1_all_nw.mat'
%     'flippedx0.rPHC2_all_nw.mat'
    % lateral
%     'flippedx0.rV2d_all_nw.mat'
%     'flippedx0.rV3d_all_nw.mat'
%     'flippedx0.rLO1_all_nw.mat'
%     'flippedx0.rLO2_all_nw.mat'
%     %     % parietal
%     'flippedx0.rV3ab_all_nw.mat'
%     'flippedx0.rIPS0_all_nw.mat'
%     'flippedx0.rIPS1_all_nw.mat'
%     % faces ventral
%     'flippedx0.r_mfus_fVp_001_nw.mat'
%     'flippedx0.r_pfus_fVp_001_nw.mat'
%     'flippedx0.r_V4_fVp_001_nw.mat'
%        'flippedx0.r_ventral_fVp_nw.mat';
%     % places ventral
%     'flippedx0.r_cos_pVf_001_nw.mat'
% 'flippedx0.rPHC2_all_and_pVf_001_nw.mat'
% 'flippedx0.rPHC1_all_and_pVf_001_nw.mat'
% 'flippedx0.rVO2_all_and_pVf_001_nw.mat'
% 'flippedx0.rVO1_all_and_pVf_001_nw.mat'
% 'flippedx0.r_antHIPPanatXcospvf_nw.mat'

% % % % % % % % % % % % % % % % 
% % % prosos

% 'flippedx0.r_cos_pVf_001_nw.Prosos.mat';
% 'flippedx0.r_mfus_fVp_001_nw.Prosos.mat';
% 'flippedx0.r_pfus_fVp_001_nw.Prosos.mat';
% 'flippedx0.r_V4_fVp_001_nw.Prosos.mat';
%  'flippedx0.r_ventral_fVp_nw.Prosos.mat';
% 'flippedx0.rV1_all_nw.Prosos.mat';
% 'flippedx0.rV2v_all_nw.Prosos.mat';
% 'flippedx0.rV2d_all_nw.Prosos.mat';
% 'flippedx0.rV3v_all_nw.Prosos.mat';
% 'flippedx0.rV3d_all_nw.Prosos.mat';
% 'flippedx0.rV4_all_nw.Prosos.mat';
% 'flippedx0.rVO1_all_nw.Prosos.mat';
% 'flippedx0.rVO2_all_nw.Prosos.mat';
% 'flippedx0.rPHC1_all_nw.Prosos.mat';
% 'flippedx0.rPHC2_all_nw.Prosos.mat';
% % 'flippedx0.rV3ab_all_nw.Prosos.mat';
% 'flippedx0.rLO1_all_nw.Prosos.mat';
% 'flippedx0.rLO2_all_nw.Prosos.mat';
% % 'flippedx0.rTO1_all_nw.Prosos.mat';
% % 'flippedx0.rTO2_all_nw.Prosos.mat';
% %     
% % 
%  'flippedx0.rV2_all_nw.mat';
%  'flippedx0.rV2_all_nw.Prosos.mat';
%  'flippedx0.rV3_all_nw.mat';
%  'flippedx0.rV3_all_nw.Prosos.mat';


    };

saveroi ={
%     'lV1.flippedrV1.mat'
%     % ventral
%     'lV2v.flippedrV2v.mat'
%     'lV3v.flippedrV3v.mat'
    'lV4.flippedrV4.mat'
    'lVO1.flippedrVO1.mat'
%     'lVO2.flippedrVO2.mat'
%     'lPHC1.flippedrPHC1.mat'
%     'lPHC2.flippedrPHC2.mat';
    % lateral
%     'lV2d.flippedrV2d.mat'
%     'lV3d.flippedrV3d.mat'
%     'lLO1.flippedrLO1.mat'
%     'lLO2.flippedrLO2.mat'
    %     % parietal
%     'lV3ab.flippedrV3ab.mat'
%     'lIPS0.flippedrIPS0.mat'
%     'lIPS1.flippedrIPS1.mat'
%     % faces ventral
%     'l_mfus.flippedr_mfus.mat'
%     'l_pfus.flippedr_pfus.mat'
%     'l_V4_fVp.flippedr_V4_fVp.mat'
%     'l_faces.flippedr_faces.mat'
    % places ventral
%     'l_cos.flippedr_cos.mat'
% 'lPHC2pVf.flippedrPHC2pVf.mat'
% 'lPHC1pVf.flippedrPHC1pVf.mat'
% 'lVO2pVf.flippedrVO2pVf.mat'
% 'lVO1pVf.flippedrVO1pVf.mat'
% 'l_antHIPPanatXcospvf.flippedr.mat''r_cos_pVf_001_nw.Prosos.mat';

% % % % % % % % % % % % % % % % 
% % % % prosos
%      'l_cos.flippedr_cos.Prosos.mat'
%     'l_mfus.flippedr_mfus.Prosos.mat'
%     'l_pfus.flippedr_pfus.Prosos.mat'
%     'l_V4_fVp.flippedr_V4_fVp.Prosos.mat'
%         'l_faces.flippedr_faces.Prosos.mat'
%     'lV1.flippedrV1.Prosos.mat'
%     'lV2v.flippedrV2v.Prosos.mat'
%     'lV2d.flippedrV2d.Prosos.mat'
%     'lV3v.flippedrV3v.Prosos.mat'
%     'lV3d.flippedrV3d.Prosos.mat'
%     'lV4.flippedrV4.Prosos.mat'
%     'lVO1.flippedrVO1.Prosos.mat'
%     'lVO2.flippedrVO2.Prosos.mat'
% %     'lPHC1.flippedrPHC1.Prosos.mat'
% %     'lPHC2.flippedrPHC2.Prosos.mat';
% % %     'lV3ab.flippedrV3ab.Prosos.mat'
%     'lLO1.flippedrLO1.Prosos.mat'
%     'lLO2.flippedrLO2.Prosos.mat'
% 
% % % % % combined dorsal ventral and right left v2/v3
%     'lV2.flippedrV2.mat';
%     'lV2.flippedrV2.Prosos.mat';
%     'lV3.flippedrV3.mat';
%     'lV3.flippedrV3.Prosos.mat';
    };


cd(roidir);

for j=1:length(roi1)
    % load first roi
    load(roi1{j});
    % assign prf2sel structs to new names
    tempECCmv = ECCmv;
    tempmv = mv;
    temprm = rm;
    
    % get number of subjects in this roi
    numsubs = length(rm);
    
    % load second roi
    load(roi2{j});
    
    % then concatenate the two
    for r=numsubs+1:length(rm)+numsubs
        tempECCmv{r}=ECCmv{r-numsubs};
        tempmv{r}=mv{r-numsubs};
        temprm{r}=rm{r-numsubs};
    end
    
    % rename temp files
    
    ECCmv=tempECCmv;
    mv=tempmv;
    rm=temprm;
    save(saveroi{j},'ECCmv','mv','rm');
%     clear ECCmv mv rm tempECCmv tempmv temprm
end
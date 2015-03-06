% script for combining the .mat files for subjects across hemispheres.  

% path tocode
addpath('~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');


% assumes we are in directory with these variables
% cd '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
savedir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

cd(savedir);

% list of rois to combine rghtROI leftROI combinedROI
rois ={
% % %     controls
%     % confluent
%     'rV1_all_nw', 'lV1_all_nw','bothV1_all_nw';
%     'rV2_all_nw', 'lV2_all_nw','bothV2_all_nw';
%      'rV3_all_nw', 'lV3_all_nw','bothV3_all_nw';
%     'rV2v_all_nw','lV2v_all_nw','bothV2v_all_nw';
%     'rV3v_all_nw','lV3v_all_nw','bothV3v_all_nw';
    'rV4_all_nw','lV4_all_nw','bothV4_all_nw';
%     'rV2d_all_nw','lV2d_all_nw','bothV2d_all_nw';
%     'rV3d_all_nw','lV3d_all_nw','bothV3d_all_nw';
% % % % %     % ventral
    'rVO1_all_nw','lVO1_all_nw','bothVO1_all_nw';
%     'rVO2_all_nw','lVO2_all_nw','bothVO2_all_nw';
% % % % %     face rois
%     % % face rois
%      'r_V4_fVp_001_nw','l_V4_fVp_001_nw','both_V4_fVp_001_nw';
%      'r_pfus_fVp_001_nw','l_pfus_fVp_001_nw','both_pfus_fVp_001_nw';
%      'r_mfus_fVp_001_nw','l_mfus_fVp_001_nw','both_mfus_fVp_001_nw';
% % % % %      place rois
%  'r_cos_pVf_001_nw','l_cos_pVf_001_nw','both_cos_pVf_001_nw';
%     
%     
%   
%      % % %     prosos
%     % confluent
%     'rV1_all_nw.Prosos', 'lV1_all_nw.Prosos','bothV1_all_nw.Prosos';
%     'rV2_all_nw.Prosos', 'lV2_all_nw.Prosos','bothV2_all_nw.Prosos';
%      'rV3_all_nw.Prosos', 'lV3_all_nw.Prosos','bothV3_all_nw.Prosos';
%     'rV2v_all_nw.Prosos','lV2v_all_nw.Prosos','bothV2v_all_nw.Prosos';
%     'rV3v_all_nw.Prosos','lV3v_all_nw.Prosos','bothV3v_all_nw.Prosos';
%     'rV4_all_nw.Prosos','lV4_all_nw.Prosos','bothV4_all_nw.Prosos';
%     'rV2d_all_nw.Prosos','lV2d_all_nw.Prosos','bothV2d_all_nw.Prosos';
%     'rV3d_all_nw.Prosos','lV3d_all_nw.Prosos','bothV3d_all_nw.Prosos';
% % % % %     % ventral
%     'rVO1_all_nw.Prosos','lVO1_all_nw.Prosos','bothVO1_all_nw.Prosos';
%     'rVO2_all_nw.Prosos','lVO2_all_nw.Prosos','bothVO2_all_nw.Prosos';
% % % % %     face rois
%     % % face rois
%      'r_V4_fVp_001_nw.Prosos','l_V4_fVp_001_nw.Prosos','both_V4_fVp_001_nw.Prosos';
%      'r_pfus_fVp_001_nw.Prosos','l_pfus_fVp_001_nw.Prosos','both_pfus_fVp_001_nw.Prosos';
%      'r_mfus_fVp_001_nw.Prosos','l_mfus_fVp_001_nw.Prosos','both_mfus_fVp_001_nw.Prosos';
%      % % % %      place rois
%  'r_cos_pVf_001_nw.Prosos','l_cos_pVf_001_nw.Prosos','both_cos_pVf_001_nw.Prosos';
%      

};



% make the files
for r = 1:size(rois,1)
    
%   load the right and left rois
    right=load([rois{r,1} '.mat']);
    left=load([rois{r,2} '.mat']);
    
%   now need to combine them within subjects (not just double the number of
%   rois.  this means that we treat roi as a fixed effect but subject as a
%   random effect
%     
    for rs=1:length(right.rm)
        rightsessions{rs} = right.rm{rs}.session;
    end
    
    for lfs=1:length(left.rm)
        leftsessions{lfs} = left.rm{lfs}.session;
    end
    
%     then find the number of unique session names

    allsessions = unique([rightsessions leftsessions]);
    
%     go through unique sessions and combine rms
%     hemispheres
    for s=1:length(allsessions)
%       check to see if subject has both hemispheres 
        if length(find(strcmp(allsessions(s),[rightsessions leftsessions])))==2
%             then combine them
            rtrm = right.rm{strcmp(allsessions(s),[rightsessions])};
            lftrm = left.rm{strcmp(allsessions(s),[leftsessions])};
%             now combine
            rm{s}.coords = [rtrm.coords lftrm.coords]; %roi coordinates
            rm{s}.indices = [rtrm.indices; lftrm.indices]; %roi indices
            rm{s}.name = [rtrm.name 'and' lftrm.name]; %roi name
            rm{s}.curScan = 1;
            rm{s}.vt = rtrm.vt; %view
            rm{s}.co = [rtrm.co lftrm.co]; % variance explained by model
            rm{s}.sigma1 = [rtrm.sigma1 lftrm.sigma1];%sigma
            rm{s}.sigma2 = [rtrm.sigma2 lftrm.sigma2];%sigma2
            rm{s}.theta = [rtrm.theta lftrm.theta];%theta
            rm{s}.beta = [rtrm.beta; lftrm.beta];%beta
            rm{s}.x0 = [rtrm.x0 lftrm.x0];%x position of prf center
            rm{s}.y0 = [rtrm.y0 lftrm.y0]; %y position of prf center
            rm{s}.ph = [rtrm.ph lftrm.ph]; %angle of prf center
            rm{s}.ecc = [rtrm.ecc lftrm.ecc];%eccentricity of prf center
            rm{s}.session = rtrm.session;%subject
        else
            %just set rm{s} to be the right or left depending
            %if its not the right one
            if ~isempty(find(strcmp(allsessions(s),rightsessions)))
             rm{s}=right.rm{strcmp(allsessions(s),rightsessions)};
            %then it must be the left one
            else
              rm{s}=left.rm{strcmp(allsessions(s),leftsessions)};
                
            end
        end
        
    end

%     save the rm file
    save([savedir rois{r,3} '.mat'], 'rm');
    clear rm right left  rightsessions leftsessions;

end



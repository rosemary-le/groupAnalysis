%this script is for generating maps based on comparisons of contrast values
%(bivariate distributions across voxels)
%  one thing to improve is to allow the threshold to be determined by %
%  variance explained.  at the moment I am using a 


%addpath to our code
addpath('/biac2/kgs/projects/retinotopy/adult_ecc_karen/Analyses/MeshImages');
%set our sessions, namely, subject dirs, which scans, and which meshes
setretinosessions;



%set some constant values for this image
input.sessions = adult_sessions;

% for ecc
input.scans = [2 1 2 2 1 2 2 1 2 2 2 2];

% for mm

% pa scans
% input.scans =  [1 2 1 1 2 1 1 2 1 1 1 1];


% dataTypes
% dt =        [5 5 5 5 4 10 11 7 5 6 8 7];

% for the meridian mapping there is some unknown but constant phase offset
% that makes the maps look good.  there are numerous ways you could get the
% ideal number, but for now I tried rotating the voxel positions so that
% they are as good as possible in V1 at some threshold.  Functions for
% doing that can be found in the folder visFieldPlots
% input.phoffsets = -1*[61 42 57 65 94 302 58 53 67 92 90 63];
% let's try something standard since these are wrong.  around 55 is
% probably good
input.phoffsets = [-55 -55 -55 -55 -55 -55 -55 -55 -55 -55 -55 -55]

input.blockdir = '/biac2/kgs/projects/retinotopy/adult_ecc_karen/';
input.cmap = 'hsvCmap'; %color map.  the list of available colormaps is 
% input.cmap = 'rygbCmap';
%not the same as the one available to matlab. these name functions written
%by heeger that live in mrLoadRet/Colormap.  the normal matlab colormaps
%followed byCmap will often work 
input.mapType = 'corAnal';
input.threshold = .0;
% input.threshold = 1;
% input.coParamMap='EccBias_VarExp.mat'; %load this map into co field and use to threshold
% input.coScaleFlag = 0; %how to scale the load param map in the co field (see loadCoherenceMap.m)
input.savepath = ...
  '/biac2/kgs/projects/retinotopy/adult_ecc_karen/Analyses/MeshImages/retino_rois/'



% 
% input.roi = {'rV1_nw', 'rV2d_nw', 'rV2v_nw', 'rV3v_nw', 'rV3d_nw',...
%     'rV4_nw', 'rV3ab_nw', 'rLO1_nw', 'rLO2_nw',...
%     'rVO1_nw', 'rVO2_nw','rPHC1_nw','rPHC2_nw',... 
%       'r_V4_fVo_001_nw', 'r_pfus_fVo_001_nw', 'r_mfus_fVo_001_nw','r_afus_fVo_001_nw',...
%   'retino_mask'  
%    };
% 
% input.roi = {};

%  
%  'r_V4_fVp_001_nw', 'r_pfus_fVp_001_nw', 'r_mfus_fVp_001_nw','r_afus_fVp_001_nw',...
%    'r_cos_pVf_001_nw'
% % 'r_cos_pVo_001_nw', 

% input.roicolors = [0 0 0; 1 1 1; 0 0 0; 1 1 1; 0 0 0;...
%     1 1 1; 0 0 1; 1 1 1; 0 0 0;...
%     0 0 0; 1 1 1; 0 0 0; 1 1 1; ...
%       1 0 0; 0 1 0; 0 0 1; 1 1 0;...
%     0 1 1;];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%right hemisphere
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input.hemisphere ={'right'}; %hemisphere
input.pathhem = 'Right';
input.meshes = adult_rmeshes;   

% input.names ={'C1' 'C2' 'C3' 'C4' 'C5' 'C6' 'C7' 'C8' 'C9' 'C10' 'C11'};
input.names = adult_sessions;
input.meshangle = {'r_ven_big_nw'};
input.map = 'corAnal.mat';  %parameter map
adult_rois_rven = get_meshImages(input);




cd(input.savepath);

% save our figures
% function makeTiffsFromMeshImages(img, input, hemisphere, roiname)

makeTiffsFromMeshImages(adult_rois_rven,input,'Right','-55shift_ecc');
% makeTiffsFromMeshImages(adult_rois_rven,input,'Right','placesVfaces');






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%left hemisphere
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input.hemisphere ={'left'}; %hemisphere
input.pathhem = 'Left';
input.meshes = adult_lmeshes;   
% input.roi = {'lV1_nw', 'lV2d_nw', 'lV2v_nw', 'lV3v_nw', 'lV3d_nw', ...
%     'lV4_nw', 'lV3ab_nw', 'lLO1_nw', 'lLO2_nw',...
%     'lVO1_nw', 'lVO2_nw','lPHC1_nw','lPHC2_nw',...
%            'l_V4_fVo_001_nw', 'l_pfus_fVo_001_nw', 'l_mfus_fVo_001_nw', 'l_afus_fVo_001_nw',...
%     'lretino_mask'
% };
% %          'l_V4_fVp_001_nw', 'l_pfus_fVp_001_nw', 'l_mfus_fVp_001_nw', 'l_afus_fVp_001_nw',...
% % 'l_cos_pVf_001_nw' 
% % 'l_cos_pVo_001_nw', 
% 
% input.roi=[];

% input.meshangle = {'l_cosfus_nw'};
input.meshangle = {'l_ven_big_nw'};
adult_rois_lven = get_meshImages(input);


cd(input.savepath);

makeTiffsFromMeshImages(adult_rois_lven,input,'Left','-55shift_ecc');
% makeTiffsFromMeshImages(adult_rois_lven,input,'Left','placesVfaces');


save([num2str(length(adult_sessions)) '_-55_ecc_' input.map '_' ...
    num2str(input.threshold) '.mat'],'adult*','input')



% 
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % make and save images
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% 
% cd(input.savepath);
% 
% % save the image montages
% makeImages(adult_rois_rven,input,adult_sessions);
% saveas(gcf,[num2str(length(adult_sessions)) 'fVprois_rven_ecc.15.' input.map '_' ...
%     num2str(input.threshold) '.jpg'],'jpg');
% 
% 
% makeImages(adult_rois_lven,input,adult_sessions);
% saveas(gcf,[num2str(length(adult_sessions)) 'fVprois_lven_ecc.15.' input.map '_' ...
%     num2str(input.threshold) '.jpg'],'jpg');
% % % 
% % 
% 
% % save the matlab variables
% % % 
% save([num2str(length(adult_sessions)) '_fVpROIs_' input.map '_' ...
%     num2str(input.threshold) 'ecc.15.mat'],'adult*','input')
% % 
% % 

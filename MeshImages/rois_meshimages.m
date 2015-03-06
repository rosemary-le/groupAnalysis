%this script is for generating maps based on comparisons of contrast values
%(bivariate distributions across voxels)
%  one thing to improve is to allow the threshold to be determined by %
%  variance explained.  at the moment I am using a 


%addpath to our code
% addpath('/biac2/kgs/projects/retinotopy/adult_ecc_karen/Analyses/MeshImag
% es');
addpath('/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/MeshImages');
%set our sessions, namely, subject dirs, which scans, and which meshes
% setsessions;
set_ecc_sessions;


%set some constant values for this image
input.sessions = adult_sessions;
% for catVecc cor anal
% input.scans = ones(1,length(adult_sessions));
% for loloc
% input.scans = [1 1 1 1 1 1 1 1 1 1 1 1 1];
% for ecc
input.scans = [3
5
4
4
4
4
6
9
2
5
3
2
3]';

% input.blockdir = '/biac2/kgs/projects/retinotopy/adult_ecc_karen/';
input.blockdir ='/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/';
%need to figure out how to handle rois.  if all the subjects have the same
%roi its easy.  also easy if each subject has a different roi and you only
%want to show one.  the problem is showing multiple rois on multiple
%subjects.  would need to be a cell array with multiple cells;
input.cmap = 'bicolor';
% input.cmap = 'hsvCmap'; %color map.  the list of available colormaps is 
%not the same as the one available to matlab. these name functions written
%by heeger that live in mrLoadRet/Colormap.  the normal matlab colormaps
%followed byCmap will often work 
% input.mapType = 'corAnal';
input.mapType = 'parameter';
% input.dataType = 'MotionComp_RefScan1';
input.dataType = {'GLMs'};

input.threshold = .0;
% input.threshold = 1;
% input.coParamMap='EccBias_VarExp.mat'; %load this map into co field and use to threshold
% input.coScaleFlag = 0; %how to scale the load param map in the co field (see loadCoherenceMap.m)
% input.savepath = ...
%   '/biac2/kgs/projects/retinotopy/adult_ecc_karen/Analyses/MeshImages/fovVperROIs/';
input.savepath = ...
  '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/MeshImages/fovVperROIs/';






input.roi = {'rV1_nw', 'rV2d_nw', 'rV2v_nw', 'rV3v_nw', 'rV3d_nw',...
    'rV4_nw', 'rV3ab_nw', 'rLO1_nw', 'rLO2_nw',...
    'rVO1_nw', 'rVO2_nw','rPHC1_nw','rPHC2_nw',... 
            'r_V4_fVp_001_nw', 'r_pfus_fVp_001_nw', 'r_mfus_fVp_001_nw','r_afus_fVp_001_nw',...
  'r_cos_pVf_001_nw' 
   };
%      'r_V4_fVo_001_nw', 'r_pfus_fVo_001_nw', 'r_mfus_fVo_001_nw','r_afus_fVo_001_nw',...
%    'r_cos_pVo_001_nw'%   
% 


input.roicolors = [0 0 0; 1 1 1;  1 1 1; 0 0 0; 0 0 0;...
    1 1 1; 0 0 1; 1 1 1; 0 0 0;...
    0 0 0; 1 1 1; 0 0 0; 1 1 1; ...
     1 0 0; 0 1 0; 0 0 1; 1 1 0;...
    0 1 1;];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%right hemisphere
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input.hemisphere ={'right'} %hemisphere
input.pathhem = 'Right';
input.meshes = adult_rmeshes;   
% input.roi = {'rFFA_MBvAC_p3.mat','rPPA_IOvAC_p3.mat','rLO_ACvT_p3.mat'};
% input.roi = {};
% input.roicolors = [0 0 1; 0 0 0; 0 0 0];
% input.names ={'C1' 'C2' 'C3' 'C4' 'C5' 'C6' 'C7' 'C8' 'C9' 'C10' 'C11'};
input.names = adult_sessions;
% input.meshangle = {'r_cosfus_nw'};
input.meshangle = {'r_ven_big_nw'};
% input.map = 'childMantVIndoorOutdoor-T.mat';
% input.map ='ChildManVObjCar.mat';
input.map = 'fovVper.mat';
% input.map = 'categoryVeccentricityPHCO.mat';  %parameter map
% input.map = 'eccPrefAcrossCatsPHCO.mat';
% input.map = 'catPrefAcrossLocationsPHCO.mat';
% input.meshangle = {'rh_lat'};
% adult_rois_rlat = get_meshImages(input);
% input.meshangle = {'RH_medial'};
% adult_rois_rmed = get_meshImages(input);
% input.meshangle = {'rh_ventral_up_img'};
adult_rois_rven = get_meshImages(input);


cd(input.savepath);

% save our figures
% function makeTiffsFromMeshImages(img, input, hemisphere, roiname)

% makeTiffsFromMeshImages(adult_rois_rven,input,'Right','facesVobjects');
makeTiffsFromMeshImages(adult_rois_rven,input,'Right','placesVfaces');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%left hemisphere
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input.hemisphere ={'left'}; %hemisphere
input.pathhem = 'Left';
input.meshes = adult_lmeshes;   
input.roi = {'lV1_nw', 'lV2d_nw', 'lV2v_nw', 'lV3v_nw', 'lV3d_nw', ...
    'lV4_nw', 'lV3ab_nw', 'lLO1_nw', 'lLO2_nw',...
    'lVO1_nw', 'lVO2_nw','lPHC1_nw','lPHC2_nw',...
        'l_V4_fVp_001_nw', 'l_pfus_fVp_001_nw', 'l_mfus_fVp_001_nw', 'l_afus_fVp_001_nw',...
'l_cos_pVf_001_nw' 
};
 
%    'l_V4_fVo_001_nw', 'l_pfus_fVo_001_nw', 'l_mfus_fVo_001_nw', 'l_afus_fVo_001_nw',...
%     'l_cos_pVo_001_nw'


%     

    
% input.meshangle = {'l_cosfus_nw'};
input.meshangle = {'l_ven_big_nw'};
% input.meshangle = {'lh_lat'};
% adult_rois_llat = get_meshImages(input);
% input.meshangle = {'LH_medial'};
% adult_rois_lmed = get_meshImages(input);
% input.meshangle = {'lh_ventral_up_img'};
adult_rois_lven = get_meshImages(input);


cd(input.savepath);

% makeTiffsFromMeshImages(adult_rois_lven,input,'Left','facesVobjects');
makeTiffsFromMeshImages(adult_rois_lven,input,'Left','placesVfaces');


save([num2str(length(adult_sessions)) '_fVpROIs_' input.map '_' ...
    num2str(input.threshold) '.mat'],'adult*','input')





% 
% 
% 
% 
% % save the image montages
% makeImages(adult_rois_rven,input,adult_sessions);
% saveas(gcf,[num2str(length(adult_sessions)) 'fVprois_rven_nomap' input.map '_' ...
%     num2str(input.threshold) '.jpg'],'jpg');
% 
% 
% makeImages(adult_rois_lven,input,adult_sessions);
% saveas(gcf,[num2str(length(adult_sessions)) 'fVprois_lven_nomap.' input.map '_' ...
%     num2str(input.threshold) '.jpg'],'jpg');
% % % 
% % 
% 
% % save the matlab variables
% % % 

% % 
% % 

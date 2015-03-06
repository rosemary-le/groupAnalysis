%this script is for generating maps based on comparisons of contrast values
%(bivariate distributions across voxels)
%  one thing to improve is to allow the threshold to be determined by %
%  variance explained.  at the moment I am using a 


%addpath to our code
addpath('/biac2/kgs/projects/retinotopy/adult_ecc_karen/Analyses/MeshImages');
%set our sessions, namely, subject dirs, which scans, and which meshes
setsessions;



%set some constant values for this image
input.sessions = adult_sessions;
input.scans = ones(1,length(adult_sessions));
input.blockdir = '/biac2/kgs/projects/retinotopy/adult_ecc_karen/';
%need to figure out how to handle rois.  if all the subjects have the same
%roi its easy.  also easy if each subject has a different roi and you only
%want to show one.  the problem is showing multiple rois on multiple
%subjects.  would need to be a cell array with multiple cells;
input.cmap = 'hsvCmap'; %color map.  the list of available colormaps is 
%not the same as the one available to matlab. these name functions written
%by heeger that live in mrLoadRet/Colormap.  the normal matlab colormaps
%followed byCmap will often work 
input.mapType = 'corAnal';
input.dataType = 'MotionComp_RefScan1';
% input.threshold = .05;
input.threshold = 0.02;
input.coParamMap='EccBias_VarExp.mat'; %load this map into co field and use to threshold
input.coScaleFlag = 0; %how to scale the load param map in the co field (see loadCoherenceMap.m)
input.savepath = ...
  '/biac2/kgs/projects/retinotopy/adult_ecc_karen/Analyses/MeshImages/rawCatvsEcc/'




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
input.meshangle = {'r_cosfus_nw'};
input.map = 'categoryVeccentricityPHCO.mat';  %parameter map
% input.map = 'eccPrefAcrossCatsPHCO.mat';
% input.map = 'catPrefAcrossLocationsPHCO.mat';
% input.meshangle = {'rh_lat'};
% adult_rois_rlat = get_meshImages(input);
% input.meshangle = {'RH_medial'};
% adult_rois_rmed = get_meshImages(input);
% input.meshangle = {'rh_ventral_up_img'};
adult_rois_rven = get_meshImages(input);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%left hemisphere
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input.hemisphere ={'left'} %hemisphere
input.pathhem = 'Left';
input.meshes = adult_lmeshes;   
% input.roi = {'lFFA_MBvAC_p3.mat','lPPA_IOvAC_p3.mat','lLO_ACvT_p3.mat'};
% 
% 
input.meshangle = {'l_cosfus_nw'};
% input.meshangle = {'lh_lat'};
% adult_rois_llat = get_meshImages(input);
% input.meshangle = {'LH_medial'};
% adult_rois_lmed = get_meshImages(input);
% input.meshangle = {'lh_ventral_up_img'};
adult_rois_lven = get_meshImages(input);



cd(input.savepath);

% save the image montages
makeImages(adult_rois_rven,input,adult_sessions);
saveas(gcf,[num2str(length(adult_sessions)) 'catVSecc_rven_.o2' input.map '_' ...
    num2str(input.threshold) '.jpg'],'jpg');


makeImages(adult_rois_lven,input,adult_sessions);
saveas(gcf,[num2str(length(adult_sessions)) 'catVSecc_lven_,02' input.map '_' ...
    num2str(input.threshold) '.jpg'],'jpg');



% save the matlab variables
% 
save([num2str(length(adult_sessions)) '_' input.map '_' ...
    num2str(input.threshold) '.mat'],'adult*','input')



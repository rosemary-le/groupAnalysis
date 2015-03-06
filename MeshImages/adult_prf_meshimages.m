% script for generating mesh images with prf data
% last run 3/11/14

%addpath to our code
% addpath('/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/
% MeshImages');
% %
addpath('/biac4/kgs/biac3/kgs4/projects/retinotopy/adult_ecc_karen/Analyses/MeshImages');
%set our sessions, namely, subject dirs, which scans, and which meshes
setPRfsessions;



%set some constant values for this image
% input.sessions = adult_catVSeccsessions;
input.sessions = adult_retsessions;

% scan is same for ecc and pa, we change which map we view
% input.scans = catVSeccscans;
% input.scans = locscans;
input.scans = prfscans;

% datatype
% input.dataType = catVSeccdataType;
% input.dataType = {'GLMs'};
input.dataType = prfdataType;

% directory with our subjects
% input.blockdir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/';
input.blockdir ='/biac4/kgs/biac3/kgs4/projects/retinotopy/adult_ecc_karen/';
% input.phoffsets = [270*ones(1,10) 0];

% color map
% input.cmap = 'hsvCmap'; %color map.  the list of available colormaps is 
% input.cmap = 'WedgeMapRight_pRF.mat';
% input.cmap = 'rygbCmap';
% input.cmap = 'rygb4bands';
% input.cmap = 'blueredyellowCmap';
% input.cmap = 'bicolor';
input.cmap = 'hsvTbCmap';%hsv to blue only
%not the same as the one available to matlab. these name functions written
%by heeger that live in mrBOLDColormap.  the normal matlab colormaps
%followed byCmap will often work 

% says what map to load
% input.mapType = 'none';
% input.mapType = 'parameter';  %use this for ret and catVSecc
% 'prf'  for prf models
%  'bicolor' for both ends of a contrast
% 'mean' for mean map
% 'parameter' for normal one tailed parameter map
% corAnal for phase encoded maps like retinotopy or catvsecc

input.mapType = 'prf';

% which type of thing for a map to load (applies to prf and coranal)
input.whichMap = 'size to ecc ratio';
%'facesVSplaces01'; faces vs place contrast
   % 'anat'    anatomy
    % 'co'      coherence
    % 'amp' prf size
    % 'ph'    is polar angle
    % 'map'   is eccentricity

% map name for figures
% and/or name of parametermap
input.map = 'size ecc ratio';
% input.map = 'prf eccentricity';


% map threshold
input.threshold = 0.05;
% input.threshold = 1;


% % sometimes you want to threshold a map with another map
% input.coParamMap='EccBias_VarExp.mat'; %load this map into co field and use to threshold
% input.coScaleFlag = 0; %how to scale the load param map in the co field (see loadCoherenceMap.m)



% where to save your images
% need to make this folder... should automate
% input.savepath = ...
%   '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/MeshImages/catVeccphas_VFMs31114/'

input.savepath = ...
    '/biac4/kgs/biac3/kgs4/projects/retinotopy/adult_ecc_karen/Analyses/MeshImages/adultprfsizeeccratioAllRet/';





%if directory doesn't exist make it
if ~exist(input.savepath,'dir')
   disp('making save directory'); 
    mkdir(input.savepath)
    %if it does make sure you want to overwrite it
% else
%     fprintf('dir %s exists, do you want to replace its contents?',input.savepath);
%   return
end

input.roi = {'allret_alllayers_mask'};

% 
% % % 
% input.roi = {
%     'rV1_nw', 'rV2d_nw', 'rV2v_nw', 'rV3v_nw', 'rV3d_nw', ...%confluent ret
%     'rLO1_nw', 'rLO2_nw','rTO1_nw','rTO2_nw'...%lateral ret
%     'rV3ab_nw','rIPS0_nw','rIPS1_nw','rIPS2_nw','rIPS3_nw','rIPS4_nw','rIPS5_nw','rIPS6_nw',...%dorsal ret
%     'rV4_nw', 'rVO1_nw', 'rVO2_nw', 'rPHC1_nw', 'rPHC2_nw',...%ventral ret
%     ...%   'allretmaps_mask' ... 
%     'r_posthipp',... %hippocampal line
%     'r_cos_pVf_001_nw' %ventral place rois
%    };
% 

%  
%  'r_V4_fVp_001_nw', 'r_pfus_fVp_001_nw', 'r_mfus_fVp_001_nw','r_afus_fVp_001_nw',...
%    'r_cos_pVf_001_nw'    'rV4_nw', 'rVO1_nw', 'rVO2_nw','rPHC1_nw','rPHC2_nw',... 
%       'r_V4_fVo_001_nw', 'r_pfus_fVo_001_nw',
%       'r_mfus_fVo_001_nw','r_afus_fVo_001_nw',...
% % 'r_cos_pVo_001_nw', 

% input.roi = {'allVenCatROIs_mask'};
input.roicolors = [0 0 0];
% input.roicolors = [0 0 0; 1 1 1; 0 0 0; 1 1 1; 0 0 0;... %confluent ret
%     1 1 1; 0 0 0; 1 1 1; 0 0 0;...%lateral ret
%     0,0,1; 0 0 0; 1 1 1; 0 0 0; 1 1 1;  0 0 0; 1 1 1; 0 0 0; ...%dorsal ret
%      0 0 0; 1 1 1; 0 0 0; 1 1 1;  0 0 0;... %ventral ret
% %     0 0 0; %masks
%     0 1 0; ... %hippocampal line
%     0 1 1; %ventral place rois
%     ];
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %right hemisphere
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input.hemisphere ={'right'}; %hemisphere
input.pathhem = 'Right';
input.meshes = adult_rmeshes;   
% 
% 
% 
% % input.names ={'C1' 'C2' 'C3' 'C4' 'C5' 'C6' 'C7' 'C8' 'C9' 'C10' 'C11'};
input.names = input.sessions;
input.meshangle = {'rh_venmed'};
% input.meshangle = {'rh_poslat'};
adult_rois_rven = get_meshImages(input);


cd(input.savepath);

% save our figures
% function makeTiffsFromMeshImages(img, input, hemisphere, roiname)

makeTiffsFromMeshImages(adult_rois_rven,input,'Right',[char(input.meshangle) '_' char(input.mapType) '_' char(input.whichMap)]);
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
% input.roi = {
%     'lV1_nw', 'lV2d_nw', 'lV2v_nw', 'lV3v_nw', 'lV3d_nw', ...
%     'lLO1_nw', 'lLO2_nw','lTO1_nw','lTO2_nw'...
%     'lV3ab_nw','lIPS0_nw','lIPS1_nw','lIPS2_nw','lIPS3_nw','lIPS4_nw','lIPS5_nw','lIPS6_nw',...
%     'lV4_nw', 'lVO1_nw', 'lVO2_nw', 'lPHC1_nw', 'lPHC2_nw', ...
%     ...%   'allretmaps_mask'  
%     'l_posthipp',... %hippocampal line
%     'l_cos_pVf_001_nw' %ventral place rois
%    };

% input.cmap = 'WedgeMapLeft_pRF.mat';
% input.meshangle = {'l_cosfus_nw'};
input.meshangle = {'lh_venmed'};
% input.meshangle = {'lh_poslat'};
% 
adult_rois_lven = get_meshImages(input);


cd(input.savepath);

makeTiffsFromMeshImages(adult_rois_lven,input,'Left',[char(input.meshangle) '_' char(input.mapType) '_' char(input.whichMap)]);
% makeTiffsFromMeshImages(adult_rois_lven,input,'Left','placesVfaces');


save([num2str(length(input.sessions)) char(input.meshangle) '_' char(input.mapType) '_' char(input.whichMap) '_' ...
    num2str(input.threshold) '.mat'],'adult*','input')



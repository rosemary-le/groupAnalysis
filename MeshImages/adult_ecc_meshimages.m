%this script is for generating various eccentricity related maps
%for now we can keep the rois to 3
% want to generate the following maps
% faces foveal vs.  faces periphery
% places foveal vs. places periphery
% fovea vs. periphery


%want to add to the sessions here.  in particular no reason not to use
%golijeh or reno's data.  also want to add alison.


%addpath to our code
addpath('/biac2/kgs/projects/Prosopagnosia/fMRIData/code/Images');
%set our sessions, namely, subject dirs, which scans, and which meshes
set_ecc_sessions;




%set some constant values for this image
input.sessions = adult_sessions;
input.scans = [3 5 4 4 4 4 6 6 9 2 5 3 2 3 4];
input.blockdir = '/biac2/kgs/projects/retinotopy/adult_ecc_karen/';
%need to figure out how to handle rois.  if all the subjects have the same
%roi its easy.  also easy if each subject has a different roi and you only
%want to show one.  the problem is showing multiple rois on multiple
%subjects.  would need to be a cell array with multiple cells;
input.cmap = 'bicolor'; %color map.  the list of available colormaps is 
%not the same as the one available to matlab. these name functions written
%by heeger that live in mrLoadRet/Colormap.  the normal matlab colormaps
%followed byCmap will often work 
input.mapType = 'parameter';
input.dataType = 'GLMs';
% input.threshold = .05;
input.threshold = 0.03;
input.savepath = ...
  '/biac2/kgs/projects/retinotopy/adult_ecc_karen/Analyses/MeshImages/rawEccBias/'




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%right hemisphere
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input.hemisphere ={'right'} %hemisphere
input.pathhem = 'Right';
input.meshes = adult_rmeshes;   

input.names = adult_sessions;
input.meshangle = {'r_cosfus_nw'};
% input.map = 'fovVper.mat';  %parameter map
input.map = 'faceVplace.mat';
% input.map = 'FOV(P)vPER(P).mat';
% input.map = 'FOV(FP)vPER(FP).mat';
% input.map = 'F(FovPer)vP(FovPer) .mat';
% input.map = 'FOV(F)vFOV(P).mat';
% input.map = 'PER(F)vPER(P).mat';
% input.meshangle = {'rh_lat'};
% adult_rois_rlat = get_meshImages(input);
adult_rois_rven = get_meshImages(input);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%left hemisphere
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input.hemisphere ={'left'} %hemisphere
input.pathhem = 'Left';
input.meshes = adult_lmeshes;   

input.meshangle = {'l_cosfus_nw'};
adult_rois_lven = get_meshImages(input);


cd(input.savepath);

% save the image montages
makeImages(adult_rois_rven,input,adult_sessions);
saveas(gcf,[num2str(length(adult_sessions)) 'faceVplace_0.03_rven_' input.map '_' ...
    num2str(input.threshold) '.jpg'],'jpg');


makeImages(adult_rois_lven,input,adult_sessions);
saveas(gcf,[num2str(length(adult_sessions)) 'faceVplace_0.03_lven_' input.map '_' ...
    num2str(input.threshold) '.jpg'],'jpg');



% save the matlab variables
% 
save([num2str(length(adult_sessions)) '_' input.map '_' ...
    num2str(input.threshold) '.mat'],'adult*','input')



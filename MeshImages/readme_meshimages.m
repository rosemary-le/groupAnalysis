%  code in this directory should take a list of 
% sessions
% hemispheres
% rois
% paramater maps

%and for each one load a hidden gray with the chosen map 
%and or rois  using the function hG_load

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hG_load
% % % % % % % % % % % % % % % % % % % % % 

%addpath to our code
addpath('/biac2/kgs/projects/Prosopagnosia/fMRIData/code/Images');
%go to a session
input.sess = '01029009_mbproso';
input.blockdir = '/biac3/kgs7/mri/';
cd([input.blockdir input.sess]);

%first need to make the struct that we pass to hG_load
%lets try loading the faces vs. objects map and the m_fus rois
%want the loloc scan in the glm
input.scan_num = 1;  %which scan
input.roi = {'l_mfus_cmVac_p3.mat'};  %roi
input.map = 'ChildManVObjCar.mat';  %parameter map
input.cmap = 'autumnCmap'; %color map.  only this and bicolor work.  need 
% to find the list of allowable cmaps.  standard maps like 'hot' crash
hG= hG_load(input);


%then load the left or right mesh or both and update with
% the info from the hidden gray  using the function
% meshimage_load
% the mesh should be a saved view, i.e. looking at the 
% ventral surface.

%pick a hemisphere

input.hemisphere ={'right'}
%pick a mesh
input.meshname ={[input.blockdir input.sess '/3DAnatomy/Right/3DMeshes/mb_smooth_400_1_rh.mat']};
%pick a view

input.angles ={'rh_lateral' 'rh_medial' 'rh_ventral'}

for i = 1:3
%load up the mesh and apply the view and add the maps
input.meshangle = {input.angles{i}};
hG = meshimage_load(hG, input);
%get a screenshot of the image
img{i} = mesh_scrnsht(hG,input);
end

%then organize the saved mesh screenshots into a figure.

img_final=imageMontage(img);
fig1=figure('Units', 'norm', 'Position', [.1 .2 .7 .9], 'Name', 'Mesh Images','Color',[ 1 1 1]);
image(img_final);
axis off;

% close the meshes
hG = meshDelete(hG, Inf);
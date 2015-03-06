
%addpath to our code
addpath('/biac2/kgs/projects/Prosopagnosia/fMRIData/code/Images');
%set our sessions, namely, subject dirs, which scans, and which meshes
setsessions;



%set some constant values for this image
input.sessions = adult_sessions;
input.scans = adultloc_scans;
input.blockdir = '/biac2/kgs/projects/Kids/fmri/localizer/';
%need to figure out how to handle rois.  if all the subjects have the same
%roi its easy.  also easy if each subject has a different roi and you only
%want to show one.  the problem is showing multiple rois on multiple
%subjects.  would need to be a cell array with multiple cells; %color map.  the list of available colormaps is 
%not the same as the one available to matlab. these name functions written
%by heeger that live in mrLoadRet/Colormap.  the normal matlab colormaps
%followed byCmap will often work 


%for the right side
input.hemisphere ={'right'} %hemisphere
input.pathhem = 'Right';
input.meshes = adult_rmeshes;
input.roi = {'rVentStream_mm1000sNoRet.mat'};
input.threshold = 3;

%  faces vs. places 
input.cmap = 'autumnCmap';
% input.cmap = 'bicolor';
input.map = 'ManChildVIndoorOutdoor.mat';
% input.meshangle = {'rh_lat'};
input.meshangle = {'rh_lateral_tilted'};
adult_mbVio_rlat = get_meshImages(input);
input.meshangle = {'RH_medial'};
adult_mbVio_rmed = get_meshImages(input);
input.meshangle = {'rh_ventral_up_img'};
adult_mbVio_rven = get_meshImages(input);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%left hemisphere
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input.hemisphere = {'left'} %hemisphere
input.pathhem = 'Left';
input.meshes = adult_lmeshes;   
input.roi = 'lVentStream_mm1000sNoRet.mat';



% input.meshangle = {'lh_lat'};
input.meshangle = {'lh_lateral_tilted'};
adult_mbVio_llat = get_meshImages(input);
input.meshangle = {'LH_medial'};
adult_mbVio_lmed = get_meshImages(input);
input.meshangle = {'lh_ventral_up_img'};
adult_mbVio_lven = get_meshImages(input);



makeImages(adult_mbVio_llat,input,input.sessions);
makeImages(adult_mbVio_rlat,input,input.sessions);
makeImages(adult_mbVio_lmed,input,input.sessions);
makeImages(adult_mbVio_rmed,input,input.sessions);
makeImages(adult_mbVio_lven,input,input.sessions);
makeImages(adult_mbVio_rven,input,input.sessions);


clear FLAT GRAPHWIN HOMEDIR INPLANE VOLUME dataTYPES kid* proso* mrSESSION mrLoadRetVERSION ...
    selecte*  vANATOMYPATH  teen*



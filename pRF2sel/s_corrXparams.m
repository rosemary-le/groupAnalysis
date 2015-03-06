% the prosos and the controls seem different from one another in many ways

% for example, V1 appears to be larger in prosopagnosics on the order of 30
% voxels or 1.4 x larger which is a pretty big difference. V1 is known to
% vary by a factor of 3 and in my data that is probably about right
% (ignoring jc who had a different kind of retinotopy

% V2 and V3 have clearly worse pRF fits in the prosos.  in fact overall the
% retinotopic rois are larger in the prosos with worse fits.

% so do the size of the roi or the variance explained predict pRF size or
% eccentricity within a group.  clearly they are related across groups,
% though not consistently.  this would rule out the objection that somehow
% the prosos were consistently much closer to the screen resulting in much
% larger retinotopic areas and radically underestimated pRF sizes (i.e. 1
% degree in the model was actually 2 degrees on the screen

% the point here is that as you increase your stimulus size you cover more
% and more of a given visual field map.  now there are diminishing returns
% due to cortical magnification factor so at most we are moving from 15
% degree radius to maybe 17 or 18?  that should not add so many voxels.
% but anyway as a control

% add our code to the path
% addpath('/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');
addpath('~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');


% assumes we are in directory with these variables
% cd '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
cd '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';


% threshold
h.threshco = 0.1;
h.threshecc = [.5 10];
h.threshsigma = [0 10];

% directory to save figures in
h.savedir= [pwd '/roiCorrelationsCO10ecc.510sigma010/'];
% h.savedir='~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/controlstestinghists/';


h.sessionstouse = {
    %    controls
    '42611_AH'
    '43011_YW'
    'adult_amk_27yo_042910'
    'adult_cmb_23yo_070608'
    'adult_dy_25yo_041908'
    'adult_jw_36yo_061608'
    'adult_kll_18yo_052408'
    'adult_kw_fmri2_27yo_092910'
    'adult_mem_18yo_062608'
    %         'adult_jc_27yo_052408'
    'adult_rb_22yo_101908'
    'adult_acg_39yo_012008'
    'adult_ca_22yo_061908'
    '41711_TM'
    '42811_TA'
    %     prosos
    '112909whFMRI'
    '082509_nj_proso'
    '020209_mr_fmri'
    '0100609jm'
    '102909mb'
    '11109km_proso'
    '52309AF'
    
    };




%flipped means that you have separate rm files for left and right included
%in the overall struct, while both means they have been combined into one
%rm file
% using flipped means double the samples (assuming all subjects have all
% rois in both hemispheres) while both means double the data. doesn't seem
% to have a big effect.  except when subjects only have the roi on one side
% (like mfus)....



% roi
rois = {
    'lV1.flippedrV1.mat'
    'bothV1_all_nw.mat'
    %     %     ventral
    'lV2v.flippedrV2v.mat'
    'bothV2v_all_nw.mat'
    'lV3v.flippedrV3v.mat'
    'bothV3v_all_nw.mat'
    'lV4.flippedrV4.mat'
    'bothV4_all_nw.mat'
    'lVO1.flippedrVO1.mat'
    'bothVO1_all_nw.mat'
    % lateral
    'lV2d.flippedrV2d.mat'
    'bothV2d_all_nw.mat'
    'lV3d.flippedrV3d.mat'
    'bothV3d_all_nw.mat'
    % %     %     % faces ventral
    'l_mfus.flippedr_mfus.mat'
    'both_mfus_fVp_001_nw.mat'
    'l_pfus.flippedr_pfus.mat'
    'both_pfus_fVp_001_nw.mat'
    'l_V4_fVp.flippedr_V4_fVp.mat'
    'both_V4_fVp_001_nw.mat'
    
    % for prosos:
    
    
%     %     combined rois
    'lV1.flippedrV1.Prosos.mat'
    %     %     ventral
    'lV2v.flippedrV2v.Prosos.mat'
    'lV3v.flippedrV3v.Prosos.mat'
    'lV4.flippedrV4.Prosos.mat'
    'lVO1.flippedrVO1.Prosos.mat'
    %     'lVO2.flippedrVO2.Prosos.mat'
    %     'lPHC1.flippedrPHC1.Prosos.mat'
    %     'lPHC2.flippedrPHC2.Prosos.mat';
    % lateral
    'lV2d.flippedrV2d.Prosos.mat'
    
    % %     %     % faces ventral
    'l_mfus.flippedr_mfus.Prosos.mat'
    'l_pfus.flippedr_pfus.Prosos.mat'
    'l_V4_fVp.flippedr_V4_fVp.Prosos.mat'
    };


if ~exist(h.savedir)
    mkdir(h.savedir);
end


% do it!

for i = 1:length(rois)
    corrROIMeasures(rois{i},h);
end
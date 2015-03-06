% for the face rois can't just plot ecc or sigma because they aren't
% correlated so it is difficult to relate back to the visual field coverage
% plots.
%
% % let's see if we can make a 1d gaussian
%
% % width of gaussian
% sigma = 3;
% % range to evaluate gaussian
% x=-12:12;
% % center of gaussian
% m= 0*ones(1,length(x));
%
% y=1/(sigma*sqrt(2*pi))*exp(-1*(x-m).^2/(2*sigma^2))
%
% figure;
% plot(x,y,'k--');
%
%
% % now we don't really have to make gaussians.  we can simply put a 1
% % everywhere within some threshold of x, say 2sigma and a 0 everywhere else
%
% % so for the same parameter we say
%
% abovethresh = 0-2*sigma:0+2*sigma;
%
% % make a vector of zeros
%
% coverage = zeros(1,length(x));
%
% % take the intersection of x and abovethreshold and set coverage to 1
%
% [c iA iB] = intersect(x,abovethresh);
%
% coverage(iA)=1;

% so that is the basic method
% would be fastest if you could do it as vectors




% add our code to the path
addpath('/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');
% addpath('~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');


% assumes we are in directory with these variables
cd '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
% cd
% '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';


% roi
rois = {
%     'r_cos_pVf_001_nw.mat'
%     'r_mfus_fVp_001_nw.mat'
%     'r_pfus_fVp_001_nw.mat'
%     'r_V4_fVp_001_nw.mat'
%     'l_cos_pVf_001_nw.mat'
%     'l_mfus_fVp_001_nw.mat'
%     'l_pfus_fVp_001_nw.mat'
%     'l_V4_fVp_001_nw.mat'
%     'lV1_all_nw.mat'
%     'lV2v_all_nw.mat'
%     'lV3v_all_nw.mat'
%     'lV4_all_nw.mat'
%     'lVO1_all_nw.mat'
%     'lVO2_all_nw.mat'
%     'lPHC1_all_nw.mat'
%     'lPHC2_all_nw.mat'
       'rV1_all_nw.mat'
    'rV2v_all_nw.mat'
    'rV3v_all_nw.mat'
    'rV4_all_nw.mat'
    'rVO1_all_nw.mat'
    'rVO2_all_nw.mat'
    'rPHC1_all_nw.mat'
    'rPHC2_all_nw.mat'
    };

% param to plot

h.param = 'x';

% x0 x position
% y0 yposition

% set our x axis
% bins
h.bins = [-12 12];
% binsize
h.binsize = 1;

% thresholds for voxels to use
h.threshco = 0.1;
h.threshecc = [0.5 11.5];
h.threshsigma = [0 24];

% gaussian width threshold in number of sigmas
h.threshwidth = 1;


% directory to save figures in

% h.savedir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/combinedhists/';
h.savedir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/fractionCov/';

if ~exist(h.savedir)
    mkdir(h.savedir);
end


% do it!

for i = 1:length(rois)
    makePRFcovFraction(rois{i},h);
end

%     will move this to another function

%     load roi



% script which will call function below

% setting thresholds is a tricky business.  best is to not do to much and
% let it be after that, but with pRFs there is a lot to consider

% eccentricity
% fits near 0 and past some n/stimsize tend to be shit.  how to choose.
% visual inspection says not to trust much under a half degree.  the
% problem at larger eccentricities may be two things.  first of all, the
% number of voxels drops off due to cortical magnification making the
% average estimate noisier.  second, fits to prfs which overlap the edge of
% the display might be messed up. is a prf at
% the edge a small pRF or a large one which barely overlaps the field of
% view.  I know kendrick requires some proportion (at least 10% of the prf)
% to overlap with the field of view.


% sigma
% I do not notice that variance explained has a predictive relationship
% with sigma.  however, it is clear that weird stuff happens. in some
% subjects you will see 15 degree prfs across eccentricities in V1. the
% majority of subjects have no 15 degree prfs in v1 at all.  one definite
% cause is the artifact from the sinus, which appears to produce very large
% prf fits.  its tricky to deal with this problem without arguing from
% authority.  given the expectation of linear relationship between size and
% eccentricity across v1 you would be inclined to change the maximum prf
% size based on the visual area.  for the proso stuff, putting an upper
% limit on the pRF size and then bootstrapping within each subject and then
% across subjects should minimize the influence of these voxels as long as
% they are not close to the majority.


% coherence/variance explained
% either 0 or 10% variance explained seems good here.
% another  possibility is to bootstrap from a % variance explained within
% each roi that all subjects can meet in order to match the rois across
% subjects on that front.




% binsize
% the main dangers are choosing a bin size too large so that the true
% function of your data is smoothed over, or picking sizes so small that
% the sampling in each bin is too noisy.  this is a situation in which you
% might want different bin sizes for different rois.  a systematic approach
% might be to take all your data across subjects and percentile it.  then
% choose your eccentricity bins based on percentiles. so this will ensure
% that 10% of your data goes into each estimate.  these will be robust but
% hard to understand probably.



% function f_sizeVSeccFromROIsimple(roiFile, params)


% want to write a simpler version of the code that generates size by
% eccentricity plots for an roi
% as imput should tak name of roi output from pRF2sel
% struct defining the thresholds and number of bootstraps subjects to use
% create a figure, add data, and save it



% plots to get 
% 1. subplots with size x ecc line fit and all data
% 2. subplots with variance explained by eccentricity
% 3. subplots with size x ecc data points and thresholded masked out
% 4. random effects line for group with all data



load(roiFile);

% we are interested in the variable rm
% rm{1}
%
% ans =
%
%      coords: [3x3773 single]
%     indices: [3773x1 double]
%        name: 'lV1_nw'
%     curScan: 1
%          vt: 'Gray'
%          co: [1x3773 double]
%      sigma1: [1x3773 double]
%      sigma2: [1x3773 double]
%       theta: [1x3773 double]
%        beta: [3773x3 double]
%          x0: [1x3773 double]
%          y0: [1x3773 double]
%          ph: [1x3773 double]
%         ecc: [1x3773 double]
%     session: '42611_AH'








% plot bootstrapped line for each subject with data



% random effects bootstrap


% 1.  have an average for each subject for each bin
% 1a. generate random bootstrap average for each subject in each bin for
% each bootstrap

% 2.  sample subject means with replacement

% 3. fit line with replacement

%  4a. plot
%  get 2.5, 50, and 97.5% percentile of y prediction for each x
%  use these as mean and ci

% 4b.  stat test
%  would be used later but get slope and intercept for each bootstrapped
%  line









end
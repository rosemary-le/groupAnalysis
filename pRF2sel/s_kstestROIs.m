% given a pair of rois, some rm parameter, and some thresholds bootstrap a distribution of k
% statistics 



% add our code to the path
addpath('/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');
% addpath('~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');


% assumes we are in directory with these variables
cd '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
% cd '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';



% param to plot

h.param = 'ecc';

% co coherence
% sigma1 sigma
% x0 x position
% y0 yposition
% ph phase
% ecc eccentricity


% bins
h.bins = [0 10];

% binsize
h.binsize = 1;

% threshold
h.threshco = 0.1;
h.threshecc = [0 10];
h.threshsigma = [0 24];

% confidence interval to plot
h.ci = [2.5 97.5];

% number of bootstraps
h.nbtstrps = 50;


h.figname = 'v1 prosos vs controls';

% pair of rois

roi1 = 'lV1.flippedrV1.mat';
roi2 = roi1
roi2 = 'lV1.flippedrV1.Prosos.mat'
% 
% roi1 = 'lV2v.flippedrV2v.mat';
% roi2 = 'lV2v.flippedrV2v.Prosos.mat'  

% roi1 = 'lV2d.flippedrV2d.mat';
% roi2 = 'lV2d.flippedrV2d.Prosos.mat' 


% roi1 = 'lV3v.flippedrV3v.mat';
% roi2 = 'lV3v.flippedrV3v.Prosos.mat'  


% roi1 = 'lV4.flippedrV4.mat';
% roi2 = 'lV4.flippedrV4.Prosos.mat'  
% 
% roi1 =    'l_mfus.flippedr_mfus.mat';
% % % roi2 =    'l_mfus.flippedr_mfus.mat';
% roi2 =    'l_mfus.flippedr_mfus.Prosos.mat'

% %     'l_pfus.flippedr_pfus.mat'
%     roi1= 'l_V4_fVp.flippedr_V4_fVp.mat'
%         roi2= 'l_V4_fVp.flippedr_V4_fVp.Prosos.mat'


% sample of subjects from rois?





% load the rois
rm1=load(roi1);
roi1data = getRoiRmParams(rm1.rm,h);
rm2=load(roi2);
roi2data = getRoiRmParams(rm2.rm,h);


% do we want to subsample?
% would be good to see the cdf for each individual subject



figure('Name',[h.figname ' ' h.param],'Color',[1 1 1]);
% now bootstrap ks test
for b=1:h.nbtstrps
    % variables to hold our bootstrapped empirical distributions

    roi1edf = [];
    roi2edf = [];
%    get sample index from roi1
    bindx = randi(length(roi1data),[1,length(roi1data)-1]);
%    make bootstrap sample
    for i=bindx
        roi1edf = [roi1edf roi1data{i}];
    end

    h1(b) = cdfplot(roi1edf);
    set(h1(b),'Color',[0 1 0]);
    hold on;
    
% get sample index from roi2
    bindx = randi(length(roi2data),[1,length(roi2data)-1]);

    for i=bindx
        roi2edf = [roi2edf roi2data{i}];
    end

    h2(b) = cdfplot(roi2edf);
    set(h2(b),'Color',[1 0 0]);
    
    
    
% do ks test

    [H(b) p(b) K(b)] = kstest2(roi1edf,roi2edf,.05,'smaller');
    [H2(b) p2(b) K2(b)] = kstest2(roi1edf,roi2edf,.05,'larger');

    clear roi1edf roi2edf
    
end

% clean up figure;


xlabel(h.param);

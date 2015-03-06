% just want to check that the params for all the rm models are the same

sessiondir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/';
% all ret sessions are now in the localizer scan
retsessions = {
    '42111_MN'
    '42611_AH'
    '43011_YW'
    % '81511_NL'
    %     'adult_al_22yo_051108'
    'adult_amk_27yo_042910'
    'adult_cmb_23yo_070608'
    'adult_dy_25yo_041908'
    'adult_jw_36yo_061608'
    'adult_kll_18yo_052408'
    'adult_kw_fmri2_27yo_092910'
    'adult_mem_18yo_062608'
    'adult_jc_27yo_052408'
    'adult_rb_22yo_101908'
    'adult_acg_39yo_012008'
    'adult_ca_22yo_061908'
    '41711_TM'
    };

% corresponding dataTypes with retmodel
% retdts =        [5 5 5 10 11 7 5 6 8 7 5 7 11 7];
% imported ret models to localizer scan glm data type for some subjects
retdts = {
    'Averages' %mn
    'Averages' %ah
    'Averages' %yw
    %     'Averages' %nl
    %     'Averages' %al
    'Averages_nw' %ak
    'Averages_nw' %cmb
    'GLMs' %dy
    'Averages' %jw
    'Averages' %kll
    'GLMs' %kw
    'Averages_nw' %mem
    'GLMs' %jc
    'GLMs' %rb
    'Averages_nw' %acg
    'Averages_nw' %ca
    'Averages' %tm
    'Averages' %ta
    };

% names of retmodels for each subject
retmodels = {
    '12degreesPRFfit-hrfFit.mat' %mn
    '12degreesPRFfit-hrfFit.mat' %ah
    '12degreesPRFfit-hrfFit.mat' %yw
    %     'retModel-20130711-083422-hrfFit.mat' %nl
    %     'retModel-20130731-133102-hrfFit.mat' %al
    '12degreesPRFfit-hrfFit.mat' %amk
    '12degreesPRFfit-hrfFit.mat' %cmb
    '12degreesPRFfit-hrfFit.mat' %dy
    '12degreesPRFfit-hrfFit.mat' %jw
    '12degreesPRFfit-hrfFit.mat' %kll
    '12degreesPRFfit-hrfFit.mat' %kw
    '12degreesPRFfit-hrfFit.mat' %mem
    'rmImported_retModel-20081015-070833-fFit.mat'  %jc
    '12degreesPRFfit-hrfFit.mat' %rb
    '12degreesPRFfit-hrfFit.mat' %acg
    '12degreesPRFfit-hrfFit.mat' %ca
    '12degreesPRFfit-hrfFit.mat' %tm
    '12degreesPRFfit-hrfFit.mat' %ta
    };


% for each retsession
for s=1:length(retsessions)
%     load the model
    controlparams(s)=load( [sessiondir retsessions{s} '/Gray/' retdts{s} '/' retmodels{s}]);
%     print out the params 
 
    clear model 
end



% get proso data
sessiondir = '/Volumes/biac4-kgs/Projects/Prosopagnosia/fMRIData/';
% all ret sessions are now in the localizer scan

% % % % RETMODEL
% sessions for retmodel
retsessions = {
'112909whFMRI'
'082509_nj_proso'
'020209_mr_fmri'
'0100609jm'
'102909mb'
'11109km_proso'
'52309AF'
    };


% corresponding dataTypes with retmodel
retdts = {
    'Averages' 
    'Averages' 
    'Averages' 
    'Averages' 
    'Averages' 
    'Averages' 
    'Averages' 
    'Averages' 
};

% names of retmodels for each subject
retmodels = {
'12degreesPRFfit-hrfFit.mat' %WH
'12degreesPRFfit-hrfFit.mat' %NJ
'12degreesPRFfit-hrfFit.mat' %MR
'12degreesPRFfit-hrfFit.mat' %JM
'12degreesPRFfit-hrfFit.mat' %MB
'retModel-20140501-183203-hrfFit.mat' %KM
'12degreesPRFfit-hrfFit.mat' %AF
    };


% for each retsession
for s=1:length(retsessions)
%     load the model
    prosoparams(s)=load( [sessiondir retsessions{s} '/Gray/' retdts{s} '/' retmodels{s}]);
%     print out the params  
    clear model;
end





% so we want to check that all the important things are the same in all our
% models
% for each subject you get a file like this for prosoparams(1)

%      model: {[1x1 struct]}
%     params: [1x1 struct]

% % prosoparams(1).model{1}
%     description: '2D pRF fit (x,y,sigma, positive only)'
%              x0: [1x580520 double]
%              y0: [1x580520 double]
%           sigma: [1x1 struct]
%          rawrss: [1x580520 double]
%             rss: [1x580520 double]
%              df: [1x1 struct]
%         ntrends: 2
%             hrf: [1x1 struct]
%            beta: [1x580520x3 double]
%         npoints: 192
%             roi: [1x1 struct]


% so these are mostly the parameters fit to all your voxels, but we would
% like the ntrends which I think are polynomial error terms to be two
ntrends = 2;
% number of time points should be the same in all subjects
npoints = 192;

% prosoparams(1).params
% analysis: [1x1 struct]
%            stim: [1x2 struct]
%     matFileName: {[1x73 char]  '12degreesPRFfit-hrfFit.mat'}
%           wData: 'all'









% just want to check that the params for all the rm models are the same

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
    load( [sessiondir retsessions{s} '/Gray/' retdts{s} '/' retmodels{s}]);
%     print out the params 
    params.stim(1)
    params.stim(2)
    
    clear model params;
    
    r=input(' ');

end
% the main function is makePRF2selfiles.m
% takes some variables from set_pRF2selvars.m
% and some rois
% extracts rm, mv, and mvecc for that roi and saves in a directory as a
% .mat file


% then there are many functions which make use of those roi.mat files



% need more efficient way of doing comparisons of histograms of roi
% parameters

% at the moment to generate a parameter histogram you would use
%  s_pRFparamshists.m
% this allows you to set a constant bin size and thresholds  on the prfs
% parameters (for example >.1 variance explained)
%   it takes an roi and generates a histogram of the requested parameter
%   and then saves that as a figure in some directory.
% maybe it would be proper to bootstrap standard errors at this point?



% comparisons across rois are done by a scrips
% s_pRFparamshistsAcrossROIs.m
% opens requested figures and then plots them against one another








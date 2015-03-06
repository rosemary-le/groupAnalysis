% roiStats.m   the goal is to collect some summary stats from rois and then
% turn them into plots
% in particular we want to know whether certain basic things differ between
% prosos and controls

% so size of roi
% variance explained by ret
% number of retinotopic voxels above a given threshold
% variance explained by loc glm
% variance explained by ecc glm
% mean signal (this might require loading the hidden view)

% add our code to the path
addpath('/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');

% to get roi size from a plot we would do

% assumes we are in directory with these variables
cd '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';

% set our rois to load in pairs
roistoload = {'rV1_nw.Prosos.mat', 'rV1_nw.mat';
%     'rV2v_nw.Prosos.mat', 'rV2v_nw.mat';
%     'rV2d_nw.Prosos.mat', 'rV2d_nw.mat';
%     'rV3v_nw.Prosos.mat', 'rV3v_nw.mat';
%     'rV3d_nw.Prosos.mat', 'rV3d_nw.mat';
%     'rV4_nw.Prosos.mat', 'rV4_nw.mat';
%     'rVO1_nw.Prosos.mat', 'rVO1_nw.mat';
%     'rVO2_nw.Prosos.mat', 'rVO2_nw.mat';
%     %             'rV3ab_nw.Prosos.mat', 'rV3ab_nw.09-Jan-2014.mat';
%     'lV1_nw.Prosos.mat', 'lV1_nw.mat';
%     'lV2v_nw.Prosos.mat', 'lV2v_nw.mat';
%     'lV2d_nw.Prosos.mat', 'lV2d_nw.mat';
%     'lV3v_nw.Prosos.mat', 'lV3v_nw.mat';
%     'lV3d_nw.Prosos.mat', 'lV3d_nw.mat';
%     'lV4_nw.Prosos.mat', 'lV4_nw.mat';
%     'lVO1_nw.Prosos.mat', 'lVO1_nw.mat';
%     'lVO2_nw.Prosos.mat', 'lVO2_nw.mat';
%     'lV3ab_nw.Prosos.mat', 'lV3ab_nw.09-Jan-2014.mat';
    };
% 


% roistoload = {'r_V4_fVp_001_nw.Prosos.mat','r_V4_fVp_001_nw.mat';
%     'l_V4_fVp_001_nw.Prosos.mat','l_V4_fVp_001_nw.mat';
%     'r_pfus_fVp_001_nw.Prosos.mat','r_pfus_fVp_001_nw.mat';
%     'l_pfus_fVp_001_nw.Prosos.mat','l_pfus_fVp_001_nw.mat';
%        'r_mfus_fVp_001_nw.Prosos.mat','r_mfus_fVp_001_nw.mat';
%     'l_mfus_fVp_001_nw.Prosos.mat','l_mfus_fVp_001_nw.mat';
%     'r_fusiform_fVp_nw.Prosos.mat','r_fusiform_fVp_nw.mat';
% 'l_fusiform_fVp_nw.Prosos.mat', 'l_fusiform_fVp_nw.mat';
% 'all_fusiform_fVp_nw.Prosos.mat','all_fusiform_fVp_nw.mat';
% 'r_ventral_fVp_nw.Prosos.mat', 'r_ventral_fVp_nw.mat';
% 'l_ventral_fVp_nw.Prosos.mat', 'l_ventral_fVp_nw.mat';
% 'all_ventral_fVp_nw.Prosos.mat','all_ventral_fVp_nw.mat';
%     }
% set a save directory
saveDir = 'ProsoVSControlFigs/';
% make sure directory exists
if ~exist(saveDir)
    disp('save directory does not exist, creating');
    mkdir(saveDir);
end


for r=1:length(roistoload)
    % then
    roiSizeData = PlotROISizes([roistoload(r,1), roistoload(r,2)]);
    % let's clean up the figure with some specific details
    set(gca,'XTick',[1 2],'XTickLabel',{'Prosos','Controls'});
    ylabel('num voxels');
    
    % get data from figure
    roiData = get(gcf,'UserData');
    % 1x2 struct array with fields:
    %     sessions
    %     roiSizes
    %     name
    %     median
    %     mean
    
%     can subsample here
s
    
    % do a ttest
    [stats.H, stats.P, stats.CI, stats.STATS] = ttest2(roiData(1).roiSizes, roiData(2).roiSizes,.05,'both');
    %  put t and p value on the figure
    xlabel(['2 tailed ttest: t=' num2str(stats.STATS.tstat) ' p=' num2str(stats.P)])
    
    % save the figure
    saveas(gcf,[saveDir roiSizeData(1).name '.PrososVsCon.fig'],'fig');
end






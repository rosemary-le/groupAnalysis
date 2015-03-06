function  roiSizeData = PlotROISizes(roistoload)


% loads rois data created by pRF2Sel.  finds mean and stddev of ROI size
% across subjects for an ROI and makes a plot showing the sizes for each
% roi
% roitoload is a cell array of paths to .mat files to load

% make some variables

    roiSizeData.sessions = {};
    roiSizeData.roiSizes = [];
    roiSizeData.name = [];
%  open up a figure   
figure('Name','roi size comparison','Color',[1 1 1]);

% go through our rois
for i=1:length(roistoload)
    % load an roi
    load(roistoload{i});
%     loop across subjects and get data from rm struct you just loaded
    roiSizeData(i).name = rm{i}.name;

    for s=1:length(rm)
%         subject names
        roiSizeData(i).sessions(s) = {rm{s}.session};
%         roi size
        roiSizeData(i).roiSizes = [roiSizeData(i).roiSizes length(rm{s}.coords)];
    end
    
%     plot data from that roi
    
    scatter(i*ones(1,length(rm)),roiSizeData(i).roiSizes,'k');
    hold on;
    scatter(i, median(roiSizeData(i).roiSizes),'r');
    scatter(i, mean(roiSizeData(i).roiSizes),'g');
    
%     let's record these
    roiSizeData(i).median = median(roiSizeData(i).roiSizes);
     roiSizeData(i).mean = mean(roiSizeData(i).roiSizes);
end

% fix x axis
set(gca,'XLim', [0, length(roistoload)+1]);

% title
title(rm{1}.name);

% add data to figure
set(gcf,'UserData',roiSizeData);

% add in some pairwise ttests for each pair of rois








end
function  [controlMedians prosoMedians stats] = f_getAllROIStats(controls, prosos, h)


% want to compare the various parameters from an ROI across two groups of
% subjects, in this case prosos and controls
% takes as arguments the rm data for each subject for each roi
% h is a struct with thresholds and other useful info

% get the median value for each subject for sigma, ecc, coherence, and size
% of roi, along with the percent of voxels used 

% probably more transparent to move this outside this function.  but
% thresholding is done inside this
%  threhsolding a group of rms should probably be its own function as well
controlMedians = f_ROIparamsMedians(controls,h);
prosoMedians = f_ROIparamsMedians(prosos,h);


% do some stats
% could bootstrap this but not sure it is worth time

[stats.co.H, stats.co.P, stats.co.CI, stats.co.STATS] = ...
    ttest2(controlMedians.co, prosoMedians.co,.05,'both','unequal');

[stats.size.H, stats.size.P, stats.size.CI, stats.size.STATS] = ...
    ttest2(controlMedians.size, prosoMedians.size,.05,'both','unequal');

[stats.ecc.H, stats.ecc.P, stats.ecc.CI, stats.ecc.STATS] = ...
    ttest2(controlMedians.ecc, prosoMedians.ecc,.05,'both','unequal');

[stats.sigma.H, stats.sigma.P, stats.sigma.CI, stats.sigma.STATS] = ...
    ttest2(controlMedians.sigma, prosoMedians.sigma,.05,'both','unequal');

[stats.percentvoxels.H, stats.percentvoxels.P, stats.percentvoxels.CI, stats.percentvoxels.STATS] = ...
    ttest2(controlMedians.percentvoxels, prosoMedians.percentvoxels,.05,'both','unequal');




% make the figure
figure('Name', 'prososVScontrols', 'Color', [1 1 1], 'Position', get(0,'ScreenSize'));

% measures we havex
% co, ecc, sigma, size, percentvoxels

% coherence
subplot(1,5,1);
title('variance explained');
% controls
scatter(ones(1,length(controlMedians.co)),controlMedians.co,'k');
hold on;
scatter(1, median(controlMedians.co),'r');
scatter(1, mean(controlMedians.co),'g');
text(ones(length(controlMedians.co),1),controlMedians.co,...
    controlMedians.sessions,'FontSize',3);

% prosos
scatter(2*ones(1,length(prosoMedians.co)),prosoMedians.co,'k');
scatter(2, median(prosoMedians.co),'r');
scatter(2, mean(prosoMedians.co),'g');
text(2*ones(1,length(prosoMedians.co)),prosoMedians.co,prosoMedians.sessions);

% figure stuff
ylabel('var exp');
% color x label red if p is < 0.05
if stats.co.P<.05
    xlabel(['p<' num2str(stats.co.P)],'Color',[1 0 0]);
else
    xlabel(['p<' num2str(stats.co.P)]);
end

% set x axis
set(gca,'XLim',[0 3],'XTick',[1 2],'XTickLabel',{'Controls', 'Prosos'});


%do some stats for figure





% roisize
subplot(1,5,2);
title('size');
% controls
scatter(ones(1,length(controlMedians.co)),controlMedians.size,'k');
hold on;
scatter(1, median(controlMedians.size),'r');
scatter(1, mean(controlMedians.size),'g');
text(ones(1,length(controlMedians.co)),controlMedians.size,controlMedians.sessions);

% prosos
scatter(2*ones(1,length(prosoMedians.co)),prosoMedians.size,'k');
scatter(2, median(prosoMedians.size),'r');
scatter(2, mean(prosoMedians.size),'g');
text(2*ones(1,length(prosoMedians.co)),prosoMedians.size,prosoMedians.sessions);

% figure stuff
ylabel('# voxels');
set(gca,'XLim',[0 3],'XTick',[1 2],'XTickLabel',{'Controls', 'Prosos'});
% color x label red if p is < 0.05
if stats.size.P<.05
    xlabel(['p<' num2str(stats.size.P)],'Color',[1 0 0]);
else
    xlabel(['p<' num2str(stats.size.P)]);
end



% eccentricity
subplot(1,5,3);
title('ecc');
% controls
scatter(ones(1,length(controlMedians.co)),controlMedians.ecc,'k');
hold on;
scatter(1, median(controlMedians.ecc),'r');
scatter(1, mean(controlMedians.ecc),'g');
text(ones(1,length(controlMedians.co)),controlMedians.ecc,controlMedians.sessions);

% prosos
scatter(2*ones(1,length(prosoMedians.co)),prosoMedians.ecc,'k');
scatter(2, median(prosoMedians.ecc),'r');
scatter(2, mean(prosoMedians.ecc),'g');
text(2*ones(1,length(prosoMedians.co)),prosoMedians.ecc,prosoMedians.sessions);

% figure stuff
ylabel('eccentricity');
set(gca,'XLim',[0 3],'XTick',[1 2],'XTickLabel',{'Controls', 'Prosos'});
% color x label red if p is < 0.05
if stats.ecc.P<.05
    xlabel(['p<' num2str(stats.ecc.P)],'Color',[1 0 0]);
else
    xlabel(['p<' num2str(stats.ecc.P)]);
end


% sigma
subplot(1,5,4);
title('sigma');
% controls
scatter(ones(1,length(controlMedians.co)),controlMedians.sigma,'k');
hold on;
scatter(1, median(controlMedians.sigma),'r');
scatter(1, mean(controlMedians.sigma),'g');
text(ones(1,length(controlMedians.co)),controlMedians.sigma,controlMedians.sessions);

% prosos
scatter(2*ones(1,length(prosoMedians.co)),prosoMedians.sigma,'k');
scatter(2, median(prosoMedians.sigma),'r');
scatter(2, mean(prosoMedians.sigma),'g');
text(2*ones(1,length(prosoMedians.co)),prosoMedians.sigma,prosoMedians.sessions);

% figure stuff
ylabel('sigma');
set(gca,'XLim',[0 3],'XTick',[1 2],'XTickLabel',{'Controls', 'Prosos'});
% color x label red if p is < 0.05
if stats.sigma.P<.05
    xlabel(['p<' num2str(stats.sigma.P)],'Color',[1 0 0]);
else
    xlabel(['p<' num2str(stats.sigma.P)]);
end




% percent of voxels
subplot(1,5,5);
title('% of voxels');
% controls
scatter(ones(1,length(controlMedians.co)),controlMedians.percentvoxels,'k');
hold on;
scatter(1, nanmedian(controlMedians.percentvoxels),'r');
scatter(1, nanmean(controlMedians.percentvoxels),'g');
text(ones(1,length(controlMedians.co)),controlMedians.percentvoxels,controlMedians.sessions);

% prosos
scatter(2*ones(1,length(prosoMedians.co)),prosoMedians.percentvoxels,'k');
scatter(2, nanmedian(prosoMedians.percentvoxels),'r');
scatter(2, nanmean(prosoMedians.percentvoxels),'g');
text(2*ones(1,length(prosoMedians.co)),prosoMedians.percentvoxels,prosoMedians.sessions);

% figure stuff
ylabel('percent voxels');
set(gca,'XLim',[0 3],'XTick',[1 2],'XTickLabel',{'Controls', 'Prosos'});
% color x label red if p is < 0.05
if stats.percentvoxels.P<.05
    xlabel(['p<' num2str(stats.percentvoxels.P)],'Color',[1 0 0]);
else
    xlabel(['p<' num2str(stats.percentvoxels.P)]);
end







end
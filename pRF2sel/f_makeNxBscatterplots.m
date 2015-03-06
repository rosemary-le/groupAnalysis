function [stats] = f_makeNxBscatterplots(datastruct,field1,field2)

%datastruct has data, field 1 and field2 are fields from struct to
%correlate and plot
% length of data struct is rois, and will make one plot for each roi
[m n] = subplotsize(length(datastruct));

% turn off fucking latex interpreter!
set(0,'DefaultTextInterpreter','none');

figure('Name',['Correlation between ' field1 ' and ' field2],'Color',[1 1 1],...
    'Position',get(0,'ScreenSize'));
for r=1:length(datastruct)
%     which subplot
% subplot(m,n,r);
subplot(1,3,r);

% to fit a line have to remove nans
subswithdata = intersect(find(~isnan(datastruct{r}.(field1))),...
    find(~isnan(datastruct{r}.(field2))));

% compute the correlation
[stats.rho(r) stats.p(r)] = corr(datastruct{r}.(field1)(subswithdata)',...
    datastruct{r}.(field2)(subswithdata)','rows','pairwise');
% make the scatterplot
scatter(datastruct{r}.(field1)(subswithdata)',...
    datastruct{r}.(field2)(subswithdata)','g','filled');

lsline

% this is a hack to get the proso dots to be red
hold on;
scatter(datastruct{r}.(field1)(end-6:end)',...
    datastruct{r}.(field2)(end-6:end)','r','filled');
%end hack


xlabel(field1);ylabel(field2);
title([char(datastruct{r}.roiname) ' r=' num2str(stats.rho(r)) ' p=' num2str(stats.p(r))])

axis square

%annoyingly the y-axis can be slightly moved by lsline which makes the
%figures messed up for paper quality.  this should fix it
set(gca,'YLim',[.3 1]);



% 
% [slope intercept] = linfit(datastruct{r}.(field1)(subswithdata),...
%     datastruct{r}.(field2)(subswithdata));
% 
% % plot line and add slope and intercept
% refline(slope, intercept);

end

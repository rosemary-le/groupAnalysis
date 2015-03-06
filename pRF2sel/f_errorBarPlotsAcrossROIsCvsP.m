
function f_errorBarPlotsAcrossROIsCvsP(controlMedians,prosoMedians,h,rois,fldname,stats)
% fldname = 'size';

% initialize variables for means and errors
prosomeans = zeros(1,length(prosoMedians));
controlmeans = prosomeans;
prosoerrors = prosomeans;
controlerrors = prosomeans;

% check that groups are the same size
if isequal(length(prosoMedians),length(controlMedians))
%     get means and 1.96* standard error for each group
    for r=1:length(prosoMedians)
       controlmeans(r)=mean(controlMedians{r}.(fldname));
       controlerrors(r) = ( (nanstd(controlMedians{r}.(fldname))) ./ sqrt(sum(~isnan(controlMedians{r}.(fldname)))) ) * 1.96 ;  
        prosomeans(r)=mean(prosoMedians{r}.(fldname));
       prosoerrors(r) = ( (nanstd(prosoMedians{r}.(fldname))) ./ sqrt(sum(~isnan(prosoMedians{r}.(fldname)))) ) * 1.96 ;  
        
        
        
        
    end
else
    fprintf('groups have different number of rois\n');
end


% make controls green
controlclr = [0 0 1];
prosoclr = [1 0 0];

figure('Name',['Controls vs Prosos ' fldname],'Color',[1 1 1],'Position',get(0,'ScreenSize'));
errorbar((1:length(prosomeans))',prosomeans',prosoerrors','o','Color',prosoclr,'LineWidth',4,...
    'MarkerSize',12,'MarkerFaceColor',prosoclr)
hold on;
errorbar((1:length(controlmeans))',controlmeans',controlerrors','o','Color',controlclr,...
    'LineWidth',4,'MarkerSize',12,'MarkerFaceColor',controlclr)
% % cover up lines!
% plot([(1:length(prosomeans))' (1:length(prosomeans))'],[prosomeans' controlmeans'],...
%     'w-','LineWidth',8);
% add a title that has the thresholding
title(['threhsolds are co: ' num2str(h.threshco) ' ecc: ' num2str(h.threshecc)...
    ' sigma: ' num2str(h.threshsigma)]);

box off;

set(gca,'XTick',1:length(prosoMedians),'XTickLabel',rois(:,3),'FontSize',18,'FontWeight','bold');

% if field is size make yaxis have log units
if strcmp(fldname,'size')
    set(gca,'YScale','log');
end
% disp('this is the right function');
%prettify the figure
ylabel(fldname,'FontSize',40);
xlabel('rois','FontSize',40);
% 
% % have entry in stats struct for each roi
ps = ones(1,length(stats));
for s=1:length(stats)
    ps(s) = stats{s}.(fldname).P;
end
% get ps less than 0.05 but greater than bonferonni corrected threshold
p05 = find(ps<0.05&ps>(0.05/length(stats)));
% get ps less than bonferonni correction
pb = find(ps<(0.05/length(stats)));


xpos=1:length(prosoMedians);
% add 1 * for p05s at top of plot
% height of plot
ylimits = get(gca,'YLim');
ypos = ylimits(2)*ones(1,length(p05));
text(xpos(p05),ypos,'*','FontSize',40,'FontWeight','bold','Color','b');
% 3 stars for bonferonni correction
ypos = ylimits(2)*ones(1,length(pb));
text(xpos(pb),ypos,'***','FontSize',40,'FontWeight','bold','Color','r');



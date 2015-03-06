function [grouphist rm] = f_makePRFhistsForROI(rm,h)

% rm is an array of structs with rm fits from an roi for each subject
% will assume that voxels are thresholded before they get to this function
% using f_thresholdRMData
% h is a struct which specifies useful things
% %
% h =
% h.param: 'sigma'
% h.bins: [0 24];
% h.binsize: .5
% h.threshco: 0
% h.threshecc: [0 12]
% h.threshsigma: [0 24]
% h.saveDir: [1x96 char]
% h.ci: confidence interval to plot




% variable to hold our group histogram data
grouphist.co.data = [];
grouphist.sigma.data = [];
grouphist.ecc.data = [];

% get histogram for every subject for each parameter

for s=1:length(rm)
    %     skip if no voxels are above thresholds
    if ~isempty(rm{1}.co)
        % store the values for every param
        %         need bins and binsize for each measure
%         coherence
        rm{s}.histco = histc(rm{s}.co,h.corange(1):h.cobinsize:h.corange(2));
        grouphist.co.data = [grouphist.co.data; rm{s}.histco];  
%         prf size
        rm{s}.histsigma= hist(rm{s}.sigma1,h.sigmarange(1):h.sigmabinsize:h.sigmarange(2));
        grouphist.sigma.data = [grouphist.sigma.data; rm{s}.histsigma];
%         rm{s}.histx0 = histc(rm{s}.x0,h.bins(1):h.binsize:h.bins(2));
%         rm{s}.histy0 = histc(rm{s}.y0,h.bins(1):h.binsize:h.bins(2));
        rm{s}.histecc = histc(rm{s}.ecc,h.eccrange(1):h.eccbinsize:h.eccrange(2));
        grouphist.ecc.data = [grouphist.ecc.data; rm{s}.histecc];
    end
end


%normalize our group data 
grouphist.co.pdfdata = grouphist.co.data./repmat(sum(grouphist.co.data,2),1,size(grouphist.co.data,2));

grouphist.sigma.pdfdata = grouphist.sigma.data./repmat(sum(grouphist.sigma.data,2),1,size(grouphist.sigma.data,2));

grouphist.ecc.pdfdata = grouphist.ecc.data./repmat(sum(grouphist.ecc.data,2),1,size(grouphist.ecc.data,2));


% bootstrap confidence intervals on the raw and normalized data
numboots = 1000;
% sample sizes
n=size(grouphist.co.pdfdata,1);
%variables to hold bootstrapped data
countcoboots = zeros(numboots,size(grouphist.co.pdfdata,2));
countsigboots = zeros(numboots,size(grouphist.sigma.pdfdata,2));
counteccboots = zeros(numboots,size(grouphist.ecc.pdfdata,2));
pdfcoboots = zeros(numboots,size(grouphist.co.pdfdata,2));
pdfsigboots = zeros(numboots,size(grouphist.sigma.pdfdata,2));
pdfeccboots = zeros(numboots,size(grouphist.ecc.pdfdata,2));


for b=1:numboots
%     make a sample index
    %     %     make random index with replacement

    bindx = randi(n,[1,n]);
%     %     get a new sample with random rows
%    	average counts (could be medians)
    countcoboots(b,:) = sum(grouphist.co.data(bindx,:),1)/n;
    counteccboots(b,:) = sum(grouphist.ecc.data(bindx,:),1)/n;
    countsigboots(b,:) = sum(grouphist.sigma.data(bindx,:),1)/n;
    pdfcoboots(b,:) = sum(grouphist.co.pdfdata(bindx,:),1)/n;
    pdfsigboots(b,:) = sum(grouphist.sigma.pdfdata(bindx,:),1)/n;
    pdfeccboots(b,:) = sum(grouphist.ecc.pdfdata(bindx,:),1)/n;
 
end

% save our bootstraps
grouphist.co.countcoboots = countcoboots;
grouphist.co.pdfcoboots = pdfcoboots;
grouphist.sigma.countsigboots = countsigboots;
grouphist.sigma.pdfsigboots = pdfsigboots;
grouphist.ecc.counteccboots = counteccboots;
grouphist.ecc.pdfeccboots = pdfeccboots;

grouphist.roi = rm{1}.name;
grouphist.params = h;




% get desired percentiles from bootstrapped distributions



% 
% 
% % attach some stuff to the plot
% 
% % make histogram with each subject
% figure('Name',['distribution of ' h.param ' in ' rm{1}.name], 'Color', [1 1 1]);
% hold on;
% % for each subject
% 
% % find subplot size
% [m n] = subplotsize(length(rm));
% 
% % save the plot
% 
% % saveas(gcf,[h.savedir roi '.' h.param '.subplots.png'],'png');
% % close(gcf);
% 
% 
% 
% % now some group figures
% % fixed effects would just take all the voxels we have across subjects and
% % just lump them together
% % do unnormalized and normalized
% 
% figure('Name',['All voxels in ' rm{1}.name ' ' h.param],'Color',[1 1 1]);
% hold on;
% % first not normalized for different numbers of voxels
% subplot(2,1,1);
% bar(h.bins(1):h.binsize:h.bins(2),sum(grouphist));
% title('raw data');
% ylabel('number of voxels');
% xlabel(h.param);
% % set(gca,'XTick',h.bins(1):h.binsize:h.bins(2),'XTickLabel',h.bins(1):h.binsize:h.bins(2));
% box off;
% % then normalized
% subplot(2,1,2);
% % normalize each row by the sum
% % need to deal with empty rows when subject has no voxel above threshold
% % get the number of voxels for each subject (the sume of the row)
% rowsum = sum(grouphist')';
% % divide the entry in each row by the sum of the row
% nmatrix = repmat(rowsum,1,size(grouphist,2));
% % then divide to get proportion for each subject
% ngrouphist = grouphist./nmatrix;
% % checked, these rows now sum to 1
% % sometimes subjects will have no above threshold data need to divide by
% % only the number of subjects that do
% bar(h.bins(1):h.binsize:h.bins(2),nansum(ngrouphist)./(size(ngrouphist,1)-sum(isnan(ngrouphist(:,1)))));
% title('normalized data');
% ylabel('proportion of voxels');
% xlabel(h.param);
% % set(gca,'XTick',h.bins(1):h.binsize:h.bins(2),'XTickLabel',h.bins(1):h.binsize:h.bins(2));
% box off;
% 
% % want to add data to this so we can make figure across rois
% set(gcf,'UserData',{grouphist,h});
% saveas(gcf,[h.savedir roi '.' h.param '.groupplots.fig'],'fig');
% saveas(gcf,[h.savedir roi '.' h.param '.groupplots.png'],'png');
% close(gcf);
% 
% 
% % let's bootstrap some error bars.
% % we are interested in our best estimate of the distribution.  so I think
% % we would generate many distributions by sampling from the subjects and
% % then getting an error bar from that
% % our subjects are in grouphist (nsubjects x data)
% 
% % number of bootstrps
% nbstrps = 500;
% 
% for b=1:nbstrps
%     %     make random index with replacement
%     bindx = randi(size(grouphist,1),[1,size(grouphist,1)]);
%     %     get a new sample with random rows
%     bgrouphist = grouphist(bindx, :);
%     %     get the sum of each row
%     rowsum = sum(bgrouphist')';
%     % make a matrix of the same size as the group data with the row sums
%     nmatrix = repmat(rowsum,1,size(bgrouphist,2));
%     % then divide to get pdf for each subject
%     bgrouphist = bgrouphist./nmatrix;
%     %     take the average for each column but discarding nan rows
%     bsrp(b,:) = nansum(bgrouphist)./(size(bgrouphist,1)-sum(isnan(bgrouphist(:,1))));
% end
% 
% 
% % get some 95% confidence intervals
% 
% YCI=prctile(bsrp,h.ci);
% Ymedian = prctile(bsrp,50);
% 
% 
% 
% figure('Name',['bootstrapped 95% ci for ' roi ' ' h.param],'Color',[1 1 1]);
% subplot(2,1,1);
% plot(h.bins(1):h.binsize:h.bins(2),bsrp);
% title('normalized data');
% ylabel('proportion of voxels');
% xlabel(h.param);
% box off;
% subplot(2,1,2);
% errorbar3(h.bins(1):h.binsize:h.bins(2),Ymedian,YCI,1,[1 0 0]);
% hold on;
% plot(h.bins(1):h.binsize:h.bins(2),Ymedian,'r-');
% title('normalized data');
% ylabel('proportion of voxels');
% xlabel(h.param);
% set(gcf,'UserData',{grouphist,h,bsrp,YCI,Ymedian,rawdata});
% saveas(gcf,[h.savedir roi '.' h.param '.norm.groupplotscis.fig'],'fig');
% saveas(gcf,[h.savedir roi '.' h.param '.norm.groupplotscis.png'],'png');
% 
% 
% 
% % let's bootstrap some error bars on the raw counts.
% % we are interested in our best estimate of the distribution.  so I think
% % we would generate many distributions by sampling from the subjects and
% % then getting an error bar from that
% % our subjects are in grouphist (nsubjects x data)
% 
% % number of bootstrps
% nbstrps = 500;
% 
% for b=1:nbstrps
%     %     make random index with replacement
%     bindx = randi(size(grouphist,1),[1,size(grouphist,1)]);
%     %     get a new sample with random rows
%     bgrouphist = grouphist(bindx, :);
%     %     get the sum of each row
%     %     rowsum = sum(bgrouphist')';
%     % % make a matrix of the same size as the group data with the row sums
%     %     nmatrix = repmat(rowsum,1,size(bgrouphist,2));
%     % % then divide to get pdf for each subject
%     %     bgrouphist = bgrouphist./nmatrix;
%     %     take the average for each column but discarding nan rows
%     bsrp(b,:) = nansum(bgrouphist)./(size(bgrouphist,1)-sum(isnan(bgrouphist(:,1))));
% end
% 
% 
% % get some 95% confidence intervals
% 
% YCI=prctile(bsrp,h.ci);
% Ymedian = prctile(bsrp,50);
% 
% 
% 
% figure('Name',['bootstrapped 95% ci for ' roi ' ' h.param],'Color',[1 1 1]);
% 
% subplot(2,1,1);
% plot(h.bins(1):h.binsize:h.bins(2),bsrp);
% title('raw counts');
% ylabel('number of voxels');
% xlabel(h.param);
% box off;
% subplot(2,1,2);
% errorbar3(h.bins(1):h.binsize:h.bins(2),Ymedian,YCI,1,[1 0 0]);
% hold on;
% plot(h.bins(1):h.binsize:h.bins(2),Ymedian,'r-');
% title('raw counts');
% ylabel('number of voxels');
% xlabel(h.param);
% 
% 
% set(gcf,'UserData',{grouphist,h,bsrp,YCI,Ymedian,rawdata});
% saveas(gcf,[h.savedir roi '.' h.param '.counts.groupplotscis.fig'],'fig');
% saveas(gcf,[h.savedir roi '.' h.param '.counts.groupplotscis.png'],'png');
% 
% 
% end
% 
% 
% 


function   makePRFhists(roi,h)

% opens pRF2sel.mat file and makes individual and group histograms of param
% roi name of .mat file to use
% h is a struct which specifies plotting
% %
% h =
% h.param: 'sigma'
% h.bins: [0 24];
% h.binsize: .5
% h.threshco: 0
% h.threshecc: [0 12]
% h.threshsigma: [0 24]
% h.savedir: [1x96 char]


% open .mat file
% loads rm struct into workspace
load(roi);

% rm{1}
%      coords: [3x520 single]
%     indices: [520x1 double]
%        name: 'r_cos_pVf_001_nw'
%     curScan: 1
%          vt: 'Gray'
%          co: [1x520 double]
%      sigma1: [1x520 double]
%      sigma2: [1x520 double]
%       theta: [1x520 double]
%        beta: [520x3 double]
%          x0: [1x520 double]
%          y0: [1x520 double]
%          ph: [1x520 double]
%         ecc: [1x520 double]
%     session: '42111_MN'


% find subplot size
[m n] = subplotsize(length(rm));

% variable to hold our group histogram data
grouphist = [];

% make histogram with each subject
figure('Name',['distribution of ' h.param ' in ' roi], 'Color', [1 1 1]);
hold on;
% for each subject
for s=1:length(rm)
    %     make a subplot
    subplot(m,n,s);
    
    
    
    %     get index to values satisfying thresholds
    indx = 1:length(rm{s}.co);
    %     threshold by coherence
    coindx = find(rm{s}.co>=h.threshco);
    %     good voxels by coherence
    indx = intersect(indx,coindx);
    % threshold by ecc
    eccindx = intersect(find(rm{s}.ecc>=h.threshecc(1)),find( rm{s}.ecc<=h.threshecc(2)));
    %     goodvoxels by eccentricity
    indx = intersect(indx,eccindx);
    %     good voxels by sigma
    sigindx = intersect(find(rm{s}.sigma1>=h.threshsigma(1)),find( rm{s}.sigma1<=h.threshsigma(2)));
    
    indx = intersect(indx,sigindx);
    
    %         initialize measure
            rawdata = [];
            meas = [];
            medvalue = [];
    %     skip if no voxels are above thresholds
    if ~isempty(indx)
        

        %     choose a param and plot and store values for that subject
        switch(h.param)
            case('co')
                %             make plot
                histc(rm{s}.co(indx),h.bins(1):h.binsize:h.bins(2));
                %         save the hist for the group plot
                histdata = histc(rm{s}.co(indx),h.bins(1):h.binsize:h.bins(2));
                meas = 'var exp';
                %             get the median value
                medvalue=median(rm{s}.co(indx));
%                 raw data values
                rawdata{s} = rm{s}.co(indx);
                
            case('sigma')
                %             make plot
                hist(rm{s}.sigma1(indx),h.bins(1):h.binsize:h.bins(2));
                %         save the hist for the group plot
                histdata = hist(rm{s}.sigma1(indx),h.bins(1):h.binsize:h.bins(2));
                meas = 'prf sigma';
                %               get the median value
                medvalue=median(rm{s}.sigma1(indx));
                %                 raw data values
                rawdata{s} = rm{s}.sigma1(indx);
            case('x')
                %             make plot
                hist(rm{s}.x0(indx),h.bins(1):h.binsize:h.bins(2));
                %         save the hist for the group plot
                histdata = histc(rm{s}.x0(indx),h.bins(1):h.binsize:h.bins(2));
                meas = 'x pos';
                %               get the median value
                medvalue=median(rm{s}.x0(indx));
                %                 raw data values
                rawdata{s} = rm{s}.x(indx);
            case('y')
                %             make plot
                hist(rm{s}.y0(indx),h.bins(1):h.binsize:h.bins(2));
                %         save the hist for the group plot
                histdata = histc(rm{s}.y0,h.bins(1):h.binsize:h.bins(2));
                meas = 'y pos';
                %               get the median value
                medvalue=median(rm{s}.y0(indx));
                %                 raw data values
                rawdata{s} = rm{s}.y(indx);
            case('ecc')
                %             make plot
                hist(rm{s}.ecc(indx),h.bins(1):h.binsize:h.bins(2));
                %         save the hist for the group plot
                histdata = histc(rm{s}.ecc(indx),h.bins(1):h.binsize:h.bins(2));
                meas = 'ecc';
                %               get the median value
                medvalue=median(rm{s}.ecc(indx));
                %                 raw data values
                rawdata{s} = rm{s}.ecc(indx);
        end
        
        %     add to groupdata
        grouphist = [grouphist; histdata];
        
    end
    %     clean up plot
    %     label plot
    title(rm{s}.session,'FontSize',10);
    
    if ~isempty(meas)
        xlabel('no voxels');
    else
    
    xlabel(['median ' meas ' is ' num2str(medvalue)]);
    end
    hold on;
    
    box off;
    
    meas = [];
    
end

% attach some stuff to the plot



% save the plot

saveas(gcf,[h.savedir roi '.' h.param '.subplots.png'],'png');
close(gcf);



% now some group figures
% fixed effects would just take all the voxels we have across subjects and
% just lump them together
% do unnormalized and normalized

figure('Name',['All voxels in ' roi ' ' h.param],'Color',[1 1 1]);
hold on;
% first not normalized for different numbers of voxels
subplot(2,1,1);
bar(h.bins(1):h.binsize:h.bins(2),sum(grouphist));
title('raw data');
ylabel('number of voxels');
xlabel(h.param);
% set(gca,'XTick',h.bins(1):h.binsize:h.bins(2),'XTickLabel',h.bins(1):h.binsize:h.bins(2));
box off;
% then normalized
subplot(2,1,2);
% normalize each row by the sum
% need to deal with empty rows when subject has no voxel above threshold
% get the number of voxels for each subject (the sume of the row)
rowsum = sum(grouphist')';
% divide the entry in each row by the sum of the row
nmatrix = repmat(rowsum,1,size(grouphist,2));
% then divide to get proportion for each subject
ngrouphist = grouphist./nmatrix;
% checked, these rows now sum to 1
% sometimes subjects will have no above threshold data need to divide by
% only the number of subjects that do
bar(h.bins(1):h.binsize:h.bins(2),nansum(ngrouphist)./(size(ngrouphist,1)-sum(isnan(ngrouphist(:,1)))));
title('normalized data');
ylabel('proportion of voxels');
xlabel(h.param);
% set(gca,'XTick',h.bins(1):h.binsize:h.bins(2),'XTickLabel',h.bins(1):h.binsize:h.bins(2));
box off;

% want to add data to this so we can make figure across rois
set(gcf,'UserData',{grouphist,h});
saveas(gcf,[h.savedir roi '.' h.param '.groupplots.fig'],'fig');
saveas(gcf,[h.savedir roi '.' h.param '.groupplots.png'],'png');
close(gcf);


% let's bootstrap some error bars.
% we are interested in our best estimate of the distribution.  so I think
% we would generate many distributions by sampling from the subjects and
% then getting an error bar from that
% our subjects are in grouphist (nsubjects x data)

% number of bootstrps
nbstrps = 500;

for b=1:nbstrps
%     make random index with replacement
    bindx = randi(size(grouphist,1),[1,size(grouphist,1)]);
%     get a new sample with random rows
    bgrouphist = grouphist(bindx, :);
%     get the sum of each row
    rowsum = sum(bgrouphist')';
% make a matrix of the same size as the group data with the row sums
    nmatrix = repmat(rowsum,1,size(bgrouphist,2));
% then divide to get pdf for each subject
    bgrouphist = bgrouphist./nmatrix;
%     take the average for each column but discarding nan rows
    bsrp(b,:) = nansum(bgrouphist)./(size(bgrouphist,1)-sum(isnan(bgrouphist(:,1))));
end


% get some 95% confidence intervals

 YCI=prctile(bsrp,h.ci);
Ymedian = prctile(bsrp,50);



figure('Name',['bootstrapped 95% ci for ' roi ' ' h.param],'Color',[1 1 1]);
subplot(2,1,1);
plot(h.bins(1):h.binsize:h.bins(2),bsrp);
title('normalized data');
ylabel('proportion of voxels');
xlabel(h.param);
box off;
subplot(2,1,2);
errorbar3(h.bins(1):h.binsize:h.bins(2),Ymedian,YCI,1,[1 0 0]);
hold on;
plot(h.bins(1):h.binsize:h.bins(2),Ymedian,'r-');
title('normalized data');
ylabel('proportion of voxels');
xlabel(h.param);
set(gcf,'UserData',{grouphist,h,bsrp,YCI,Ymedian,rawdata});
saveas(gcf,[h.savedir roi '.' h.param '.norm.groupplotscis.fig'],'fig');
saveas(gcf,[h.savedir roi '.' h.param '.norm.groupplotscis.png'],'png');



% let's bootstrap some error bars on the raw counts.
% we are interested in our best estimate of the distribution.  so I think
% we would generate many distributions by sampling from the subjects and
% then getting an error bar from that
% our subjects are in grouphist (nsubjects x data)

% number of bootstrps
nbstrps = 500;

for b=1:nbstrps
%     make random index with replacement
    bindx = randi(size(grouphist,1),[1,size(grouphist,1)]);
%     get a new sample with random rows
    bgrouphist = grouphist(bindx, :);
%     get the sum of each row
%     rowsum = sum(bgrouphist')';
% % make a matrix of the same size as the group data with the row sums
%     nmatrix = repmat(rowsum,1,size(bgrouphist,2));
% % then divide to get pdf for each subject
%     bgrouphist = bgrouphist./nmatrix;
%     take the average for each column but discarding nan rows
    bsrp(b,:) = nansum(bgrouphist)./(size(bgrouphist,1)-sum(isnan(bgrouphist(:,1))));
end


% get some 95% confidence intervals

 YCI=prctile(bsrp,h.ci);
Ymedian = prctile(bsrp,50);



figure('Name',['bootstrapped 95% ci for ' roi ' ' h.param],'Color',[1 1 1]);

subplot(2,1,1);
plot(h.bins(1):h.binsize:h.bins(2),bsrp);
title('raw counts');
ylabel('number of voxels');
xlabel(h.param);
box off;
subplot(2,1,2);
errorbar3(h.bins(1):h.binsize:h.bins(2),Ymedian,YCI,1,[1 0 0]);
hold on;
plot(h.bins(1):h.binsize:h.bins(2),Ymedian,'r-');
title('raw counts');
ylabel('number of voxels');
xlabel(h.param);


set(gcf,'UserData',{grouphist,h,bsrp,YCI,Ymedian,rawdata});
saveas(gcf,[h.savedir roi '.' h.param '.counts.groupplotscis.fig'],'fig');
saveas(gcf,[h.savedir roi '.' h.param '.counts.groupplotscis.png'],'png');


end





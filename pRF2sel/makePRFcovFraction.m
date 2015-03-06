function   makePRFcovFraction(roi,h)

% opens pRF2sel.mat file and makes individual and groupcoverage fraction of param
% roi name of .mat file to use
% h is a struct which specifies plotting
% %
% h =
% h.param: 'x'
% h.bins: [0 24];
% h.binsize: .5
% h.threshco: 0
% h.threshecc: [0 12]
% h.threshsigma: [0 24]
% h.width 2
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


% xaxis value so we don't recompute it all the time
xvals = h.bins(1):h.binsize:h.bins(2);
% find subplot size
[m n] = subplotsize(length(rm));

% variable to hold our group histogram data
grouphist = [];

% make histogram with each subject
figure('Name',['coverage of ' h.param ' in ' roi], 'Color', [1 1 1]);
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
    
    %     skip if no voxels are above thresholds
    if ~isempty(indx)
        
        %     choose a param and plot and store values for that subject
        switch(h.param)
            case('x')
                %             make plot
                %                 build coverage histogram
                % must be a way to vectorize this code!
                % store data for subject
                coverage=[];
                for v=indx
                    %                     starting covereage is nothing
                    xcov= zeros(1,length(xvals));
                    %                     find x values within n sigmas of center
                    
                    abovethresh = find(xvals>=rm{s}.x0(v)-h.threshwidth*rm{s}.sigma1(v));
                    belowthresh = find(xvals<=rm{s}.x0(v)+h.threshwidth*rm{s}.sigma1(v));
                    %                     find values on x axis within this range
                    xcov(intersect(abovethresh,belowthresh))=1;
                    coverage = [coverage; xcov];
                    %                     plot stuff
                    measure = 'x pos';
                end
                %                now get the average coverage for that subject
                s_covfraction = sum(coverage)/size(coverage,1);
                
        end
        
        %     add to groupdata
        grouphist = [grouphist; s_covfraction];
        
    end
    %     clean up plot
    %     label plot
    title(rm{s}.session,'FontSize',10);
    
    %     plot(xvals,s_covfraction,'r--');
    bar(xvals,s_covfraction);
    xlabel([h.param ' in degrees']);
    hold on;
    
    box off;
    
    
end

% attach some stuff to the plot

% save the plot
%
% saveas(gcf,[h.savedir rm{1}.name '.' h.param '.subplots.png'],'png');
% close(gcf);




% now some group figures
% fixed effects would just take all the voxels we have across subjects and
% just lump them together
% do unnormalized and normalized

figure('Name',['All voxels in ' rm{1}.name ' ' h.param],'Color',[1 1 1]);
hold on;
% normalize each row by the sum
% need to deal with empty rows when subject has no voxel above threshold
% might be some weirdness with nans here. not sure
ngrouphist = sum(grouphist)/size(grouphist,1);
% sometimes subjects will have no above threshold data need to divide by
% only the number of subjects that do
bar(xvals,ngrouphist);
title('normalized data');
ylabel('fraction of coverage');
xlabel(h.param);
% set(gca,'XTick',h.bins(1):h.binsize:h.bins(2),'XTickLabel',h.bins(1):h.binsize:h.bins(2));
box off;
set(gca,'YLim',[0 1]);
%
%
% % want to add data to this so we can make figure across rois
% set(gcf,'UserData',{grouphist,h});
% saveas(gcf,[h.savedir roi '.' h.param '.groupplots.fig'],'fig');
% saveas(gcf,[h.savedir roi '.' h.param '.groupplots.png'],'png');
% % close(gcf);

end





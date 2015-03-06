function  roiData = PlotROIStats(roistoload,measure,threshold,sessionstouse)


% loads rois data created by pRF2Sel.  finds mean and stddev of ROI size
% across subjects for an ROI and makes a plot showing the sizes for each
% roi
% roistoload is a cell array of paths to .mat files to load
% measure is what you want to plot across subjects and rois
% size, retvarexp, locvarexp, glmvarexp,
% threshold is not yet implemented

% make some variables

roiData.sessions = {};
roiData.subdata = [];
roiData.name = [];

%  open up a figure
figure('Name','roi size comparison','Color',[1 1 1]);

% go through our rois
for i=1:length(roistoload)
    % load an roi
    load(roistoload{i});
    %     loop across subjects and get data from rm struct you just loaded
    roiData(i).name = rm{i}.name;
    %     add the name of the measure being aggregated
    roiData(i).measure = measure;
    
    %     figure out which sessions you want to use
    %     can't preallocate since we don't know how many we will have

    %     now collect it from across subjects
    for s=1:length(rm)
        
        
        %     get index to values satisfying thresholds
        indx = 1:length(rm{s}.co);
        %     threshold by coherence
        coindx = find(rm{s}.co>=threshold.co);
        %     good voxels by coherence
        indx = intersect(indx,coindx);
        % threshold by ecc
        eccindx = intersect(find(rm{s}.ecc>=threshold.ecc(1)),find( rm{s}.ecc<=threshold.ecc(2)));
        %     goodvoxels by eccentricity
        indx = intersect(indx,eccindx);
        %     good voxels by sigma
        sigindx = intersect(find(rm{s}.sigma1>=threshold.sigma(1)),find( rm{s}.sigma1<=threshold.sigma(2)));
        
        indx = intersect(indx,sigindx);
        
        
        
        
        %         subject names
        roiData(i).sessions(s) = {rm{s}.session};
        
        
        %       make a switch here to decide which measure to collect
        %         need to make some decisions about whether we are taking means or
        %         medians  (median might be better)
        
        switch(measure)
            case('size')
                roiData(i).subdata = [roiData(i).subdata length(rm{s}.coords(indx))];
            case('retvarexp')
                %                 roiData(i).subdata = [roiData(i).subdata mean(rm{s}.co)];
                roiData(i).subdata = [roiData(i).subdata median(rm{s}.co(indx))];
            case('ecc')
                roiData(i).subdata = [roiData(i).subdata median(rm{s}.ecc(indx))];
            case('sigma')
                roiData(i).subdata = [roiData(i).subdata median(rm{s}.sigma1(indx))];
                
        end
    end
    
%    sometimes we don't want all the control subjects so best to remove
%    them now.
    if i==1
        %find index to good sessions
        keepsess = [];
        for su=1:length(sessionstouse)
            keepsess = [keepsess find(strcmp(roiData(1).sessions,sessionstouse{su}))];
        end
        
        
        %then restrict roiData(1) to just those sessions
        %can't figure out how not to have this loop
        for k=1:length(keepsess)
        tempsessions{k} = roiData(1).sessions{keepsess(k)};
        end
        roiData(1).sessions = tempsessions;
        roiData(1).subdata =roiData(1).subdata(keepsess);
        
        
    end
    
    
    %     plot data from that roi
    
    scatter(i*ones(1,length(roiData(i).sessions)),roiData(i).subdata,'k');
    hold on;
    scatter(i, median(roiData(i).subdata),'r');
    scatter(i, mean(roiData(i).subdata),'g');
    
    %     let's record these
    roiData(i).median = median(roiData(i).subdata);
    roiData(i).mean = mean(roiData(i).subdata);
    
    %     let's add the names to the figure so we can see who is who
    text(i*ones(1,length(roiData(i).sessions)),roiData(i).subdata,roiData(i).sessions);
end

% fix x axis
set(gca,'XLim', [0, length(roistoload)+1]);

% title
title(rm{1}.name,'interpreter','none');

% add data to figure
set(gcf,'UserData',roiData);

% add in some pairwise ttests for each pair of rois








end
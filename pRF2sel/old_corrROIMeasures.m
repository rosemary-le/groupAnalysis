function  roiData = corrROIMeasures(roistoload,threshold)


% loads rois data created by pRF2Sel.  finds mean and stddev of ROI size
% across subjects for an ROI and makes a plot showing the sizes for each
% roi
% roistoload is a cell array of paths to .mat files to load
% measure is what you want to plot across subjects and rois
% size, retvarexp, locvarexp, glmvarexp,
% threshold is not yet implemented

% make some variables

roiData.sessions = {};
roiData.size = [];
roiData.sigma = [];
roiData.ecc = [];
roiData.co = [];
roiData.name = [];




% load an roi
load(roistoload);
%     loop across subjects and get data from rm struct you just loaded
roiData.name = rm{1}.name;



%     now collect it from across subjects
for s=1:length(rm)
    
    
    %     get index to values satisfying thresholds
    indx = 1:length(rm{s}.co);
    %     threshold by coherence
    coindx = find(rm{s}.co>=threshold.threshco);
    %     good voxels by coherence
    indx = intersect(indx,coindx);
    % threshold by ecc
    eccindx = intersect(find(rm{s}.ecc>=threshold.threshecc(1)),find( rm{s}.ecc<=threshold.threshecc(2)));
    %     goodvoxels by eccentricity
    indx = intersect(indx,eccindx);
    %     good voxels by sigma
    sigindx = intersect(find(rm{s}.sigma1>=threshold.threshsigma(1)),find( rm{s}.sigma1<=threshold.threshsigma(2)));
    
    indx = intersect(indx,sigindx);
    
    
    
    
    %   set subject name
    roiData.sessions(s) = {rm{s}.session};
    
    %         get all measures
    
    roiData.size = [roiData.size length(rm{s}.coords(indx))];
    roiData.co = [roiData.co median(rm{s}.co(indx))];
    roiData.ecc = [roiData.ecc median(rm{s}.ecc(indx))];
    roiData.sigma = [roiData.sigma median(rm{s}.sigma1(indx))];
    
end  
    
    
    
    %find index to good sessions
    keepsess = [];
    for su=1:length(threshold.sessionstouse)
        keepsess = [keepsess find(strcmp(roiData.sessions,threshold.sessionstouse{su}))];
    end
    
    
    %then restrict roiData to just those sessions we want
    %can't figure out how not to have this loop
    for k=1:length(keepsess)
        tempsessions{k} = roiData.sessions{keepsess(k)};
    end
    roiData.sessions = tempsessions;
    roiData.size =roiData.size(keepsess);
    roiData.co =roiData.co(keepsess);
    roiData.ecc =roiData.ecc(keepsess);
    roiData.sigma =roiData.sigma(keepsess);

%  open up a figure
corrfig=figure('Name',roiData.name,'Color',[1 1 1]);
%     6 subplots
    subplot(3,2,1);
    [rho p] = corr([roiData.size', roiData.co'], 'type', 'Spearman');
    scatter(roiData.size, roiData.co,'r.');
    xlabel('size');ylabel('co');
    title(['rho=' num2str(rho(1,2)) '  p=' num2str(p(1,2))]);
        subplot(3,2,2);
    [rho p] = corr([roiData.size', roiData.ecc'], 'type', 'Spearman');
    scatter(roiData.size, roiData.ecc,'r.');
    xlabel('size');ylabel('ecc');
    title(['rho=' num2str(rho(1,2)) '  p=' num2str(p(1,2))]);
        subplot(3,2,3);
    [rho p] = corr([roiData.size', roiData.sigma'], 'type', 'Spearman');
    scatter(roiData.size, roiData.sigma,'r.');
    xlabel('size');ylabel('sigma');
    title(['rho=' num2str(rho(1,2)) '  p=' num2str(p(1,2))]);
        subplot(3,2,4);
    [rho p] = corr([roiData.ecc', roiData.co'], 'type', 'Spearman');
    scatter(roiData.ecc, roiData.co,'r.');
    xlabel('ecc');ylabel('co');
    title(['rho=' num2str(rho(1,2)) '  p=' num2str(p(1,2))]);
        subplot(3,2,5);
    [rho p] = corr([roiData.ecc', roiData.sigma'], 'type', 'Spearman');
    scatter(roiData.ecc, roiData.sigma,'r.');
    xlabel('ecc');ylabel('sigma');
    title(['rho=' num2str(rho(1,2)) '  p=' num2str(p(1,2))]);
        subplot(3,2,6);
    [rho p] = corr([roiData.sigma', roiData.co'], 'type', 'Spearman');
    scatter(roiData.sigma, roiData.co,'r.');
    xlabel('sigma');ylabel('co');
    title(['rho=' num2str(rho(1,2)) '  p=' num2str(p(1,2))]);
    
    
%     save the figure

saveas(gcf,[threshold.savedir roiData.name '.correlations.subplots.png'],'png');
% close(gcf);



end
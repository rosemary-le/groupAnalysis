function    f_corrROIMeasures(roiData)

% takes a struct ROIdata with fields
% .co  .size .sigma . ecc
% each of these fields has the median (or other measure) value of this
% parameter for each subject with that roi
% computes the all 6 possible correlations between these measures


%  open up a figure
corrfig=figure('Name',roiData.name{1},'Color',[1 1 1], 'Position', get(0,'ScreenSize'));
title(roiData.name);

%     6 subplots

% could add text labels at the points
subplot(3,2,1);
[rho p] = corr([roiData.size', roiData.co'], 'type', 'Spearman');
scatter(roiData.size, roiData.co,'r.');
text(roiData.size, roiData.co, roiData.sessions);
xlabel('size');ylabel('co');
title(['rho=' num2str(rho(1,2)) '  p=' num2str(p(1,2))]);


subplot(3,2,2);
[rho p] = corr([roiData.size', roiData.ecc'], 'type', 'Spearman');
scatter(roiData.size, roiData.ecc,'r.');
text(roiData.size, roiData.ecc, roiData.sessions);
xlabel('size');ylabel('ecc');
title(['rho=' num2str(rho(1,2)) '  p=' num2str(p(1,2))]);


subplot(3,2,3);
[rho p] = corr([roiData.size', roiData.sigma'], 'type', 'Spearman');
scatter(roiData.size, roiData.sigma,'r.');
text(roiData.size, roiData.sigma, roiData.sessions);
xlabel('size');ylabel('sigma');
title(['rho=' num2str(rho(1,2)) '  p=' num2str(p(1,2))]);


subplot(3,2,4);
[rho p] = corr([roiData.ecc', roiData.co'], 'type', 'Spearman');
scatter(roiData.ecc, roiData.co,'r.');
text(roiData.ecc, roiData.co, roiData.sessions);
xlabel('ecc');ylabel('co');
title(['rho=' num2str(rho(1,2)) '  p=' num2str(p(1,2))]);


subplot(3,2,5);
[rho p] = corr([roiData.ecc', roiData.sigma'], 'type', 'Spearman');
scatter(roiData.ecc, roiData.sigma,'r.');
text(roiData.ecc, roiData.sigma, roiData.sessions);
xlabel('ecc');ylabel('sigma');
title(['rho=' num2str(rho(1,2)) '  p=' num2str(p(1,2))]);


subplot(3,2,6);
[rho p] = corr([roiData.sigma', roiData.co'], 'type', 'Spearman');
scatter(roiData.sigma, roiData.co,'r.');
text(roiData.sigma, roiData.co, roiData.sessions);
xlabel('sigma');ylabel('co');
title(['rho=' num2str(rho(1,2)) '  p=' num2str(p(1,2))]);


%     save the figure
% close(gcf);
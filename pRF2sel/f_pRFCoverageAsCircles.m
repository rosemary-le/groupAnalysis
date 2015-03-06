%% plots prf as circles
% input rm should contain fields
%
% x0
% y0
% sigma1
% sigma2

function hf = f_pRFCoverageAsCircles(rm,h)
% takes rm struct (of one subject) and makes coverage plot with circles
% rm   struct with receptive field data
% h struct with plotting paramters
%     .alpha is transparency level for each circle



% check that x0, y0, sigma1, and sigma2 have the same lengths
if (length(rm.x0) ~= length(rm.y0)) || (length(rm.sigma1) ~= length(rm.sigma2)) || (length(rm.x0) ~= length(rm.sigma1))
    error('Check lengths of x0, y0, sigma1 and sigma2')
end

set(0, 'DefaultTextInterpreter', 'none'); 

figure();

%% plot the circle centers
% plot the centers: (rm.x0(ii), rm.y0(ii))
% hf = plot(rm.x0, rm.y0,'.k');
hold on

t = 0:0.01:2*pi;
   

hf = 'awesome'; %get rid of this later.....

%% plotting the circles

for ii = 1:length(rm.x0)

    x0     = rm.x0(ii); 
    y0     = rm.y0(ii); 
    sigma1 = rm.sigma1(ii); 
    sigma2 = rm.sigma2(ii); 
    
    X = x0 + sigma1*cos(t); 
    Y = y0 + sigma2*sin(t); 
    
    % plot each circle
%     plot(X,Y,'k','FaceAlpha',0.5)
    
    p(ii) = patch(X,Y,'k','FaceColor','none','EdgeAlpha',h.alpha);
% 
%     p(ii) = patch(X,Y,'k','EdgeColor','none','FaceAlpha',.1);
end

%% figure properties

% change the axes to be centered and square
xlimits = get(gca, 'XLim');
ylimits = get(gca, 'YLim');

xmax    = max(abs(xlimits(1)), abs(xlimits(2))); 
ymax    = max(abs(ylimits(1)), abs(ylimits(2))); 

% themax  = max(xmax, ymax); 
themax = 20; 
    
set(gca, 'XLim', [-themax themax]); 
set(gca, 'YLim', [-themax themax]); 

axis square

% lines at vertical and horizontal meridian
line([-themax themax], [0 0], 'Color', [0 0 0]); 
line([0 0], [-themax themax], 'Color', [0 0 0]);

% title
title([rm.name ' - ' rm.session], 'FontSize', 24);


end


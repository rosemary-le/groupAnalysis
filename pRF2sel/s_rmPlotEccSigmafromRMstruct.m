
% this is the mrVista function that plots receptive field size as a
% function of eccentricity for a given roi.   Its clear from the plots that
% it makes a couple of adjustments.  want to figure out what they are and
% then turn it into a group plotting tool.




function data = rmPlotEccSigmafromRMstruct(prfFits, rm)
%based on serges function rmPlotEccSigma - plot sigma versus eccentricity in selected ROI
% 
% data = rmPlotEccSigma(rm, rmParams);
%
% Input
% prfFits is a struct with these fields
% 
%      coords: [3x501 single]
%     indices: [501x1 double]
%        name: 'rTO2_nw'
%     curScan: 1
%          vt: 'Gray'
%          co: [1x501 double]
%      sigma1: [1x501 double]
%      sigma2: [1x501 double]
%       theta: [1x501 double]
%        beta: [501x3 double]
%          x0: [1x501 double]
%          y0: [1x501 double]
%          ph: [1x501 double]
%         ecc: [1x501 double]
%     session: '42611_AH'

% rmParams is a struct which contains various variables controlling the
% plotting 
%   fwhm = 0,1   width of gaussian or fwhm, defaults to 0
%   binsize = 0.5  in degrees how to bin the data for averaging and
%   plotting
%   cothresh = .1  thresholds data based on co field
%   sigthresh = [0 30]  sigma threshold in degrees
%   eccthresh = [0 30]  ecc threshold in degrees

% check defaults
plot_pv=0;
plotFlag =1;
titleName = 'size vs ecc';

% you could either plot the sigma (width of the gaussian (0) or the fwhm
% (1)
if ~isfield(rm,'fwhm')
    fwhm=0;
end

% theshold of coherence of the model
if ~isfield(rm,'cothresh')
    rm.cothresh  = .1;
end

% eccentricity thresholds
if ~isfield(rm, 'eccthresh')
    rm.eccthresh = [0 30];
end

% sigma thresholds
if ~isfield(rm, 'sigthresh')
    rm.sigthresh = [0 30];
end


% binsize
if ~isfield(rm, 'binsize')
    rm.binsize = 0.5;
end


%--- plotting parameters
xaxislim = [0 30];
MarkerSize = 8;
% 



% % % % select subset of models to plot

% threshold data by coherence
abovethresh = find(prfFits.co>= rm.cothresh);
prfFits.subEcc = prfFits.ecc(abovethresh);
prfFits.subSize1 = prfFits.sigma1(abovethresh);
prfFits.subCo = prfFits.co(abovethresh);


% threshold data by eccentricity and sigma
ii = prfFits.subEcc > rm.eccthresh(1) & prfFits.subEcc < rm.eccthresh(2) & ...
     prfFits.subSize1 > rm.sigthresh(1) & prfFits.subSize1 < rm.sigthresh(2);

% %  sometimes there is no data to plot because the way the thresholds for
% size and eccentricity are chosen.  in that case ii will be all zeros
% this should be less problematic with the pRF fits that go for broad
% eccentricities

% weighted linear regression:
roi.p = linreg(prfFits.subEcc(ii),prfFits.subSize1(ii),prfFits.subCo(ii));
roi.p = flipud(roi.p(:)); % switch to polyval format
xfit = rm.eccthresh;
yfit = polyval(roi.p,xfit);



% bootstrap confidence intervals
if exist('bootstrp','file') 
%     B = bootstrp(1000,@(x) localfit(x,prfFits.subEcc(ii),prfFits.subSize1(ii),prfFits.subCo(ii)),(1:numel(prfFits.subEcc(ii))));
        B = bootstrp(1000,@(x) localfit(x,prfFits.subEcc(ii),prfFits.subSize1(ii),prfFits.subCo(ii)),(1:numel(prfFits.subEcc(ii))));
    
    %      B = bootstrp(1000,@(x) localfit(x,roi.ecc(ii),roi.sigma(ii),prfFits.subCo(ii)),(1:numel(roi.ecc(ii))));
    B = B';
    pct1 = 100*0.05/2;
    pct2 = 100-pct1;
    b_lower = prctile(B',pct1);
    b_upper = prctile(B',pct2);
    keep1 = B(1,:)>b_lower(1) &  B(1,:)<b_upper(1);
    keep2 = B(2,:)>b_lower(2) &  B(2,:)<b_upper(2);
    keep = keep1 & keep2;
    b_xfit = linspace(min(xfit),max(xfit),100)';
    fits = [ones(100,1) b_xfit]*B(:,keep);
    b_upper = max(fits,[],2);
    b_lower = min(fits,[],2);
end

if plot_pv
    roi.p2 = linreg(prfFits.subEcc(ii),roi.pv(ii),prfFits.subCo(ii));
    roi.p2 = flipud(roi.p2(:)); % switch to polyval format
    y2fit = polyval(roi.p2,xfit);
end

% output struct
data.xfit = xfit(:);
data.yfit = yfit(:);
data.x    = (rm.eccthresh(1):rm.binsize:rm.eccthresh(2))';
data.y    = nan(size(data.x));
data.ysterr = nan(size(data.x));
data.roi = roi;

if plot_pv
    data.y2fit = y2fit(:);
    data.y2    = nan(size(data.x));
    data.y2sterr = nan(size(data.x));
end

% plot averaged data
% so go across the eccentricities in some step specified by binsize
for b=rm.eccthresh(1):rm.binsize:rm.eccthresh(2),
%     find the fits that are in that bin and inside the specified
%     thresholds
    bii = prfFits.subEcc >  b-rm.binsize./2 & ...
          prfFits.subEcc <= b+rm.binsize./2 & ii;
%       if there are any
    if any(bii),
        % weighted mean of sigma
%         compute the weighted mean of sigma for that group
        s = wstat(prfFits.subSize1(bii),prfFits.subCo(bii));
%         what about unweighted?
%         s = wstat(prfFits.subSize1(bii));
           % store
        ii2 = find(data.x==b);
        data.y(ii2) = s.mean;
        data.ysterr(ii2) = s.sterr;
        
        if plot_pv
            % weighted mean of position variance
            s = wstat(roi.pv(bii),prfFits.subCo(bii));
            % store
            data.y2(ii2) = s.mean;
            data.y2sterr(ii2) = s.sterr;
        end
    else
       fprintf(1,'[%s]:Warning:No data in eccentricities %.1f to %.1f.\n',...
            mfilename,b-rm.binsize./2,b+rm.binsize./2);
    end;
end;

% plot if requested
if plotFlag==1,
    % plot first figure - all the individual voxels
    data.fig(1) = figure('Color', 'w');
    subplot(2,1,1); hold on;
    plot(prfFits.subEcc(~ii),prfFits.subSize1(~ii),'ko','markersize',2);
    plot(prfFits.subEcc(ii), prfFits.subSize1(ii), 'ro','markersize',2);
    ylabel('pRF size (sigma, deg)');xlabel('Eccentricity (deg)');
    h=axis;
    axis([xaxislim(1) xaxislim(2) 0 min(h(4),rm.sigthresh(2))]);
    title(titleName, 'Interpreter', 'none');

    subplot(2,1,2);hold on;
    plot(prfFits.subEcc(~ii),prfFits.subCo(~ii),'ko','markersize',2);
    plot(prfFits.subEcc(ii), prfFits.subCo(ii), 'ro','markersize',2);
	line(rm.eccthresh, [rm.cothresh rm.cothresh], 'Color', [.3 .3 .3], ...
			'LineWidth', 1.5, 'LineStyle', '--'); % varexp cutoff	
    ylabel('variance explained (%)');xlabel('Eccentricity (deg)');
    axis([xaxislim(1) xaxislim(2) 0 1 ]);

    
	data.fig(2) = figure('Color', 'w'); hold on;
    
    % plot V2, V3 with certain style the rest the same
    if ~isempty(strfind(lower(titleName),'v2')),
        errorbar(data.x,data.y,data.ysterr,'ko');
        plot(data.x,data.y,'ko',...
            'MarkerFaceColor',[1 1 1],...
            'MarkerSize',MarkerSize);
        plot(data.x,data.y,'kx',...
            'MarkerSize',MarkerSize);
        plot(xfit,yfit','k','LineWidth',2);
        
    elseif ~isempty(strfind(lower(titleName),'v3'))
        errorbar(data.x,data.y,data.ysterr,'ko');
        plot(data.x,data.y,'ko',...
            'MarkerFaceColor',[1 1 1],...
            'MarkerSize',MarkerSize);
        plot(xfit,yfit','k','LineWidth',2);
    else
        errorbar(data.x,data.y,data.ysterr,'ko',...
            'MarkerFaceColor','k',...
            'MarkerSize',MarkerSize);
        if plot_pv
            errorbar(data.x,data.y2,data.y2sterr,'ko',...
                'MarkerFaceColor','b',...
                'MarkerSize',MarkerSize);
        end
        plot(xfit,yfit','k','LineWidth',2);
        if plot_pv
            plot(xfit,y2fit','b','LineWidth',2);
            legend('pRF size', 'position variance','Location','NorthWest')
            ttlText = sprintf([' %s pRF size (y=%.2fx+%.2f) and ' ...
                'position variance (y=%.2fx+%.2f)'], ...
                titleName, roi.p(1), roi.p(2), roi.p2(1), ...
                roi.p2(2));
            
        else
            ttlText = sprintf('%s: y=%.2fx+%.2f',titleName,roi.p(1),roi.p(2));
        end
        title(ttlText, 'Interpreter', 'none');
    end

	yfit = polyval(roi.p,xfit);
    h = plot(xfit,yfit','b');
    set(h,'LineWidth',2);
    title( sprintf('%s: y=%.2fx+%.2f', titleName, roi.p(1), roi.p(2)), ...
        'FontSize', 24, 'Interpreter', 'none' );
    if exist('bootstrp','file')
        plot(b_xfit,b_upper,'r--');
        plot(b_xfit,b_lower,'g--');
    end
    ylabel('pRF size (sigma, deg)');xlabel('Eccentricity (deg)');
    h=axis;
    axis([xaxislim(1) xaxislim(2) floor(h(3)) ceil(h(4))]);
	
    if plot_pv
        text(1,h(4)*0.8,sprintf('%s: y=%.2fx+%.2f',titleName,roi.p(1),roi.p(2)));
        text(1,h(4)*0.4,sprintf('%s: y=%.2fx+%.2f',titleName,roi.p2(1),roi.p2(2)));
    end
end

return;


function B=localfit(ii,x,y,ve)
B = linreg(x(ii),y(ii),ve(ii));
B(:);
return


function [rm models] = f_sizeVSeccFromROI(rm, h)

% want this funtion to take a .mat file as an argument.
% that file should contain the rm params for n subjects
% given that and some parameters (thresholds), make a group size vs.
% eccentricity plot, as well as subplots for each subject.
% roiFile is path to roi that looks like


% h is a struct with the following fields
% thresh.varexp  minimum variance explained by model in each voxel 0-1
% default is .1
% thresh.sig  min and max sigma (size) to use [0 14]
% default is [.5 28]
% thresh.ecc is mim and max ecc to use, default is [.5 13.5]
% thresh.binsize =  how to bin on x axis 0.5

% we are interested in the variable rm
% roiData{1}
%
% ans =
%
%      coords: [3x3773 single]
%     indices: [3773x1 double]
%        name: 'lV1_nw'
%     curScan: 1
%          vt: 'Gray'
%          co: [1x3773 double]
%      sigma1: [1x3773 double]
%      sigma2: [1x3773 double]
%       theta: [1x3773 double]
%        beta: [3773x3 double]
%          x0: [1x3773 double]
%          y0: [1x3773 double]
%          ph: [1x3773 double]
%         ecc: [1x3773 double]
%     session: '42611_AH'


% plotting stuff
titleName =rm{1}.name;
%         %--- plotting parameters
xaxislim = [0 h.threshecc(2)];
MarkerSize = 8;
%         %
%     make save directory if it doesn't exist
if ~exist([h.saveDir 'sizeXecc/'],'dir')
    mkdir([h.saveDir 'sizeXecc/']);
end


% boot strapped line fits for each subject

for r=1:length(rm)
    
    %     kendrick's method
    % % generate some data
    % n = 100;
    % x = randn(1,n);
    % y = 10*x + 2 + 4*randn(1,n);
    
    % our data for each subject is
    x = rm{r}.ecc;
    y = rm{r}.sigma1;
    n = length(rm{r}.ecc);
    
    % set parameters for bootstrap
    numboots = 10000;  % number of bootstraps to perform
    xvals = h.threshecc(1):.1:h.threshecc(2);   % x-values to evaluate the model at
    
   % variables for bootstrap output
    modelfit = zeros(numboots,length(xvals));
    params = zeros(numboots,2);
    
    
     % perform the bootstraps
    for boot=1:numboots
        
        % prepare data indices
%         select random sample with replacement
        ix = ceil(n*rand(1,n));
        
%         linear model is ax+b
        % construct regressor matrix
        X = [x(ix)' ones(n,1)];
        
        % estimate parameters from this sample
        tempparams = inv(X'*X)*X'*y(ix)';
        
        % evaluate the model at desired x values
        modelfit(boot,:) = xvals*tempparams(1) + tempparams(2);
        
        % record the parameters
        params(boot,:) = tempparams;
        
    end
%     
%     % visualize
%     figure('Name',[rm{r}.session rm{r}.name],'Color',[1 1 1],'Position',get(0,'ScreenSize'));
%     hold on;
% %   add your data
%     h1 = scatter(x,y,'k.');
% 
% %     so you are taking the 2.5, 50, and 97.5 percentile data point from
% %     the distribution of y for every x.  
% %    this 50th percentile does not seem lie it has to be a line even, but
% %    this is a visualization and the test is on the parameters?
% %     modelfitP = prctile(modelfit,[2.5 50 97.5],1);
%     modelfitP = prctile(modelfit,[2.5 50 97.5]);
%     % define a polygon by following the 2.5th percentile line (left to right)
%     % and then reversing and following the 97.5th percentile line (right to
%     % left).
%     h2 = patch([xvals fliplr(xvals)],[modelfitP(1,:) fliplr(modelfitP(3,:))],[1 .7 .7]);
%     set(h2,'EdgeColor','none');
%     h3 = plot(xvals,modelfitP(2,:),'r-','LineWidth',2);
%     uistack(h1,'top');  % make sure data points are visible by bringing them to the top
%     xlabel('x');
%     ylabel('y');
%     paramsP = prctile(params,[2.5 97.5]);
%     title(sprintf('y=ax+b; 95%% confidence intervals: a=[%.1f %.1f], b=[%.1f %.1f]', ...
%         paramsP(1,1),paramsP(2,1),paramsP(1,2),paramsP(2,2)));
%     set(gca,'XLim',[0 h.threshecc(2)],'YLim',[0 h.threshsigma(2)]);
% %  add x=y line
%     plot(0:.1:h.threshecc(2),0:.1:h.threshecc(2),'k--');
% %     save 
% 
%     saveas(gcf,[h.saveDir 'sizeXecc/' rm{r}.session '.' rm{r}.name 'bootlinefit.png'],'png');
%     close(gcf);
    
end



% how would you do this as random effects?

% bin data for each subject


% for each subject
for r=1:length(rm)
    %     set the eccentricity bin axis
    rm{r}.eccbinsx = h.threshecc(1):h.binsize:h.threshecc(2);
    %     set y values to nans
    rm{r}.meanSigma = nan(1,length(rm{r}.eccbinsx));
    
    % get weighted mean in each bin
%     need to get track of which iteration we are in
    counter = 1;
    
    for b=h.threshecc(1):h.binsize:h.threshecc(2)
        %     bins are defined as centers of a bin with binsize/2 on either side
        %     get index to data in the current bin
        bii = rm{r}.ecc >  b-h.binsize./2 & ...
            rm{r}.ecc <= b+h.binsize./2 ;
%         & ii;
        
        %     assuming you found some data in your eccentricity bins
        if any(bii),
            % weighted mean of sigma
            s = wstat(rm{r}.sigma1(bii),rm{r}.co(bii));
            % get whichever x index you are at
            %         ii2 = find(pdata.x==b);
            %         %         set the y vector to be the mean and standard error for that x
            rm{r}.meanSigma(counter) = s.mean;
            %         pdata.y(ii2) = s.mean;
            %         pdata.ysterr(ii2) = s.sterr;

        else
            fprintf(1,'[%s]:Warning:No data in eccentricities %.1f to %.1f.\n',...
                mfilename,b-h.binsize./2,b+h.binsize./2);
        end
        counter = counter+1;
    end 
end

% or sample with replacement from all data
% let's try that first
x=[]; y=[];

for r=1:length(rm)
    x=[x rm{r}.eccbinsx];
    y=[y rm{r}.meanSigma];
    
end

% remove nans
   xii = find(~isnan(y));
   x=x(xii);
   y=y(xii);

% do bootstraps
 %     what's in here should probably also be a function
    %     kendrick's method
    % % generate some data
    % n = 100;
    % x = randn(1,n);
    % y = 10*x + 2 + 4*randn(1,n);
    n = length(x);
    
    % define
    numboots = 10000;  % number of bootstraps to perform
    xvals = h.threshecc(1):.1:h.threshecc(2);   % x-values to evaluate the model at
    
    % perform the bootstraps
    modelfit = zeros(numboots,length(xvals));
    params = zeros(numboots,2);
    
    for boot=1:numboots
        
        % prepare data indices
%         select random sample with replacement
        ix = ceil(n*rand(1,n));
        
%         linear model is ax+b
        % construct regressor matrix
        X = [x(ix)' ones(n,1)];
        
        % estimate parameters from this sampe
        tempparams = inv(X'*X)*X'*y(ix)';
        
        % evaluate the model at desired x values
        modelfit(boot,:) = xvals*tempparams(1) + tempparams(2);
        
        % record the parameters
        params(boot,:) = tempparams;
        
    end
    
    % visualize
    figure('Name',[rm{r}.name ' rfx bootstrap binx'],'Color',[1 1 1],'Position',get(0,'ScreenSize'));
    hold on;
%     add your data
    h1 = scatter(x,y,'k.');

%     so you are taking the 2.5, 50, and 97.5 percentile data point from
%     the distribution of y for every x.  
%    this 50th percentile does not seem lie it has to be a line even, but
%    this is a visualization and the test is on the parameters?
    modelfitP = prctile(modelfit,[2.5 50 97.5]);
    % define a polygon by following the 2.5th percentile line (left to right)
    % and then reversing and following the 97.5th percentile line (right to
    % left).
    h2 = patch([xvals fliplr(xvals)],[modelfitP(1,:) fliplr(modelfitP(3,:))],[1 .7 .7]);
    set(h2,'EdgeColor','none');
    h3 = plot(xvals,modelfitP(2,:),'r-','LineWidth',2);
    uistack(h1,'top');  % make sure data points are visible by bringing them to the top
    xlabel('x');
    ylabel('y');
    paramsP = prctile(params,[2.5 97.5]);
    title(sprintf('y=ax+b; 95%% confidence intervals: a=[%.1f %.1f], b=[%.1f %.1f]', ...
        paramsP(1,1),paramsP(2,1),paramsP(1,2),paramsP(2,2)));
    set(gca,'XLim',[0 h.threshecc(2)],'YLim',[0 h.threshsigma(2)]);
%  add x=y line
    plot(0:.1:h.threshecc(2),0:.1:h.threshecc(2),'k--');

    saveas(gcf,[h.saveDir h.group num2str(h.binsize) 'dgbins.sizeXeccbstrap.png'],'png');

% what might you want to keep from this?
%  x, y, n, modelfit, params
% can add in later for testing

models.x = x;
models.y = y;
models.n = n;
models.nboots = numboots;
models.modelfit = modelfit;
models.params = params;
models.model = X;
    
%   














%     
%  
% % sample with replacement from subjects

% % let's try that first
xsubs=[]; ysubs=[];


%each row in x and y will be a subject 
for r=1:length(rm)
    xsubs=[xsubs ;rm{r}.eccbinsx];
    ysubs=[ysubs ;rm{r}.meanSigma];
    
end
% 


%     number of samples on each trial
%   in this case subjects
    n = length(rm);
    
    % define bootstrap etc
    numboots = 10000;  % number of bootstraps to perform
    xvals = h.threshecc(1):.1:h.threshecc(2);   % x-values to evaluate the model at
    modelfit = zeros(numboots,length(xvals));
    params = zeros(numboots,2);
    
    for boot=1:numboots
        
        % prepare data indices
%         select random sample with replacement
        ix = ceil(n*rand(1,n));
        
%         make x and y
            x=[];y=[];
%  get sample subject and make x y vectors
        for smple = 1:length(ix)
            x=[x xsubs(ix(smple),:)];
            y=[y ysubs(ix(smple),:)];
        end
% % remove nans
   xii = find(~isnan(y));
   x=x(xii);
   y=y(xii);
        
        
%         linear model is ax+b
        % construct regressor matrix
        X = [x' ones(length(x),1)];
        
        % estimate parameters from this sampe
        tempparams = inv(X'*X)*X'*y';
        
        % evaluate the model at desired x values
        modelfit(boot,:) = xvals*tempparams(1) + tempparams(2);
        
        % record the parameters
        params(boot,:) = tempparams;
        
    end
    
    % visualize
    figure('Name',[rm{r}.name ' rfx bootstrap subjects'],'Color',[1 1 1],'Position',get(0,'ScreenSize'));
    hold on;
%     add your data
    h1 = scatter(x,y,'k.');

%     so you are taking the 2.5, 50, and 97.5 percentile data point from
%     the distribution of y for every x.  
%    this 50th percentile does not seem lie it has to be a line even, but
%    this is a visualization and the test is on the parameters?
    modelfitP = prctile(modelfit,[2.5 50 97.5]);
    % define a polygon by following the 2.5th percentile line (left to right)
    % and then reversing and following the 97.5th percentile line (right to
    % left).
    h2 = patch([xvals fliplr(xvals)],[modelfitP(1,:) fliplr(modelfitP(3,:))],[1 .7 .7]);
    set(h2,'EdgeColor','none');
    h3 = plot(xvals,modelfitP(2,:),'r-','LineWidth',2);
    uistack(h1,'top');  % make sure data points are visible by bringing them to the top
    xlabel('x');
    ylabel('y');
    paramsP = prctile(params,[2.5 97.5]);
    title(sprintf('y=ax+b; 95%% confidence intervals: a=[%.1f %.1f], b=[%.1f %.1f]', ...
        paramsP(1,1),paramsP(2,1),paramsP(1,2),paramsP(2,2)));
    set(gca,'XLim',[0 h.threshecc(2)],'YLim',[0 h.threshsigma(2)]);
%  add x=y line
    plot(0:.1:h.threshecc(2),0:.1:h.threshecc(2),'k--');

    saveas(gcf,[h.saveDir h.group num2str(h.binsize) 'dgbins.sizeXeccSubjectbstrap.png'],'png');

% what might you want to keep from this?
%  x, y, n, modelfit, params
% can add in later for testing

models.subx = x;
models.suby = y;
models.subn = length(models.subx);
models.subnboots = numboots;
models.submodelfit = modelfit;
models.subparams = params;
models.submodel = X;
    



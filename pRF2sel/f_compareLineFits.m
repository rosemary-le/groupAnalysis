function f_compareLineFits(th_controls, th_prosos,h)

% have bootstrapped line fits for prosos and controls (this could also be
% across rois, but that should be repeated measures)
% % one way to do this is to combine the slope estimates from the two groups
% and create two random samples from that combined distribution.  this is
% the null hypothesis that both samples came from the same distribution.
% calculate a difference between the two means.  bootstrap this.  find
% percentile of observed difference in bootstrapped distribution to get
% your pvalue.


% % % % % % % % % % % % % % % % % % 
% fit line to the control data
% % % % % % % % % % % % % % % % % % % 
xcontrols=[]; ycontrols=[];

for r=1:length(th_controls)
    xcontrols=[xcontrols th_controls{r}.eccbinsx];
    ycontrols=[ycontrols th_controls{r}.meanSigma];
end

% remove nans
xii = find(~isnan(ycontrols));
xcontrols=xcontrols(xii);
ycontrols=ycontrols(xii);

% will need this as one sample size in bootstrap
ncontrols = length(xcontrols);

% % % % % % % % % % 
% fit a line
%         linear model is ax+b
% construct regressor matrix
X = [xcontrols' ones(ncontrols,1)];

% estimate parameters from this sampe
controlparams = inv(X'*X)*X'*ycontrols';





% % % % % % % % % % % % % % % % % % 
% fit line to the prosos data
% % % % % % % % % % % % % % % % % % % 
xprosos=[]; yprosos=[];

for r=1:length(th_prosos)
    xprosos=[xprosos th_prosos{r}.eccbinsx];
    yprosos=[yprosos th_prosos{r}.meanSigma];
end

% remove nans
xii = find(~isnan(yprosos));
xprosos=xprosos(xii);
yprosos=yprosos(xii);

% will need this as one sample size in bootstrap
nprosos = length(xprosos);

% % % % % % % % % % 
% fit a line
%         linear model is ax+b
% construct regressor matrix
X = [xprosos' ones(nprosos,1)];

% estimate parameters from this sampe
prosoparams = inv(X'*X)*X'*yprosos';








% combine the data to create a single sample
% going to assume that the data has been thresholded and had line fits to
% the individual groups already, or else struct will not have fields
% .eccbinsx
% .meansigma
% also assumes a binsize given by h but which could be derived from
% .eccbinsx
% 
% alldata = [th_controls th_prosos];
% 
% % here is where we sample from
% x=[]; y=[];
% 
% for r=1:length(alldata)
%     x=[x alldata{r}.eccbinsx];
%     y=[y alldata{r}.meanSigma];
%     
% end
% 
% % remove nans
%    xii = find(~isnan(y));
%    x=x(xii);
%    y=y(xii);
% 
% 
% % do bootstraps
% numboots = 1000;
% % matrices to hold our fits from each bootstrap for each group
% params1 = zeros(numboots,2);
% params2 = zeros(numboots,2);
% 
% for b = 1:numboots    
%     % prepare data indices
%     %         select random sample with replacement
%     sample1 = ceil(ncontrols*rand(1,ncontrols));
%     sample2 = ceil(nprosos*rand(1,nprosos));
%     %         linear model is ax+b
%     % construct regressor matrix
%     XC = [x(sample1)' ones(ncontrols,1)]; 
%      XP = [x(sample2)' ones(nprosos,1)];
%     
%     % estimate parameters from this sampe
%    params1(b,:) = inv(XC'*XC)*XC'*y(sample1)';
%    params2(b,:) = inv(XP'*XP)*XP'*y(sample2)';
% end




% bootstrap across subjects instead

alldata = [th_controls th_prosos];

% here is where we sample from
% each row is a subject
xsubs=[]; ysubs=[];

for r=1:length(alldata)
    xsubs=[xsubs; alldata{r}.eccbinsx];
    ysubs=[ysubs; alldata{r}.meanSigma];
    
end


% do bootstraps
numboots = 1000;
% matrices to hold our fits from each bootstrap for each group
params1 = zeros(numboots,2);
params2 = zeros(numboots,2);
ncontrols = length(th_controls);
nprosos = length(th_prosos);

for b = 1:numboots    
    % prepare data indices
    %         select random sample with replacement
    sample1 = ceil(ncontrols*rand(1,ncontrols));
    sample2 = ceil(nprosos*rand(1,nprosos));
    
 
%     get our data for bs controls
   xc=[];  yc=[];
    for s=1:length(sample1)
        xc = [xc xsubs(sample1(s),:)];
        yc = [yc ysubs(sample1(s),:)];
    end
%     remove nans
        % remove nans
   xii = find(~isnan(yc));
   xc=xc(xii);
   yc=yc(xii);


%     get our data for bs prosos
   xp=[];  yp=[];
    for s=1:length(sample2)
        xp = [xp xsubs(sample2(s),:)];
        yp = [yp ysubs(sample2(s),:)];
    end
%     remove nans
        % remove nans
   xii = find(~isnan(yp));
   xp=xp(xii);
   yp=yp(xii);


    
    
    %         linear model is ax+b
    % construct regressor matrix
    XC = [xc' ones(length(xc),1)]; 
     XP = [xp' ones(length(xp),1)];
    
    % estimate parameters from this sampe
   params1(b,:) = inv(XC'*XC)*XC'*yc';
   params2(b,:) = inv(XP'*XP)*XP'*yp';
end





% get distribution of differences
% first column is slopes second is intercepts
paramdiffs = params1-params2;

% can plot histogram of slopes and betas 
% mark actual difference as well as prctiles

figure('Name',[th_controls{1}.name ' line params'],'Color',[1 1 1],...
    'Position',get(0,'ScreenSize'));
% slopes
subplot(1,2,1);
hold on;
% histogram of slopes
hist(paramdiffs(:,1),25);
% mark percentiles of distribution
slopeprctiles= prctile(paramdiffs(:,1),[2.5 50 97.5]);
% get axis size
ax=axis;
l(1)=plot([slopeprctiles(1) slopeprctiles(1)], ax(3:4),'-r','LineWidth', 4);
l(2)=plot([slopeprctiles(2) slopeprctiles(2)], ax(3:4),'-k','LineWidth', 4);
l(3)=plot([slopeprctiles(3) slopeprctiles(3)], ax(3:4),'-r','LineWidth', 4);
% plot observed difference
slopediff=controlparams(1)-prosoparams(1);
l(4)=plot([slopediff slopediff], ax(3:4),'-c','LineWidth',4);
legend(l(2:end),{'mean','95% confidence interval','observed difference'});
legend boxoff;
xlabel('slope');
ylabel('# obs of parameter value');


% intercepts
subplot(1,2,2);
hold on;
% histogram of intercepts
hist(paramdiffs(:,2),25);
% mark percentiles of distribution
interceptprctiles= prctile(paramdiffs(:,2),[2.5 50 97.5]);
% get axis size
ax=axis;
l(1)=plot([interceptprctiles(1) interceptprctiles(1)], ax(3:4),'-r','LineWidth', 4);
l(2)=plot([interceptprctiles(2) interceptprctiles(2)], ax(3:4),'-k','LineWidth', 4);
l(3)=plot([interceptprctiles(3) interceptprctiles(3)], ax(3:4),'-r','LineWidth', 4);
% plot observed difference
interceptdiff=controlparams(2)-prosoparams(2);
l(4)=plot([interceptdiff interceptdiff], ax(3:4),'-c','LineWidth',4);

legend(l(2:end),{'mean','95% confidence interval','observed difference'});
legend boxoff;
xlabel('intercept');
ylabel('# obs of parameter value');





end























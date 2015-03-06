% want a single script which generates all the plots for an roi given some
% parameters and subjects and compares prosos to controls.  maybe could
% have it all summarized on a single plot
% don't let matlab use any of its text interpreters as they do annoying
% things (unless you are using one!)
 set(0,'defaulttextinterpreter','none');

% directory with code
% codeDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
codeDir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
addpath(codeDir);

% directory with data
% dataDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
% dataDir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';


dataDir =  '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

% subjects to use
h.controlsessions = {
    %    controls
%         '42111_MN' bad retinotopy
    '42611_AH'
    '43011_YW'
    'adult_amk_27yo_042910'
      'adult_al_22yo_051108'
    'adult_cmb_23yo_070608'
    'adult_dy_25yo_041908'
    'adult_jw_36yo_061608'
    'adult_kll_18yo_052408'
    'adult_kw_fmri2_27yo_092910'
    'adult_mem_18yo_062608'
    %         'adult_jc_27yo_052408' not sure what size of stim was and
    %         bars
    'adult_rb_22yo_101908'
    'adult_acg_39yo_012008'
    'adult_ca_22yo_061908'
    '41711_TM'
    '42811_TA'};

h.prososessions = {
    %     prosos
    '112909whFMRI'
    '082509_nj_proso'
    '020209_mr_fmri'
    '0100609jm'
    '102909mb'
    '11109km_proso'
    '52309AF'
    };


% rois
% these need to appear as matched triplets
% control data      prosos data        roiname
rois = {  
% 'lV1.flippedrV1.mat' , 'lV1.flippedrV1.Prosos.mat'    'V1';
   'lV2.flippedrV2.mat','lV2.flippedrV2.Prosos.mat' 'V2';
%     'lV3.flippedrV3.mat' 'lV3.flippedrV3.Prosos.mat' 'V3';

% ventral %
%         'lV2v.flippedrV2v.mat','lV2v.flippedrV2v.Prosos.mat'         'V2vFlippedLeft';
%     'lV3v.flippedrV3v.mat', 'lV3v.flippedrV3v.Prosos.mat',  'V3vFlippedLeft';
%  'lV4.flippedrV4.mat','lV4.flippedrV4.Prosos.mat' 'V4';
% 'lVO1.flippedrVO1.mat', 'lVO1.flippedrVO1.Prosos.mat', 'VO1';
%  'lVO2.flippedrVO2.mat' 'lVO2.flippedrVO2.Prosos.mat' 'VO2';
    % lateral
% 'lV2d.flippedrV2d.mat' 'lV2d.flippedrV2d.Prosos.mat' 'lV2dFlippedLeft';
% 'lV3d.flippedrV3d.mat' 'lV3d.flippedrV3d.Prosos.mat' 'V3dFlippedLeft';
    % faces ven tral
% 'l_mfus.flippedr_mfus.mat' 'l_mfus.flippedr_mfus.Prosos.mat' 'mFus';
% 'l_pfus.flippedr_pfus.mat','l_pfus.flippedr_pfus.Prosos.mat' 'pFusFlippedLeft';
% 'l_V4_fVp.flippedr_V4_fVp.mat', 'l_V4_fVp.flippedr_V4_fVp.Prosos.mat' 'IOGfacesFLippedLeft';

%  'l_cos.flippedr_cos.mat', 'l_cos.flippedr_cos.Prosos.mat' 'CoSplacesflippedleft';
%        'bothV1_all_nw.mat', 'bothV1_all_nw.Prosos.mat', 'bothV1';
%   'bothV2_all_nw.mat','bothV2_all_nw.Prosos.mat','bothV2';
%    'bothV3_all_nw.mat','bothV3_all_nw.Prosos.mat','bothV3';
% %    'bothV2v_all_nw','bothV2v_all_nw.Prosos','bothV2v';
% % %     'bothV3v_all_nw','bothV3v_all_nw.Prosos','bothV3v';
%     'bothV4_all_nw.mat','bothV4_all_nw.Prosos.mat','bothV4';
% % %     'bothV2d_all_nw','bothV2d_all_nw.Prosos','bothV2d';
% % %   'bothV3d_all_nw','bothV3d_all_nw.Prosos','bothV3d';
% % % % % %     % ventral
%   'bothVO1_all_nw.mat','bothVO1_all_nw.Prosos.mat','bothVO1';
%   'bothVO2_all_nw.mat','bothVO2_all_nw.Prosos.mat','bothVO2';
% % % % % %     face rois
% %     % % face rois
%     'both_V4_fVp_001_nw.mat','both_V4_fVp_001_nw.Prosos.mat','bothIOG';
%  'both_pfus_fVp_001_nw.mat','both_pfus_fVp_001_nw.Prosos.mat','bothpFus';
% %
% 'both_mfus_fVp_001_nw.mat','both_mfus_fVp_001_nw.Prosos.mat','bothmFus';
%    'all_ventral_fVp_nw.mat', 'all_ventral_fVp_nw.Prosos.mat','bothVentFaces';
 'l_faces.flippedr_faces.mat', 'l_faces.flippedr_faces.Prosos.mat','FacesFlippedLeft';
   %      'both_cos_pVf_001_nw.mat', 'both_cos_pVf_001_nw.Prosos.mat','bothCos';
};



% load rms from controls into workspace
load([dataDir char(rois(1,1))]);

% get only subjects we are interested in 
% find index to rms we want to keep
rmindex = [];
% for each rm
for m=1:length(rm)
%     check for matching session name
    for s=1:length(h.controlsessions)
%         if it matches add rm to sbindx
        if strcmp(h.controlsessions(s),rm{m}.session)
%             this is a bug
            rmindex = [rmindex m];
        end
    end

end
% get our control data
controls = rm(rmindex);

% load proso roi
load([dataDir char(rois(1,2))]);
prosos = rm;

% unload excess variables
clear mv rm ECCmv;

% % % % % % % % % % % % % % % % % % % % % % % analyses
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% thresholds on roi and plotting
% optimally, this could be done once but its a lot of working code to fix
% threshold
h.threshco = 0.3;
h.threshecc = [0 30];
h.threshsigma = [0 30];
h.minvoxelcount = 0; %minimum number of voxels in roi

% threshold the data
th_controls = f_thresholdRMData(controls,h);

th_prosos = f_thresholdRMData(prosos,h);



% make a savedirectory

% should be datadir FullAnalysis / threshold / SubjectsUsed / ROI/ 
threshstring =  ['co' num2str(h.threshco) ...
    '.ecc' num2str(h.threshecc(1)) '_' num2str(h.threshecc(2)) '.sig' ...
    num2str(h.threshsigma(1)) '_' num2str(h.threshsigma(2)) '/'];

subsused = 'Allsubs/';
% subsused ='subsNoKWKLLTMDY/';
% subsused = 'subsNocakwcmbmemV1varmatched/';
% subsused = 'subsNocakwcmbmemalmnV1varmatched/';

roiname = [char(rois(1,3)) '/'];

h.saveDir = [dataDir 'FullAnalysis/' threshstring subsused roiname];


% one difficulty is that we might want different directories for different
% concatenations of subjects.  will probably need to name manually like
% matchedV1size or matchedV1co and so on



if ~exist(h.saveDir ,'dir')
    mkdir(h.saveDir)
end

% pRFcoverage
% need to work on this and vfc settings to add as variable to pass
%% parameters for making prf coverage
vfc.prf_size = true; %if 0 will only plot the centers
vfc.fieldRange = 12;  %radius of stimulus
vfc.method = 'maximum profile';         %method for doing coverage.  another choice is density
vfc.newfig = true;                      %any value greater than -1 will result in a plot
vfc.nboot = 200;                          %number of bootstraps
vfc.normalizeRange = true;              %set max value to 1
vfc.smoothSigma = true;                %this smooths the sigmas in the stimulus space.  so takes the 
% median of all sigmas within
vfc.cothresh = h.threshco;                      %threshold coherence
vfc.eccthresh = h.threshecc; 
vfc.nSamples = 128;       %fineness of grid used for making plots     
vfc.meanThresh = 0;   %threshold by mean map, no way to use this at the moment
vfc.weight = 'fixed';  
% vfc.weight = 'variance explained';
vfc.weightBeta = 0;%weight the height of the gaussian
vfc.cmap = 'jet';						
vfc.clipn = 'fixed';                    
vfc.threshByCoh = false;                
vfc.addCenters = true;                 
vfc.verbose = 1;   %print stuff or not
vfc.dualVEthresh = 0;
vfc.binsize = 0.5;
vfc. alpha = 0.05; %transparency level for circle plots

% get control plots

% make sure control save directory exists
if ~exist([h.saveDir 'ControlCoveragePlots/'])
    mkdir([h.saveDir 'ControlCoveragePlots/']);
end
% 

 for s=1:length(th_controls)
        %     make and save plots
        [RFcov{s}, figHandle, all_models, weight, data] = rmPlotCoveragefromROImatfile(th_controls{s},vfc);
        %      will want to save these
%         saveas(gcf,[saveDir rois{r} '.' rm{rmstouse(s)}.session '.coverage.fig'],'fig');
        saveas(gcf,[h.saveDir 'ControlCoveragePlots/' controls{s}.session '.' controls{s}.name '.coverage.png'],'png');
         close(gcf);    
         
%          make plots with only circles
%          hf = f_pRFCoverageAsCircles(th_controls{s}, vfc);
%           saveas(gcf,[h.saveDir 'ControlCoveragePlots/' controls{s}.session '.' controls{s}.name '.Circlecoverage.png'],'png');
%          close(gcf); 
         
         
 end
 
 
%  get proso plots
 
if ~exist([h.saveDir 'ProsoCoveragePlots/'])
    mkdir([h.saveDir 'ProsoCoveragePlots/']);
end
 
 for s=1:length(th_prosos)
        %     make and save plots
        [prRFcov{s}, figHandle, prall_models, prweight, prdata] = rmPlotCoveragefromROImatfile(th_prosos{s},vfc);
        %      will want to save these
%         saveas(gcf,[saveDir rois{r} '.' rm{rmstouse(s)}.session '.coverage.fig'],'fig');
        saveas(gcf,[h.saveDir 'ProsoCoveragePlots/' prosos{s}.session '.' prosos{s}.name '.coverage.png'],'png');
%         
        close(gcf)
%         %         also save as jpg
%                  hf = f_pRFCoverageAsCircles(th_prosos{s}, vfc);
%           saveas(gcf,[h.saveDir 'ControlCoveragePlots/' prosos{s}.session '.' prosos{s}.name '.Circlecoverage.png'],'png');
%          close(gcf); 
         
        
 end
 
 
%  
%     
%     % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%     %     make average visual field coverage plot  for each roi
%     % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%     
% %     as with the individual code, we might like to have several methods,
% %     including bootstrapping.
% 
% %   averaging tends to reduce the extent of the visual field coverage while
% %   highlighting the regions of the most overlap.  this is visible in the
% %   single subject bootstrapped averages as well.  nothing wrong with it,
% %   but it can cause confusion when trying to compare to previously
% %   published work showing single subject data which is bootstrapped on the
% %   max value at each position in the visual field
% 
% % max bootstrapped across subjects
% % number of boot straps
nboots = 500;
% % serge and rory do these as 1d which I should do
% % for now variable to hold bootstraps
bootcov = zeros(size(RFcov{1}),size(RFcov{1}),nboots);
% variable for individual bootstrap passes
bsmple = zeros(size(RFcov{1}),size(RFcov{1}),length(RFcov));

% do bootstraps
for b=1:1:nboots
%     get a random sample
    bindx = randi(length(RFcov),[1 length(RFcov)]);
% extract those images
    for bx =1:length(bindx)
        bsmple(:,:,bx) = RFcov{bindx(bx)};
    end
% take mean and add to bootcoverage
    bootcov(:,:,b)=mean(bsmple,3);

end


figure('Name',[char(rois(1,3)) '  control polar plot'],'Color',[1 1 1]);
f_pRFpolarplot(mean(bootcov,3),vfc)
% f_pRFpolarplot(max(bootcov,[],3),vfc)
caxis([0 1]);
colorbar;

saveas(gcf,[h.saveDir char(rois(1,3)) '.Controlcoverage.png'],'png');

%now prosos
prbootcov = zeros(size(prRFcov{1}),size(prRFcov{1}),nboots);
% variable for individual bootstrap passes
prbsmple = zeros(size(prRFcov{1}),size(prRFcov{1}),length(prRFcov));

% do bootstraps
for b=1:1:nboots
%     get a random sample
    bindx = randi(length(prRFcov),[1 length(prRFcov)]);
% extract those images
    for bx =1:length(bindx)
       prbsmple(:,:,bx) = prRFcov{bindx(bx)};
    end
% take max and add to bootcoverage
    prbootcov(:,:,b)=mean(prbsmple,3);

end


figure('Name',[char(rois(1,3)) '  proso polar plot'],'Color',[1 1 1]);
f_pRFpolarplot(mean(prbootcov,3),vfc)
% f_pRFpolarplot(max(prbootcov,[],3),vfc)
caxis([0 1]);
colorbar;
saveas(gcf,[h.saveDir char(rois(1,3)) '.Prosocoverage.png'],'png');

    
%   maybe compute the average proportion of the field covered given some threshold
% 
% % aggregate across subjects and do a circle plot for each group
% allcontrolsRM = th_controls{1};
% allcontrolsRM.session = 'all controls';
% 
% for c=2:length(th_controls)
%     allcontrolsRM.co = [allcontrolsRM.co th_controls{c}.co];
%      allcontrolsRM.sigma1 = [allcontrolsRM.sigma1 th_controls{c}.sigma1];
%      allcontrolsRM.sigma2 = [allcontrolsRM.sigma2 th_controls{c}.sigma2];
%       allcontrolsRM.x0 = [allcontrolsRM.x0 th_controls{c}.x0];
%       allcontrolsRM.y0 = [allcontrolsRM.y0 th_controls{c}.y0]; 
% end
% 
% vfc.alpha = 0.05;
% 
% hf= f_pRFCoverageAsCircles(allcontrolsRM, vfc);
% saveas(gcf,[h.saveDir char(rois(1,3)) '.ContCirclecoverage.png'],'png');
% 
% % prosos
% 
% % aggregate across subjects and do a circle plot for each group
% allprososRM = th_prosos{1};
% allprososRM.session = 'all prosos';
% 
% for c=2:length(th_prosos)
%     allprososRM.co = [allprososRM.co th_prosos{c}.co];
%      allprososRM.sigma1 = [allprososRM.sigma1 th_prosos{c}.sigma1];
%      allprososRM.sigma2 = [allprososRM.sigma2 th_prosos{c}.sigma2];
%       allprososRM.x0 = [allprososRM.x0 th_prosos{c}.x0];
%       allprososRM.y0 = [allprososRM.y0 th_prosos{c}.y0]; 
% end
% 
% 
% 
% hf= f_pRFCoverageAsCircles(allprososRM, vfc);
% saveas(gcf,[h.saveDir char(rois(1,3)) '.ProsoCirclecoverage.png'],'png');
% close(gcf);





% roi stats
% get ttest of median values for params in each roi
% var exp, num voxels, co, sigma, ecc, percent voxels used

[controlMedians prosoMedians stats] =f_plotAllROIStats(th_controls, th_prosos, h);

saveas(gcf,[h.saveDir char(rois(1,3)) '.CVProicompare.png'],'png');

% do the correlations between the parameters

f_corrROIMeasures(controlMedians);
% need to save these figures
saveas(gcf,[h.saveDir char(rois(1,3)) '.controlsROIcorrs.png'],'png');

f_corrROIMeasures(prosoMedians);
saveas(gcf,[h.saveDir char(rois(1,3)) '.prososROIcorrs.png'],'png');


% % sizeXecc

% need to bin eccentricity data
h.binsize = .5;
h.group = 'controls';%for figure naming
% get control plots
[th_controls controlLineModels] = f_sizeVSeccFromROI(th_controls, h);

h.group = 'prosos';%for figure naming
% get control plots
[th_prosos prosoLineModels] = f_sizeVSeccFromROI(th_prosos, h);


% put them on the same plot
figure('Name',[controls{1}.name 'prosos vs controls rfx bootstrap'],'Color',[1 1 1],'Position',get(0,'ScreenSize'));
hold on;
%     so you are taking the 2.5, 50, and 97.5 percentile data point from
%     the distribution of y for every x.
%    this 50th percentile does not seem lie it has to be a line even, but
%    this is a visualization and the test is on the parameters?
cmodelfitP = prctile(controlLineModels.modelfit,[2.5 50 97.5]);
pmodelfitP = prctile(prosoLineModels.modelfit,[2.5 50 97.5]);
% define a polygon by following the 2.5th percentile line (left to right)
% and then reversing and following the 97.5th percentile line (right to
% left).
% controls
xvals = h.threshecc(1):.1:h.threshecc(2);   % x-values to evaluate the model at
h2 = patch([xvals fliplr(xvals)],...
    [cmodelfitP(1,:) fliplr(cmodelfitP(3,:))],[.7 1 .7]);
set(h2,'EdgeColor','none','FaceAlpha',.5);
h3 = plot(xvals,cmodelfitP(2,:),'g-','LineWidth',2);
% prosos
h4 = patch([xvals fliplr(xvals)],[pmodelfitP(1,:) fliplr(pmodelfitP(3,:))],[1 .7 .7]);
set(h4,'EdgeColor','none','FaceAlpha',.5);
h5 = plot(xvals,pmodelfitP(2,:),'r-','LineWidth',2);
xlabel('ecc in degrees');
ylabel('pRF sigma in degrees');
set(gca,'XLim',[0 h.threshecc(2)],'YLim',[0 h.threshsigma(2)]);
%  add x=y line
plot(0:.1:h.threshecc(2),0:.1:h.threshecc(2),'k--');

saveas(gcf,[h.saveDir 'cVp.' char(controls{1}.name) '.' num2str(h.binsize) 'dgbins.sizeXeccbstrap.png'],'png');



% put them on the same plot
figure('Name',[controls{1}.name 'prosos vs controls rfx bootstrap'],'Color',[1 1 1],'Position',get(0,'ScreenSize'));
hold on;
%     so you are taking the 2.5, 50, and 97.5 percentile data point from
%     the distribution of y for every x.
%    this 50th percentile does not seem lie it has to be a line even, but
%    this is a visualization and the test is on the parameters?
cmodelfitP = prctile(controlLineModels.submodelfit,[2.5 50 97.5]);
pmodelfitP = prctile(prosoLineModels.submodelfit,[2.5 50 97.5]);
% define a polygon by following the 2.5th percentile line (left to right)
% and then reversing and following the 97.5th percentile line (right to
% left).
% controls
xvals = h.threshecc(1):.1:h.threshecc(2);   % x-values to evaluate the model at
h2 = patch([xvals fliplr(xvals)],...
    [cmodelfitP(1,:) fliplr(cmodelfitP(3,:))],[.7 1 .7]);
set(h2,'EdgeColor','none','FaceAlpha',.5);
h3 = plot(xvals,cmodelfitP(2,:),'g-','LineWidth',2);
% prosos
h4 = patch([xvals fliplr(xvals)],[pmodelfitP(1,:) fliplr(pmodelfitP(3,:))],[1 .7 .7]);
set(h4,'EdgeColor','none','FaceAlpha',.5);
h5 = plot(xvals,pmodelfitP(2,:),'r-','LineWidth',2);
xlabel('ecc in degrees');
ylabel('pRF sigma in degrees');
set(gca,'XLim',[0 h.threshecc(2)],'YLim',[0 h.threshsigma(2)]);
%  add x=y line
plot(0:.1:h.threshecc(2),0:.1:h.threshecc(2),'k--');

saveas(gcf,[h.saveDir 'cVp.' char(controls{1}.name) '.' num2str(h.binsize) 'dgbins.sizeXeccbstrapsubs.png'],'png');



% should be testing the parameter differences
% one way to do this is to combine the slope estimates from the two groups
% and create two random samples from that combined distribution.  this is
% the null hypothesis that both samples came from the same distribution.
% calculate a difference between the two means.  bootstrap this.  find
% percentile of observed difference in bootstrapped distribution to get
% your pvalue.

% input to this function requires that f_sizeXeccFromROI has been run on
% data first to add fields to struct
f_compareLineFits(th_controls,th_prosos,h);
% save figure
saveas(gcf,[h.saveDir controls{1}.name '.' h.binsize  'dbins.compareSizeVsEccParams.png'],'png')

% 
% 
% % 
% % % distributions of parameters  mainly sigma and ecc
% need bins and binsizes for each measure
h.corange = [0 1];
h.cobinsize = .1;
h.eccrange = [h.threshecc(1) h.threshecc(2)];
h.eccbinsize = 3;
h.sigmarange = [h.threshsigma(1) h.threshsigma(2)];
h.sigmabinsize = 3;

% 
% groupdata datawithsubhists 
[controlhist th_controls]= f_makePRFhistsForROI(th_controls,h);
%
[prosohist th_prosos]= f_makePRFhistsForROI(th_prosos,h);
% 

h.prctiles = [2.5 50 97.5];
%get percentile data
yc = prctile(controlhist.sigma.countsigboots,h.prctiles);
yp = prctile(prosohist.sigma.countsigboots,h.prctiles);

ycpdf = prctile(controlhist.sigma.pdfsigboots,h.prctiles);
yppdf = prctile(prosohist.sigma.pdfsigboots,h.prctiles);



%make some figures
figure('Name',['distribution of pRF size in ' char(rois(3))],'Color',[1 1 1],...
    'Position',get(0,'ScreenSize'));
% subplots
% counts
subplot(1,2,1);
hold on;
% define x 
xvals = h.sigmarange(1):h.sigmabinsize:h.sigmarange(2);
% make a transparent patch for confidence interval controls
 h1 = patch([xvals fliplr(xvals)],[yc(1,:) fliplr(yc(3,:))],[0 1 0]);
    set(h1,'EdgeColor','none','FaceAlpha',.5);
%     plot median
 h2 = plot(xvals,yc(2,:),'g-','LineWidth',2);
 % make a transparent patch for confidence interval prosos
 h3 = patch([xvals fliplr(xvals)],[yp(1,:) fliplr(yp(3,:))],[1 0 0]);
    set(h3,'EdgeColor','none','FaceAlpha',.5);
%     plot median
 h4 = plot(xvals,yp(2,:),'r-','LineWidth',2);
%  labels
xlabel('prf size in degrees');  ylabel('count of pRFs');

subplot(1,2,2);
hold on;
% define x 
xvals = h.sigmarange(1):h.sigmabinsize:h.sigmarange(2);
% make a transparent patch for confidence interval controls
 h1 = patch([xvals fliplr(xvals)],[ycpdf(1,:) fliplr(ycpdf(3,:))],[0 1 0]);
    set(h1,'EdgeColor','none','FaceAlpha',.5);
%     plot median
 h2 = plot(xvals,ycpdf(2,:),'g-','LineWidth',2);
 % make a transparent patch for confidence interval prosos
 h3 = patch([xvals fliplr(xvals)],[yppdf(1,:) fliplr(yppdf(3,:))],[1 0 0]);
    set(h3,'EdgeColor','none','FaceAlpha',.5);
%     plot median
 h4 = plot(xvals,yppdf(2,:),'r-','LineWidth',2);
%  labels
xlabel('prf size in degrees');  ylabel('% of pRFs');
legend([h2 h4],{'controls','prosos'});
legend boxoff;

% save figure
saveas(gcf,[h.saveDir 'cVp.' char(controls{1}.name) '.' num2str(h.sigmabinsize) 'dgbins.sigmahist.png'],'png');




% % % % % % % % % % % % % % % % 
% eccentricity histogram

%get percentile data
yc = prctile(controlhist.ecc.counteccboots,h.prctiles);
yp = prctile(prosohist.ecc.counteccboots,h.prctiles);

ycpdf = prctile(controlhist.ecc.pdfeccboots,h.prctiles);
yppdf = prctile(prosohist.ecc.pdfeccboots,h.prctiles);



%make some figures
figure('Name',['distribution of pRF ecc in ' char(rois(3))],'Color',[1 1 1],...
    'Position',get(0,'ScreenSize'));
% subplots
% counts
subplot(1,2,1);
hold on;
% define x 
xvals = h.eccrange(1):h.eccbinsize:h.eccrange(2);
% make a transparent patch for confidence interval controls
 h1 = patch([xvals fliplr(xvals)],[yc(1,:) fliplr(yc(3,:))],[0 1 0]);
    set(h1,'EdgeColor','none','FaceAlpha',.5);
%     plot median
 h2 = plot(xvals,yc(2,:),'g-','LineWidth',2);
 % make a transparent patch for confidence interval prosos
 h3 = patch([xvals fliplr(xvals)],[yp(1,:) fliplr(yp(3,:))],[1 0 0]);
    set(h3,'EdgeColor','none','FaceAlpha',.5);
%     plot median
 h4 = plot(xvals,yp(2,:),'r-','LineWidth',2);
%  labels
xlabel('prf ecc in degrees');  ylabel('count of pRFs');

subplot(1,2,2);
hold on;
% define x 
xvals = h.eccrange(1):h.eccbinsize:h.eccrange(2);
% make a transparent patch for confidence interval controls
 h1 = patch([xvals fliplr(xvals)],[ycpdf(1,:) fliplr(ycpdf(3,:))],[0 1 0]);
    set(h1,'EdgeColor','none','FaceAlpha',.5);
%     plot median
 h2 = plot(xvals,ycpdf(2,:),'g-','LineWidth',2);
 % make a transparent patch for confidence interval prosos
 h3 = patch([xvals fliplr(xvals)],[yppdf(1,:) fliplr(yppdf(3,:))],[1 0 0]);
    set(h3,'EdgeColor','none','FaceAlpha',.5);
%     plot median
 h4 = plot(xvals,yppdf(2,:),'r-','LineWidth',2);
%  labels
xlabel('prf ecc in degrees');  ylabel('% of pRFs');

set(gca,'YLim',[0 .7]);

legend([h2 h4],{'controls','prosos'});
legend boxoff;

saveas(gcf,[h.saveDir 'cVp.' char(controls{1}.name) '.' num2str(h.sigmabinsize) 'dgbins.ecchist.png'],'png');






%want to save a bunch of variables we care about
% save([h.saveDir 'variables.mat'],'th_controls','th_prosos','h','prosohist','controlhist','prosoLineModels',...
%     'controlLineModels','vfc','controlMedians','prosoMedians','RFcov','prRFcov');
% 


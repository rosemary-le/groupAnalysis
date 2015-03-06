% script for rfx size x ecc plots prosos vs controls given an roi with
% bootstrap distribution test for significance of parameter difference

 set(0,'defaulttextinterpreter','none');

% directory with code
% codeDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
codeDir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
addpath(codeDir);

% directory with data
% dataDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
dataDir =  '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

% subjects to use
h.controlsessions = {
    %    controls
%         '42111_MN'  shitty retinotopy
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
    %         'adult_jc_27yo_052408'   scanned with bars not sure of
    %         display
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
%    'lV2.flippedrV2.mat','lV2.flippedrV2.Prosos.mat' 'V2';
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
%  'l_faces.flippedr_faces.mat', 'l_faces.flippedr_faces.Prosos.mat','FacesFlippedLeft';
        'both_cos_pVf_001_nw.mat', 'both_cos_pVf_001_nw.Prosos.mat','bothCos';
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

% thresholds on roi and plotting
% optimally, this could be done once but its a lot of working code to fix
% threshold
h.threshco = 0.3;
h.threshecc = [0 15];
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


% % sizeXecc

% need to bin eccentricity data
h.binsize = 1;
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
% set(gca,'XLim',[0 h.threshecc(2)],'YLim',[0 h.threshecc(2)]);
set(gca,'XLim',[0 15],'YLim',[0 15]);

axis square
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


%want to save a bunch of variables we care about
% save([h.saveDir 'variables.mat'],'th_controls','th_prosos','h','prosohist','controlhist','prosoLineModels',...
%     'controlLineModels','vfc','controlMedians','prosoMedians','RFcov','prRFcov');
% 


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
%     %    controls
%         '42111_MN'  bad retinotopy
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
    %         'adult_jc_27yo_052408'  bars not sure about stimulus size
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

%  'l_cos.flippedr_cos.mat', 'l_cos.flippedr_cos.Prosos.mat'
%  'CoSplacesflippedleft';
%        'bothV1_all_nw.mat', 'bothV1_all_nw.Prosos.mat', 'bothV1';
%   'bothV2_all_nw.mat','bothV2_all_nw.Prosos.mat','bothV2';
%    'bothV3_all_nwcle.mat','bothV3_all_nw.Prosos.mat','bothV3';
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
% %
% 'both_mfus_fVp_001_nw.mat','both_mfus_fVp_001_nw.Prosos.mat','bothmFus';

    'all_ventral_fVp_nw.mat','all_ventral_fVp_nw.Prosos.mat','bothVentFaces'; 

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
h.threshco = 0;
h.threshecc = [0 15];
h.threshsigma = [0 30];
h.minvoxelcount = 10; %minimum number of voxels in roi

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



% % % distributions of parameters  mainly sigma and ecc
% need bins and binsizes for each measure
h.corange = [0 1];
h.cobinsize = .1;
h.eccrange = [h.threshecc(1) 15];
h.eccbinsize = 3;
h.sigmarange = [h.threshsigma(1) 15];
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



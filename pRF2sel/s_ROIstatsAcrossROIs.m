%  s_sizeVeccAcrossROIs(rois, h);


% takes a list of filenames which contain pRF models for each voxel in the
% roi for both groups of subjects
% h is a struct containing various parameters for thresholding and so on
% h.threshecc
% h.threshco
% h.threshsigma
%% load roi.  threshold data.
%% get summary statistics for roi for each group
%% make plot of stat comparisons for each group across rois
%% so 4 sets of box plots




% directory with code
% codeDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
codeDir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
addpath(genpath(codeDir));

% directory with data
% dataDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
% dataDir =
% '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';

dataDir ='~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

% dataDir =
% '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

% rois
% these need to appear as matched triplets
% control data      prosos data        roiname
rois = {
%        'bothV1_all_nw.mat', 'bothV1_all_nw.Prosos.mat', 'bothV1';
%   'bothV2_all_nw.mat','bothV2_all_nw.Prosos.mat','bothV2';
%    'bothV3_all_nw.mat','bothV3_all_nw.Prosos.mat','bothV3';
% % % %    'bothV2v_all_nw','bothV2v_all_nw.Prosos','bothV2v';
% % % %     'bothV3v_all_nw','bothV3v_all_nw.Prosos','bothV3v';
%     'bothV4_all_nw.mat','bothV4_all_nw.Prosos.mat','bothV4';
% % % %     'bothV2d_all_nw','bothV2d_all_nw.Prosos','bothV2d';
% % % %   'bothV3d_all_nw','bothV3d_all_nw.Prosos','bothV3d';
% % % % % % %     % ventral
%   'bothVO1_all_nw.mat','bothVO1_all_nw.Prosos.mat','bothVO1';
% % %   'bothVO2_all_nw.mat','bothVO2_all_nw.Prosos.mat','bothVO2';
% % % % % % %     face rois
% % %     % % face rois
% % %     'both_V4_fVp_001_nw.mat','both_V4_fVp_001_nw.Prosos.mat','bothIOG';
% % %  'both_pfus_fVp_001_nw.mat','both_pfus_fVp_001_nw.Prosos.mat','bothpFus';
% % %     'both_mfus_fVp_001_nw.mat','both_mfus_fVp_001_nw.Prosos.mat','bothmFus';
%     'all_ventral_fVp_nw.mat','all_ventral_fVp_nw.Prosos.mat','bothVentFaces';
% % 
% % %      place  rois
%    'both_cos_pVf_001_nw.mat','both_cos_pVf_001_nw.Prosos.mat','bothCos';
%     
%         'lV1.flippedrV1.mat' , 'lV1.flippedrV1.Prosos.mat'    'V1';
%     %     % ventral %
% %         'lV2v.flippedrV2v.mat','lV2v.flippedrV2v.Prosos.mat'         'V2v';
% %         'lV2d.flippedrV2d.mat' 'lV2d.flippedrV2d.Prosos.mat'     'V2d';
%     %     'lV3v.flippedrV3v.mat', 'lV3v.flippedrV3v.Prosos.mat',  'V3v';
%     %     'lV3d.flippedrV3d.mat' 'lV3d.flippedrV3d.Prosos.mat' 'V3d';
    %
%         'lV2.flippedrV2.mat','lV2.flippedrV2.Prosos.mat' 'V2';
%         'lV3.flippedrV3.mat' 'lV3.flippedrV3.Prosos.mat' 'V3';
    %
    %
%         'lV4.flippedrV4.mat','lV4.flippedrV4.Prosos.mat' 'hV4';
%         'lVO1.flippedrVO1.mat', 'lVO1.flippedrVO1.Prosos.mat', 'VO1';
%     %
%     %
%         'lVO2.flippedrVO2.mat' 'lVO2.flippedrVO2.Prosos.mat' 'VO2';
%     %     % lateral
%     %
%     %     % faces ventral
%         'l_V4_fVp.flippedr_V4_fVp.mat', 'l_V4_fVp.flippedr_V4_fVp.Prosos.mat' 'IOG';
%         'l_pfus.flippedr_pfus.mat','l_pfus.flippedr_pfus.Prosos.mat'  'pFus';
%         'l_mfus.flippedr_mfus.mat' 'l_mfus.flippedr_mfus.Prosos.mat' 'mFus';
    %
    %
    %     %
%         'l_cos.flippedr_cos.mat', 'l_cos.flippedr_cos.Prosos.mat' 'CoS';
    %
    
    %      left and right
%         'rV1_all_nw.mat', 'rV1_all_nw.Prosos.mat', 'rV1';
%         'lV1_all_nw.mat', 'lV1_all_nw.Prosos.mat', 'lV1';
%         'rV2v_all_nw.mat', 'rV2v_all_nw.Prosos.mat', 'rV2v';
%         'lV2v_all_nw.mat', 'lV2v_all_nw.Prosos.mat', 'lV2v';
%         'rV3v_all_nw.mat', 'rV3v_all_nw.Prosos.mat', 'rV3v';
%         'lV3v_all_nw.mat', 'lV3v_all_nw.Prosos.mat', 'lV3v';
%         'rV2d_all_nw.mat', 'rV2d_all_nw.Prosos.mat', 'rV2d';
%         'lV2d_all_nw.mat', 'lV2d_all_nw.Prosos.mat', 'lV2d';
%         'rV3d_all_nw.mat', 'rV3d_all_nw.Prosos.mat', 'rV3d';
%         'lV3d_all_nw.mat', 'lV3d_all_nw.Prosos.mat', 'lV3d';
%         'rV4_all_nw.mat', 'rV4_all_nw.Prosos.mat', 'rV4';
%         'lV4_all_nw.mat', 'lV4_all_nw.Prosos.mat', 'lV4';
%         'rVO1_all_nw.mat', 'rVO1_all_nw.Prosos.mat', 'rVO1';
%         'lVO1_all_nw.mat', 'lVO1_all_nw.Prosos.mat', 'lVO1';
% %         'rVO2_all_nw.mat', 'rVO2_all_nw.Prosos.mat', 'rVO2';
% %         'lVO2_all_nw.mat', 'lVO2_all_nw.Prosos.mat', 'lVO2';
%     
%         'l_V4_fVp_001_nw.mat', 'l_V4_fVp_001_nw.Prosos.mat', 'lIOG';
%         'r_V4_fVp_001_nw.mat', 'r_V4_fVp_001_nw.Prosos.mat', 'rIOG';
%         'l_pfus_fVp_001_nw.mat', 'l_pfus_fVp_001_nw.Prosos.mat', 'lpfus';
%         'r_pfus_fVp_001_nw.mat', 'r_pfus_fVp_001_nw.Prosos.mat', 'rpfus';
%         'l_mfus_fVp_001_nw.mat', 'l_mfus_fVp_001_nw.Prosos.mat', 'lmfus';
%         'r_mfus_fVp_001_nw.mat', 'r_mfus_fVp_001_nw.Prosos.mat', 'rmfus';
%     
    %     directly compare right and left prosos and controls
    %         'rV1_all_nw.mat', 'lV1_all_nw.mat', 'cV1';
    %    'rV1_all_nw.Prosos.mat', 'lV1_all_nw.Prosos.mat', 'pV1';
    %     'rV2v_all_nw.mat', 'lV2v_all_nw.mat', 'cV2v';
    %      'rV2v_all_nw.Prosos.mat', 'lV2v_all_nw.Prosos.mat', 'pV2v';
    %     'rV3v_all_nw.mat', 'lV3v_all_nw.mat', 'cV3v';
    %    'rV3v_all_nw.Prosos.mat', 'lV3v_all_nw.Prosos.mat', 'pV3v';
    %     'rV2d_all_nw.mat', 'lV2d_all_nw.mat', 'cV2d';
    %      'rV2d_all_nw.Prosos.mat', 'lV2d_all_nw.Prosos.mat', 'pV2d';
    %     'rV3d_all_nw.mat','lV3d_all_nw.mat', 'cV3d';
    %     'rV3d_all_nw.Prosos.mat', 'lV3d_all_nw.Prosos.mat', 'pV3d';
    %     'rV4_all_nw.mat', 'lV4_all_nw.mat', 'cV4';
    %     'rV4_all_nw.Prosos.mat', 'lV4_all_nw.Prosos.mat', 'pV4';
    %     'rVO1_all_nw.mat', 'lVO1_all_nw.mat', 'cVO1';
    %     'rVO1_all_nw.Prosos.mat', 'lVO1_all_nw.Prosos.mat', 'pVO1';
    %     'rVO2_all_nw.mat', 'lVO2_all_nw.mat', 'cVO2';
    %     'rVO2_all_nw.Prosos.mat', 'lVO2_all_nw.Prosos.mat', 'pVO2';
    
    %     'l_V4_fVp_001_nw.mat','r_V4_fVp_001_nw.mat', 'cIOG';
    %      'l_V4_fVp_001_nw.Prosos.mat', 'r_V4_fVp_001_nw.Prosos.mat', 'pIOG';
    %     'l_pfus_fVp_001_nw.mat','r_pfus_fVp_001_nw.mat', 'cpfus';
    %      'l_pfus_fVp_001_nw.Prosos.mat', 'r_pfus_fVp_001_nw.Prosos.mat', 'ppfus';
    %     'l_mfus_fVp_001_nw.mat', 'r_mfus_fVp_001_nw.mat', 'cmfus';
    %     'l_mfus_fVp_001_nw.Prosos.mat', 'r_mfus_fVp_001_nw.Prosos.mat',
    %     'pmfus';
    
% %     % left vs right but don't split dorsal and ventral v2/v3
%     'rV1_all_nw.mat', 'lV1_all_nw.mat', 'cV1';
%     'rV2_all_nw.mat', 'lV2_all_nw.mat', 'cV2';
%     'rV3_all_nw.mat', 'lV3_all_nw.mat', 'cV3';
%     'rV4_all_nw.mat', 'lV4_all_nw.mat', 'cV4';
%     'rVO1_all_nw.mat', 'lVO1_all_nw.mat', 'cVO1';
%     'rVO2_all_nw.mat', 'lVO2_all_nw.mat', 'cVO2';
%     'r_V4_fVp_001_nw.mat','l_V4_fVp_001_nw.mat', 'cIOG';
%     'r_pfus_fVp_001_nw.mat', 'l_pfus_fVp_001_nw.mat', 'cpfus';
%     'r_mfus_fVp_001_nw.mat', 'l_mfus_fVp_001_nw.mat',  'cmfus';
%     
%      'rV1_all_nw.Prosos.mat', 'lV1_all_nw.Prosos.mat', 'pV1';
%     'rV2_all_nw.Prosos.mat', 'lV2_all_nw.Prosos.mat', 'pV2';
%     'rV3_all_nw.Prosos.mat', 'lV3_all_nw.Prosos.mat', 'pV3';
%     'rV4_all_nw.Prosos.mat', 'lV4_all_nw.Prosos.mat', 'pV4';
%     'rVO1_all_nw.Prosos.mat', 'lVO1_all_nw.Prosos.mat', 'pVO1';
%     'rVO2_all_nw.Prosos.mat', 'lVO2_all_nw.Prosos.mat', 'pVO2';
%     'r_V4_fVp_001_nw.Prosos.mat','l_V4_fVp_001_nw.Prosos.mat', 'pIOG';
%     'r_pfus_fVp_001_nw.Prosos.mat', 'l_pfus_fVp_001_nw.Prosos.mat', 'ppfus';
%     'r_mfus_fVp_001_nw.Prosos.mat', 'l_mfus_fVp_001_nw.Prosos.mat',  'pmfus';
%    
%     
%     %     everything but collapse across face and scenes
    'rV1_all_nw.mat', 'rV1_all_nw.Prosos.mat', 'rV1';
    'lV1_all_nw.mat', 'lV1_all_nw.Prosos.mat', 'lV1';
    'rV2_all_nw.mat', 'rV2_all_nw.Prosos.mat', 'rV2';
    'lV2_all_nw.mat', 'lV2_all_nw.Prosos.mat', 'lV2';
    'rV3_all_nw.mat', 'rV3_all_nw.Prosos.mat', 'rV3';
    'lV3_all_nw.mat', 'lV3_all_nw.Prosos.mat', 'lV3';
    'rV4_all_nw.mat', 'rV4_all_nw.Prosos.mat', 'rV4';
    'lV4_all_nw.mat', 'lV4_all_nw.Prosos.mat', 'lV4';
    'rVO1_all_nw.mat', 'rVO1_all_nw.Prosos.mat', 'rVO1';
    'lVO1_all_nw.mat', 'lVO1_all_nw.Prosos.mat', 'lVO1';
    'r_ventral_fVp_nw.mat','r_ventral_fVp_nw.Prosos.mat', 'rFaces';
    'l_ventral_fVp_nw.mat','l_ventral_fVp_nw.Prosos.mat', 'lFaces';
    'r_cos_pVf_001_nw.mat', 'r_cos_pVf_001_nw.Prosos.mat', 'rCoS';
    'l_cos_pVf_001_nw.mat', 'l_cos_pVf_001_nw.Prosos.mat', 'lCoS';
  
    };


% thresholds on roi and plotting
% optimally, this could be done once but its a lot of working code to fix
% threshold
h.threshco = 0.3;
h.threshecc = [0 15];
h.threshsigma = [0 30];
h.binsize = 1;
h.minvoxelcount = 0;

% should be datadir FullAnalysis / threshold / SubjectsUsed / ROI/
threshstring =  ['co' num2str(h.threshco) ...
    '.ecc' num2str(h.threshecc(1)) '_' num2str(h.threshecc(2)) '.sig' ...
    num2str(h.threshsigma(1)) '_' num2str(h.threshsigma(2)) '/'];


% subjects to use
h.sessions = {
%        controls
%     '42111_MN' bad retinotopy
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
%                 'adult_jc_27yo_052408'
    'adult_rb_22yo_101908'
    'adult_acg_39yo_012008'
    'adult_ca_22yo_061908'
    '41711_TM'
    '42811_TA'
    
    
    
    %     prosos
    '112909whFMRI'
    '082509_nj_proso'
    '020209_mr_fmri'
    '0100609jm'
    '102909mb'
    '11109km_proso'
    '52309AF'
    };





% subsused = 'Allsubs/';
subsused = 'noMN/';
% subsused ='subsNoKWKLLTMDY/';
% subsused = 'subsNocakwcmbmemV1varmatched/';
% subsused = 'subsNocakwcmbmemalmnV1varmatched/';

h.saveDir = [dataDir 'FullAnalysis/' threshstring subsused];

% figure name
% sting comprised by the rois used
% concatenate the roi names in the order used
figname=reshape(char(rois(:,2))',1,[]);
% remove spaces
figname=regexprep(figname,' ','');

%
%
% % check for save directory
if ~exist(h.saveDir ,'dir')
    mkdir(h.saveDir)
end

% variables to store model fits
legendnames ={};
modelfits = [];
% for each roi
for r=1:length(rois)
    
    % load control roi
    load([dataDir char(rois(r,1))]);
    %clear extraneous variables
    clear mv ECCmv
    %get only the sessions you want to use
    % get only subjects we are interested in
    % find index to rms we want to keep
    %still editing this part
    rmindex = [];
    % for each rm
    for m=1:length(rm)
        %     check for matching session name
        for s=1:length(h.sessions)
            %         if it matches add rm to sbindx
            if strcmp(h.sessions(s),rm{m}.session)
                rmindex = [rmindex m];
            end
        end
        
    end
    % get subset of subjects
    controls = rm(rmindex);
    
    % threshold data
    th_controls = f_thresholdRMData(controls,h);
    
    %     clear excess variable
    clear rm
    
    %     do the same for the prosos
    load([dataDir char(rois(r,2))]);
    prosos=rm;
    clear rm mv ECCmv;
    th_prosos = f_thresholdRMData(prosos,h);
    
    
    %get the stats here
    [controlMedians{r} prosoMedians{r} stats{r}] = f_plotAllROIStats(th_controls, th_prosos, h);
    
end

% figname with rois incluede
figname=reshape(char(rois(:,3))',1,[]);
% remove spaces
figname=regexprep(figname,' ','');

%
fldname = 'size';
f_makeBoxPlotsAcrossROIsCvsP(h,rois,controlMedians,prosoMedians,stats,fldname);
% make y axis log since sizes vary widely
set(gca,'Yscale','log');

% save figure
saveas(gcf,[h.saveDir 'CvsPStats.' fldname '.' figname '.png'],'png');
% save as svg
plot2svg([h.saveDir 'CvsPStats.' fldname '.' figname '.svg'],gcf,'svg');


% do it as an errorbar plot
f_errorBarPlotsAcrossROIsCvsP(controlMedians,prosoMedians,h,rois,fldname,stats)
saveas(gcf,[h.saveDir 'CvsPStats.Bars.' fldname '.' figname '.png'],'png');
% save as svg
plot2svg([h.saveDir 'CvsPStats.Bars.' fldname '.' figname '.svg'],gcf,'svg');


fldname = 'co';
f_makeBoxPlotsAcrossROIsCvsP(h,rois,controlMedians,prosoMedians,stats,fldname);
saveas(gcf,[h.saveDir 'CvsPStats.' fldname '.' figname '.png'],'png');
% save as svg
plot2svg([h.saveDir 'CvsPStats.' fldname '.' figname '.svg'],gcf,'svg');


% do it as an errorbar plot
f_errorBarPlotsAcrossROIsCvsP(controlMedians,prosoMedians,h,rois,fldname,stats)
saveas(gcf,[h.saveDir 'CvsPStats.Bars.' fldname '.' figname '.png'],'png');
% save as svg
plot2svg([h.saveDir 'CvsPStats.Bars.' fldname '.' figname '.svg'],gcf,'svg');


fldname = 'ecc';
f_makeBoxPlotsAcrossROIsCvsP(h,rois,controlMedians,prosoMedians,stats,fldname);
saveas(gcf,[h.saveDir 'CvsPStats.' fldname '.' figname '.png'],'png');
% save as svg
plot2svg([h.saveDir 'CvsPStats.' fldname '.' figname '.svg'],gcf,'svg');


% do it as an errorbar plot
f_errorBarPlotsAcrossROIsCvsP(controlMedians,prosoMedians,h,rois,fldname,stats)
saveas(gcf,[h.saveDir 'CvsPStats.Bars.' fldname '.' figname '.png'],'png');
% save as svg
plot2svg([h.saveDir 'CvsPStats.Bars.' fldname '.' figname '.svg'],gcf,'svg');

fldname = 'sigma';
f_makeBoxPlotsAcrossROIsCvsP(h,rois,controlMedians,prosoMedians,stats,fldname)
saveas(gcf,[h.saveDir 'CvsPStats.' fldname '.' figname '.png'],'png');
% save as svg
plot2svg([h.saveDir 'CvsPStats.' fldname '.' figname '.svg'],gcf,'svg');


% do it as an errorbar plot
f_errorBarPlotsAcrossROIsCvsP(controlMedians,prosoMedians,h,rois,fldname,stats)
saveas(gcf,[h.saveDir 'CvsPStats.Bars.' fldname '.' figname '.png'],'png');
% save as svg
plot2svg([h.saveDir 'CvsPStats.Bars.' fldname '.' figname '.svg'],gcf,'svg');

% should also output a table with real numbers in it
% columns are rois
% rois are
colnames = rois(:,3);

% rows are medians or raw number and standard deviation
%  control n
%  control (or right) mean
%  control std
%  proso n
%  proso mean
%  proso std
%  unpaired 2 tailed t-stat
%  p
%  df




% median
% std error (these could be bootstrapped cis)
% 


% have a variable stats with one struct for each roi

%                co: [1x1 struct]
%              size: [1x1 struct]
%               ecc: [1x1 struct]
%             sigma: [1x1 struct]
%     percentvoxels: [1x1 struct]

% out put of ttest
% stats{1}.co
%         H: 0
%         P: 0.8509
%        CI: [-0.0459 0.0554]whos
%     STATS: [1x1 struct]
% more ttest stuff
% stats{1}.co.STATS(1)
%     tstat: 0.1891
%        df: 43.9509
%        sd: [0.1179 0.0524]

% controls vs prosos
rownames = {
    'control n'
    'control mean'
    'control sd'
    'proso n'
    'proso mean'
    'proso sd'
    't-stat unpaired 2 tails'
    'p val'
    'df'
    };
% do size  have to get data into our table
format long g;
fld = 'size';
data = zeros(length(rownames),length(colnames{1}));
for r=1:length(colnames)
%     fill the column
    data(1,r) = length(controlMedians{r}.(fld));
    data(2,r) = mean(controlMedians{r}.(fld));
    data(3,r) = std(controlMedians{r}.(fld));
    data(4,r) = length(prosoMedians{r}.(fld));
    data(5,r) = mean(prosoMedians{r}.(fld));
    data(6,r) = std(prosoMedians{r}.(fld));
    data(7,r) = stats{r}.(fld).STATS.tstat;
    data(8,r) = stats{r}.(fld).P;
    data(9,r) = stats{r}.(fld).STATS.df;
    
end

f1 = figure('Name', 'sizes between groups','Color',[1 1 1],'Position',get(0,'ScreenSize'));
format long g;
t=uitable('Data',data,'ColumnName',colnames,'RowName',rownames,...
    'Units','normalized','Position',[0 0 1 1]);
% save figure
saveas(gcf,[h.saveDir 'CvsPTable.' fld '.' figname '.png'],'png');


% variance explained

fld = 'co';
data = zeros(length(rownames),length(colnames{1}));
for r=1:length(colnames)
%     fill the column
    data(1,r) = length(controlMedians{r}.(fld));
    data(2,r) = mean(controlMedians{r}.(fld));
    data(3,r) = std(controlMedians{r}.(fld));
    data(4,r) = length(prosoMedians{r}.(fld));
    data(5,r) = mean(prosoMedians{r}.(fld));
    data(6,r) = std(prosoMedians{r}.(fld));
    data(7,r) = stats{r}.(fld).STATS.tstat;
    data(8,r) = stats{r}.(fld).P;
    data(9,r) = stats{r}.(fld).STATS.df;
    
end

f1 = figure('Name', 'co between groups','Color',[1 1 1],'Position',get(0,'ScreenSize'));
format long g;
t=uitable('Data',data,'ColumnName',colnames,'RowName',rownames,...
    'Units','normalized','Position',[0 0 1 1]);
% save figure
saveas(gcf,[h.saveDir 'CvsPTable.' fld '.' figname '.png'],'png');

% eccentricity
fld = 'ecc';
data = zeros(length(rownames),length(colnames{1}));
for r=1:length(colnames)
%     fill the column
    data(1,r) = length(controlMedians{r}.(fld));
    data(2,r) = mean(controlMedians{r}.(fld));
    data(3,r) = std(controlMedians{r}.(fld));
    data(4,r) = length(prosoMedians{r}.(fld));
    data(5,r) = mean(prosoMedians{r}.(fld));
    data(6,r) = std(prosoMedians{r}.(fld));
    data(7,r) = stats{r}.(fld).STATS.tstat;
    data(8,r) = stats{r}.(fld).P;
    data(9,r) = stats{r}.(fld).STATS.df;
    
end

f1 = figure('Name', 'eccentricity between groups','Color',[1 1 1],'Position',get(0,'ScreenSize'));
format long g;
t=uitable('Data',data,'ColumnName',colnames,'RowName',rownames,...
    'Units','normalized','Position',[0 0 1 1]);
% save figure
saveas(gcf,[h.saveDir 'CvsPTable.' fld '.' figname '.png'],'png');


% sigma
fld = 'sigma';
data = zeros(length(rownames),length(colnames{1}));
for r=1:length(colnames)
%     fill the column
    data(1,r) = length(controlMedians{r}.(fld));
    data(2,r) = mean(controlMedians{r}.(fld));
    data(3,r) = std(controlMedians{r}.(fld));
    data(4,r) = length(prosoMedians{r}.(fld));
    data(5,r) = mean(prosoMedians{r}.(fld));
    data(6,r) = std(prosoMedians{r}.(fld));
    data(7,r) = stats{r}.(fld).STATS.tstat;
    data(8,r) = stats{r}.(fld).P;
    data(9,r) = stats{r}.(fld).STATS.df;
    
end

f1 = figure('Name', 'sigma between groups','Color',[1 1 1],'Position',get(0,'ScreenSize'));
format long g;
t=uitable('Data',data,'ColumnName',colnames,'RowName',rownames,...
    'Units','normalized','Position',[0 0 1 1]);
% save figure
saveas(gcf,[h.saveDir 'CvsPTable.' fld '.' figname '.png'],'png');






% guess we don't have the actual means of the medians so would need to
% compute them each time

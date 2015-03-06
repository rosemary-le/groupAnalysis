%  s_sizeVeccAcrossROIs(rois, h);


% takes a list of filenames which contain pRF models for each voxel in the
% roi for a group of subjects
% h is a struct containing various parameters for thresholding and so on
% h.threshecc
% h.threshco
% h.threshsigma
%% load roi.  threshold data.  bootstrap line fit for each roi.  make plot.
% should produce plots similar to those in Kendrick's jneurophys paper





% directory with code
% codeDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
codeDir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
addpath(codeDir);

% directory with data
% dataDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
dataDir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';



rois = {
%         'lV1.flippedrV1.mat', 'cV1';
%     
% %         ventral %
% %         'lV2v.flippedrV2v.mat', 'cV2v';
% %             'lV2d.flippedrV2d.mat', 'cV2d';
% %         'lV3v.flippedrV3v.mat', 'cV3v';
% %             'lV3d.flippedrV3d.mat', 'cV3d';
%                 'lV2.flippedrV2.mat', 'cV2';
% 
%     'lV3.flippedrV3.mat', 'cV3';
% 
%         'lV4.flippedrV4.mat', 'chV4';
%         'lVO1.flippedrVO1.mat', 'cVO1';
%         'lVO2.flippedrVO2.mat', 'cVO2';
%         'lLO1.flippedrLO1.mat', 'cLO1';
%         'lLO2.flippedrLO2.mat','cLO2';

        % lateral
    
    
    % faces ventral
%     'l_V4_fVp.flippedr_V4_fVp.mat', 'cIOG';
%     'l_pfus.flippedr_pfus.mat', 'cpFus';
%     'l_mfus.flippedr_mfus.mat', 'cmFus';
% %     
%          'l_cos.flippedr_cos.mat','cCoS';
    
% % %         % Prosos
        'lV1.flippedrV1.Prosos.mat'    'pV1';
%         'lV2v.flippedrV2v.Prosos.mat'         'pV2v';
%              'lV2d.flippedrV2d.Prosos.mat' 'pV2d';
%         'lV3v.flippedrV3v.Prosos.mat',  'pV3v';
%             'lV3d.flippedrV3d.Prosos.mat' 'pV3d';
    'lV2.flippedrV2.Prosos.mat' 'pV2';
        'lV3.flippedrV3.Prosos.mat','pV3';
        'lV4.flippedrV4.Prosos.mat' 'phV4';
        'lVO1.flippedrVO1.Prosos.mat', 'pVO1';
        'lVO2.flippedrVO2.Prosos.mat' 'pVO2';
% % %     
% % %     
%            'l_V4_fVp.flippedr_V4_fVp.Prosos.mat' 'pIOG';
% %     'l_pfus.flippedr_pfus.Prosos.mat'  'ppFus';
%     'l_mfus.flippedr_mfus.Prosos.mat' 'pmFus';
 
    % 'l_cos.flippedr_cos.Prosos.mat','pCoS';
    };


% thresholds on roi and plotting
% optimally, this could be done once but its a lot of working code to fix
% threshold
h.threshco = 0.15;
h.threshecc = [0.5 10];
h.threshsigma = [0 24];
h.binsize = 1;
h.minvoxelcount = 5;

% should be datadir FullAnalysis / threshold / SubjectsUsed / ROI/
threshstring =  ['co' num2str(h.threshco) ...
    '.ecc' num2str(h.threshecc(1)) '_' num2str(h.threshecc(2)) '.sig' ...
    num2str(h.threshsigma(1)) '_' num2str(h.threshsigma(2)) '/'];


% subjects to use
h.sessions = {
    %    controls
    '42611_AH'
    '43011_YW'
    'adult_amk_27yo_042910'
    'adult_cmb_23yo_070608'
        'adult_dy_25yo_041908'
    'adult_jw_36yo_061608'
        'adult_kll_18yo_052408'
        'adult_kw_fmri2_27yo_092910'
    'adult_mem_18yo_062608'
%             'adult_jc_27yo_052408'
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
% subsused ='subsNoKWKLLTMDY/';
subsused = 'subsNocakwcmbmemV1varmatched';

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
    
    % load roi
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
%     
    tmp = rm(rmindex);
    rm = tmp;
    
    % threshold data
    th_rm = f_thresholdRMData(rm,h);
    % bootstrap line fit
    [th_rm models{r}] = f_sizeVSeccFromROIGroupOnly(th_rm, h);
    %     make space
    clear rm th_rm
    %     add a name to the models
    models{r}.roiname = rois(r,1);
    legendnames(r)=rois(r,2);
    
end


% make our plot

figure('Name','ecc x size across areas','Color',[1 1 1],...
    'Position',get(0,'ScreenSize'));
hold on
% % colors for plot
pcolors = [
        0 0 0; %V1
        .8 .8 .8; %V2v
        .7 .7 .7; %V2d
        1 0 0; %V3v
        .8 0 0; %V3d
         .5 1 1; %V4d
        1 0 1; %VO1
        .8 0 .8; %VO2
        0 0 0; %V1
    1 0 0; %IOG
    0 1 0; %pFus
    0 0 1; %mfus
    ];

xvals = h.threshecc(1):.1:h.threshecc(2);   % x-values to evaluate the model at

for r=1:length(models)
    %     get percentiles
    modelfit = prctile(models{r}.submodelfit,[17 50 83]);
    %     % define a polygon by following the 2.5th percentile line (left to right)
    %     % and then reversing and following the 97.5th percentile line (right to
    %     % left).
    h2(r) = patch([xvals fliplr(xvals)],[modelfit(1,:) fliplr(modelfit(3,:))],pcolors(r,:));
    set(h2(r),'EdgeColor','none','FaceAlpha',.5);
    
    h3(r) = plot(xvals,modelfit(2,:),'LineWidth',2,'Color',pcolors(r,:));
end


% add x = y line

plot(xvals,xvals,'k--');

% legend and plot stuff
legend(h3,legendnames,'Location','EastOutside');
legend boxoff;

xlabel('eccentricity of pRF center in degrees');
ylabel('size of pRF in degrees');

% put a title on it that is ugly but useful
title([threshstring '   ' figname]);


% save the figure

saveas(gcf,[h.saveDir figname num2str(h.binsize)  'bins.sizeVecc.png'],'png');


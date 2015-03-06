% roiStats.m   the goal is to collect some summary stats from rois and then
% turn them into plots
% in particular we want to know whether certain basic things differ between
% prosos and controls

% for variable measure can have
% 'size' size of roi
% 'retvarexp' variance explained by ret
% number of retinotopic voxels above a given threshold
% variance explained by loc glm
% variance explained by ecc glm
% mean signal (this might require loading the hidden view)


% measure = 'size';
% measure = 'retvarexp';
measure = 'ecc';
% measure = 'sigma';

threshold.co = 0.1;
threshold.ecc = [.5 10];
threshold.sigma = [0 10];
    

threshstring =['.co' num2str(threshold.co) '.ecc' num2str(threshold.ecc(1)) ...
'_' num2str(threshold.ecc(2)) '.sigma' num2str(threshold.sigma(1))...
'_' num2str(threshold.sigma(2))];

% add our code to the path
% addpath('/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');
addpath('~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');
% to get roi size from a plot we would do

% assumes we are in directory with these variables
% cd '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
cd '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
% set our rois to load in pairs



% set a save directory
saveDir = 'ProsoVSControlsROIStatsCO10ECC.510sigma010/';
% make sure directory exists
if ~exist(saveDir)
    disp('save directory does not exist, creating');
    mkdir(saveDir);
end

roistoload = {
    %     both
    
    'bothV1_all_nw.mat', 'bothV1_all_nw.Prosos.mat';
    %     % ventral
    'bothV2v_all_nw.mat','bothV2v_all_nw.Prosos.mat';
    'bothV3v_all_nw.mat','bothV3v_all_nw.Prosos.mat';
    'bothV4_all_nw.mat','bothV4_all_nw.Prosos.mat';
    'bothVO1_all_nw.mat','bothVO1_all_nw.Prosos.mat';
%     'bothVO2_all_nw.mat','bothVO2_all_nw.Prosos.mat';
    
    %     % lateral
    'bothV2d_all_nw.mat','bothV2d_all_nw.Prosos.mat';
    'bothV3d_all_nw.mat','bothV3d_all_nw.Prosos.mat';
    
        %         faces
    'both_mfus_fVp_001_nw.mat','both_mfus_fVp_001_nw.Prosos.mat';
    'both_pfus_fVp_001_nw.mat','both_pfus_fVp_001_nw.Prosos.mat';
    'both_V4_fVp_001_nw.mat','both_V4_fVp_001_nw.Prosos.mat'; 
    
    % flipped
    
    
    'lV1.flippedrV1.mat','lV1.flippedrV1.Prosos.mat';
    'lV2d.flippedrV2d.mat','lV2d.flippedrV2d.Prosos.mat';
    'lV2v.flippedrV2v.mat','lV2v.flippedrV2v.Prosos.mat';
    'lV3d.flippedrV3d.mat','lV3d.flippedrV3d.Prosos.mat';
    'lV3v.flippedrV3v.mat', 'lV3v.flippedrV3v.Prosos.mat';
    'lV4.flippedrV4.mat','lV4.flippedrV4.Prosos.mat';
    'lVO1.flippedrVO1.mat','lVO1.flippedrVO1.Prosos.mat';
    'lVO2.flippedrVO2.mat','lVO2.flippedrVO2.Prosos.mat';
    'l_mfus.flippedr_mfus.mat', 'l_mfus.flippedr_mfus.Prosos.mat';
    'l_pfus.flippedr_pfus.mat', 'l_pfus.flippedr_pfus.Prosos.mat';
    'l_V4_fVp.flippedr_V4_fVp.mat','l_V4_fVp.flippedr_V4_fVp.Prosos.mat';
   } 



sessionstouse =  {
    '42611_AH'
    '43011_YW'
    'adult_amk_27yo_042910'
    'adult_cmb_23yo_070608'
        'adult_dy_25yo_041908'
    'adult_jw_36yo_061608'
            'adult_kll_18yo_052408'
        'adult_kw_fmri2_27yo_092910'
    'adult_mem_18yo_062608'
%         'adult_jc_27yo_052408'
        'adult_rb_22yo_101908'
    'adult_acg_39yo_012008'
    'adult_ca_22yo_061908'
    '41711_TM'
    '42811_TA'
    };

for r=1:size(roistoload,1)
    % then
    roiSizeData = PlotROIStats([roistoload(r,1), roistoload(r,2)],measure,...
        threshold,sessionstouse);
    % let's clean up the figure with some specific details
    set(gca,'XTick',[1 2],'XTickLabel',{'Controls','Prosos'});
    ylabel(measure);
    
    % get data from figure
    roiData = get(gcf,'UserData');
    % 1x2 struct array with fields:
    %     sessions
    %     roiSizes
    %     name
    %     median
    %     mean
    
% %     get indices to unwanted subjects
%     delsess = [];
%     for bd =1:length(sessionstonotuse)
% %         find indices if any
%         delsess = find(strcmp(roiData(1).sessions, sessionstonotuse{bd}))
%     end
%     
% %     get sessions to keep
% 
%     keepsess = setdiff(1:length(roiData(1).sessions),delsess)
    
    
    % do a ttest
    [stats.H, stats.P, stats.CI, stats.STATS] = ttest2(roiData(1).subdata, roiData(2).subdata,.05,'both','unequal');
    %  put t and p value on the figure
    xlabel(['2 tailed ttest: t=' num2str(stats.STATS.tstat) ' p=' num2str(stats.P)])
    
    % save the figure
%     saveas(gcf,[saveDir char(roistoload(r,1)) '.' measure '.' threshstring '.PrososVsCon.fig'],'fig');
%     saveas(gcf,[saveDir char(roistoload(r,1)) '.' measure '.' threshstring '.PrososVsCon.png'],'png');
% %         close(gcf);
end
%
%
% % we might want to choose a subset of control subjects in such a way that
% % we match measures such as size vs. eccentricity in V1-V3 between groups.
% % need to be able to then go back through our other measures and pull out
% % subsets of data.  here is a cludge
%
% sessionstouse = {
% %     '42611_AH'
%     '43011_YW'
%     'adult_amk_27yo_042910'
%     'adult_cmb_23yo_070608'
%         'adult_dy_25yo_041908'
%     'adult_jw_36yo_061608'
%             'adult_kll_18yo_052408'
%         'adult_kw_fmri2_27yo_092910'
%     'adult_mem_18yo_062608'
%         'adult_jc_27yo_052408'
% %         'adult_rb_22yo_101908'
%     'adult_acg_39yo_012008'
%     'adult_ca_22yo_061908'
%     '41711_TM'
%     '42811_TA'
%     };
%
% cd('/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/ProsoVSControlFigs/');
%
%
%
% figstouse = {
%     'l_cos_pVf_001_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'l_cos_pVf_001_nw.size.thresh0.PrososVsCon.fig'
%     'l_mfus_fVp_001_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'l_mfus_fVp_001_nw.size.thresh0.PrososVsCon.fig'
%     'l_pfus_fVp_001_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'l_pfus_fVp_001_nw.size.thresh0.PrososVsCon.fig'
%     'l_V4_fVp_001_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'l_V4_fVp_001_nw.size.thresh0.PrososVsCon.fig'
% % %     'lIPS0_all_nw.retvarexp.thresh0.PrososVsCon.fig'
% % %     'lIPS0_all_nw.size.thresh0.PrososVsCon.fig'
% % %     'lIPS1_all_nw.retvarexp.thresh0.PrososVsCon.fig'
% % %     'lIPS1_all_nw.size.thresh0.PrososVsCon.fig'
% % %     'lLO1_all_nw.retvarexp.thresh0.PrososVsCon.fig'
% %     'lLO1_all_nw.size.thresh0.PrososVsCon.fig'
% %     'lLO2_all_nw.retvarexp.thresh0.PrososVsCon.fig'
% %     'lLO2_all_nw.size.thresh0.PrososVsCon.fig'
%     'lV1_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'lV1_all_nw.size.thresh0.PrososVsCon.fig'
%     'lV2d_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'lV2d_all_nw.size.thresh0.PrososVsCon.fig'
%     'lV2v_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'lV2v_all_nw.size.thresh0.PrososVsCon.fig'
%     'lV3ab_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'lV3ab_all_nw.size.thresh0.PrososVsCon.fig'
%     'lV3d_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'lV3d_all_nw.size.thresh0.PrososVsCon.fig'
%     'lV3v_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'lV3v_all_nw.size.thresh0.PrososVsCon.fig'
%     'lV4_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'lV4_all_nw.size.thresh0.PrososVsCon.fig'
% %     'lVO1_all_nw.retvarexp.thresh0.PrososVsCon.fig'
% %     'lVO1_all_nw.size.thresh0.PrososVsCon.fig'
% %     'lVO2_all_nw.retvarexp.thresh0.PrososVsCon.fig'
% %     'lVO2_all_nw.size.thresh0.PrososVsCon.fig'
%     'r_cos_pVf_001_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'r_cos_pVf_001_nw.size.thresh0.PrososVsCon.fig'
%     'r_mfus_fVp_001_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'r_mfus_fVp_001_nw.size.thresh0.PrososVsCon.fig'
%     'r_pfus_fVp_001_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'r_pfus_fVp_001_nw.size.thresh0.PrososVsCon.fig'
%     'r_V4_fVp_001_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'r_V4_fVp_001_nw.size.thresh0.PrososVsCon.fig'
% % %     'rIPS0_all_nw.retvarexp.thresh0.PrososVsCon.fig'
% % %     'rIPS0_all_nw.size.thresh0.PrososVsCon.fig'
% % %     'rIPS1_all_nw.retvarexp.thresh0.PrososVsCon.fig'
% % %     'rIPS1_all_nw.size.thresh0.PrososVsCon.fig'
% %     'rLO1_all_nw.retvarexp.thresh0.PrososVsCon.fig'
% %     'rLO1_all_nw.size.thresh0.PrososVsCon.fig'
% %     'rLO2_all_nw.retvarexp.thresh0.PrososVsCon.fig'
% %     'rLO2_all_nw.size.thresh0.PrososVsCon.fig'
%     'rV1_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'rV1_all_nw.size.thresh0.PrososVsCon.fig'
%     'rV2d_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'rV2d_all_nw.size.thresh0.PrososVsCon.fig'
%     'rV2v_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'rV2v_all_nw.size.thresh0.PrososVsCon.fig'
%     'rV3ab_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'rV3ab_all_nw.size.thresh0.PrososVsCon.fig'
%     'rV3d_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'rV3d_all_nw.size.thresh0.PrososVsCon.fig'
%     'rV3v_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'rV3v_all_nw.size.thresh0.PrososVsCon.fig'
%     'rV4_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'rV4_all_nw.size.thresh0.PrososVsCon.fig'
%     'rVO1_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'rVO1_all_nw.size.thresh0.PrososVsCon.fig'
%     'rVO2_all_nw.retvarexp.thresh0.PrososVsCon.fig'
%     'rVO2_all_nw.size.thresh0.PrososVsCon.fig'
%     };
%
%
% for f=1:length(figstouse)
%     %     open the figure
%     open(figstouse{f});
%     %     get data
%     figdata = get(gcf,'UserData');
%     close(gcf);
%     %     figdata(1)=
%     %     sessions: {1x12 cell}
%     %      subdata: [1x12 double]
%     %         name: 'l_cos_pVf_001_nw'
%     %      measure: 'retvarexp'
%     %       median: 0.1699
%     %         mean: 0.1619
%
%     % see if  sessions you want to use have this roi
%     indx = [];
%     for i=1:length(sessionstouse)
%         indx = [indx find(strcmp(sessionstouse(i),figdata(1).sessions))];
%     end
%
%     %     alter fields for new figure
%     figdata(1).sessions = figdata(1).sessions(indx);
%     figdata(1).subdata = figdata(1).subdata(indx);
%
%     %     now make new figure
%     figure('Name',[figdata(1).name ' matched controls'],'Color',[1 1 1]);
%
%
%     %plot control data
%     scatter(ones(1,length(indx)),figdata(1).subdata,'k');
%     hold on;
%     scatter(1, median(figdata(1).subdata),'r');
%     scatter(1, mean(figdata(1).subdata),'g');
%
%     %     let's record these
%     figdata(1).median = median(figdata(1).subdata);
%     figdata(1).mean = mean(figdata(1).subdata);
%
%
%     %     plot proso data (this is unchanged)
%     scatter(2*ones(1, length(figdata(2).sessions)),figdata(2).subdata,'k');
%     scatter(2, figdata(2).median,'r');
%     scatter(2, figdata(2).mean,'g');
%
%     % fix x axis
%     set(gca,'XLim', [0, 3]);
%
%     % title
%     title(figdata(1).name,'interpreter','none');
%
%     % add data to figure
%     set(gcf,'UserData',figdata);
%
%      set(gca,'XTick',[1 2],'XTickLabel',{'Controls','Prosos'});
%     ylabel(figdata(1).measure);
%
%
%     % add in some pairwise ttests for each pair of rois
%       [stats.H, stats.P, stats.CI, stats.STATS] = ttest2(figdata(1).subdata, figdata(2).subdata,.05,'both');
%     %  put t and p value on the figure
%     xlabel(['2 tailed ttest: t=' num2str(stats.STATS.tstat) ' p=' num2str(stats.P)])
%
% %     close(gcf);
%
% %     print out some stuff
%     disp(figdata(1).name)
%     disp(figdata(1).sessions')
%     disp(figdata(1).subdata')
%     disp(stats.STATS.tstat)
%     disp(stats.P)
% end
%
%
%
%
%
%
%
%


    %     'rV1_all_nw.mat', 'rV1_all_nw.Prosos.mat';
    %     'lV1_all_nw.mat','lV1_all_nw.Prosos.mat';
    %     % ventral
    %     'rV2v_all_nw.mat','rV2v_all_nw.Prosos.mat';
    %     'lV2v_all_nw.mat','lV2v_all_nw.Prosos.mat';
    %     'rV3v_all_nw.mat','rV3v_all_nw.Prosos.mat';
    %     'lV3v_all_nw.mat','lV3v_all_nw.Prosos.mat';
    %     'rV4_all_nw.mat','rV4_all_nw.Prosos.mat';
    %     'lV4_all_nw.mat','lV4_all_nw.Prosos.mat';
    %     'rVO1_all_nw.mat','rVO1_all_nw.Prosos.mat';
    %     'lVO1_all_nw.mat','lVO1_all_nw.Prosos.mat';
    %     'rVO2_all_nw.mat','rVO2_all_nw.Prosos.mat';
    %     'lVO2_all_nw.mat','lVO2_all_nw.Prosos.mat';
    %     % lateral
    %     'rV2d_all_nw.mat','rV2d_all_nw.Prosos.mat';
    %     'lV2d_all_nw.mat','lV2d_all_nw.Prosos.mat';
    %     'rV3d_all_nw.mat','rV3d_all_nw.Prosos.mat';
    %     'lV3d_all_nw.mat','lV3d_all_nw.Prosos.mat';
    %     'rLO1_all_nw.mat','rLO1_all_nw.Prosos.mat';
    %     'lLO1_all_nw.mat','lLO1_all_nw.Prosos.mat';
    %     'rLO2_all_nw.mat','rLO2_all_nw.Prosos.mat';
    %     'lLO2_all_nw.mat','lLO2_all_nw.Prosos.mat';
    % parietal
    %     'rV3ab_all_nw.mat','rV3ab_all_nw.14-Apr-2014.Prosos.mat';
    %     'lV3ab_all_nw.mat','lV3ab_all_nw.14-Apr-2014.Prosos.mat';
    %     'rIPS0_all_nw.mat','rIPS0_all_nw.14-Apr-2014.Prosos.mat';
    %     'lIPS0_all_nw.mat','lIPS0_all_nw.14-Apr-2014.Prosos.mat';
    %     'rIPS1_all_nw.mat','rIPS1_all_nw.14-Apr-2014.Prosos.mat';
    %     'lIPS1_all_nw.mat','lIPS1_all_nw.14-Apr-2014.Prosos.mat';
    %     faces ventral
    %
    %     'l_mfus_fVp_001_nw.mat','l_mfus_fVp_001_nw.14-Apr-2014.Prosos.mat';
    %     'l_pfus_fVp_001_nw.mat','l_pfus_fVp_001_nw.14-Apr-2014.Prosos.mat';
    %     'l_V4_fVp_001_nw.mat','l_V4_fVp_001_nw.14-Apr-2014.Prosos.mat';
    % %
    %     'r_mfus_fVp_001_nw.mat','r_mfus_fVp_001_nw.14-Apr-2014.Prosos.mat';
    %     'r_pfus_fVp_001_nw.mat','r_pfus_fVp_001_nw.14-Apr-2014.Prosos.mat';
    %     'r_V4_fVp_001_nw.mat','r_V4_fVp_001_nw.14-Apr-2014.Prosos.mat';
    % %
    % %     % places ventral
    %     'l_cos_pVf_001_nw.mat','l_cos_pVf_001_nw.14-Apr-2014.Prosos.mat';
    %     'r_cos_pVf_001_nw.mat','r_cos_pVf_001_nw.14-Apr-2014.Prosos.mat';
    
    %     combined across hemispheres
    %     'l_mfus.flippedr_mfus.mat', 'l_mfus.flippedr_mfus.Prosos.mat';
    %     'l_pfus.flippedr_pfus.mat', 'l_pfus.flippedr_pfus.Prosos.mat';
    %     'l_V4_fVp.flippedr_V4_fVp.mat', 'l_V4_fVp.flippedr_V4_fVp.Prosos.mat';
    %     'lLO1.flippedrLO1.mat', 'lLO1.flippedrLO1.Prosos.mat';
    %     'lPHC1.flippedrPHC1.mat','lPHC1.flippedrPHC1.Prosos.mat';
    %     'lPHC2.flippedrPHC2.mat','lPHC2.flippedrPHC2.Prosos.mat';
%     'lV1.flippedrV1.mat','lV1.flippedrV1.Prosos.mat';
    %     'lV2d.flippedrV2d.mat','lV2d.flippedrV2d.Prosos.mat';
    %     'lV2v.flippedrV2v.mat','lV2v.flippedrV2v.Prosos.mat';
    %     'lV3d.flippedrV3d.mat','lV3d.flippedrV3d.Prosos.mat';
    %     'lV3v.flippedrV3v.mat', 'lV3v.flippedrV3v.Prosos.mat';
    %     'lV4.flippedrV4.mat','lV4.flippedrV4.Prosos.mat';
    %     'lVO1.flippedrVO1.mat','lVO1.flippedrVO1.Prosos.mat';
    %     'lVO2.flippedrVO2.mat','lVO2.flippedrVO2.Prosos.mat';
    
    %     'r_V4_fVp_001_nw.Prosos.mat','r_V4_fVp_001_nw.mat';
    %     'l_V4_fVp_001_nw.Prosos.mat','l_V4_fVp_001_nw.mat';
    %     'r_pfus_fVp_001_nw.Prosos.mat','r_pfus_fVp_001_nw.mat';
    %     'l_pfus_fVp_001_nw.Prosos.mat','l_pfus_fVp_001_nw.mat';
    %     'r_mfus_fVp_001_nw.Prosos.mat','r_mfus_fVp_001_nw.mat';
    %     'l_mfus_fVp_001_nw.Prosos.mat','l_mfus_fVp_001_nw.mat';
    %     'r_fusiform_fVp_nw.Prosos.mat','r_fusiform_fVp_nw.mat';
    %     'l_fusiform_fVp_nw.Prosos.mat', 'l_fusiform_fVp_nw.mat';
    %     'all_fusiform_fVp_nw.Prosos.mat','all_fusiform_fVp_nw.mat';
    %     'r_ventral_fVp_nw.Prosos.mat', 'r_ventral_fVp_nw.mat';
    %     'l_ventral_fVp_nw.Prosos.mat', 'l_ventral_fVp_nw.mat';
    %     'all_ventral_fVp_nw.Prosos.mat','all_ventral_fVp_nw.mat';
    
%     };


% roistoload = {'rV1_nw.01-Apr-2014Prosos.mat', 'rV1_nw.24-Mar-2014.mat';
%     'rV2v_nw.01-Apr-2014Prosos.mat', 'rV2v_nw.24-Mar-2014.mat';
%     'rV2d_nw.01-Apr-2014Prosos.mat', 'rV2d_nw.24-Mar-2014.mat';
%     'rV3v_nw.01-Apr-2014Prosos.mat', 'rV3v_nw.24-Mar-2014.mat';
%     'rV3d_nw.01-Apr-2014Prosos.mat', 'rV3d_nw.24-Mar-2014.mat';
%     'rV4_nw.01-Apr-2014Prosos.mat', 'rV4_nw.24-Mar-2014.mat';
%     'rVO1_nw.01-Apr-2014Prosos.mat', 'rVO1_nw.24-Mar-2014.mat';
%     'rVO2_nw.01-Apr-2014Prosos.mat', 'rVO2_nw.24-Mar-2014.mat';
%     %             'rV3ab_nw.01-Apr-2014Prosos.mat', 'rV3ab_nw.09-Jan-2014.mat';
%     'lV1_nw.01-Apr-2014Prosos.mat', 'lV1_nw.24-Mar-2014.mat';
%     'lV2v_nw.01-Apr-2014Prosos.mat', 'lV2v_nw.24-Mar-2014.mat';
%     'lV2d_nw.01-Apr-2014Prosos.mat', 'lV2d_nw.24-Mar-2014.mat';
%     'lV3v_nw.01-Apr-2014Prosos.mat', 'lV3v_nw.24-Mar-2014.mat';
%     'lV3d_nw.01-Apr-2014Prosos.mat', 'lV3d_nw.24-Mar-2014.mat';
%     'lV4_nw.01-Apr-2014Prosos.mat', 'lV4_nw.24-Mar-2014.mat';
%     'lVO1_nw.01-Apr-2014Prosos.mat', 'lVO1_nw.24-Mar-2014.mat';
%     'lVO2_nw.01-Apr-2014Prosos.mat', 'lVO2_nw.24-Mar-2014.mat';
%     'lV3ab_nw.01-Apr-2014Prosos.mat', 'lV3ab_nw.09-Jan-2014.mat';
%     };
%


%
%
%

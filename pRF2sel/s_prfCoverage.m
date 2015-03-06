% s_prfCoverage

% want this script to generate prf coverage given one or many of our
% roi.mat files


% thresh is a struct with the followin fields
% thresh.varexp  minimum variance explained by model in each voxel 0-1
% default is .1
% thresh.sig  min and max sigma (size) to use [0 14]
% default is [.5 28]
% thresh.ecc is mim and max ecc to use, default is [.5 13.5]
% thresh.binsize =  how to bin on x axis 0.5


% set some variables
% directory with .mat files
roidir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
roidir ='~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';

% % roi names
% %
% %
% % % % % % % % % % % % % % % % % % % % % % % controls
% % % % % % % % % % % % % % % % % % % % % % %
rois = {
    'lV1.flippedrV1.mat'
    'bothV1_all_nw.mat'
% %     % ventral
    'lV2v.flippedrV2v.mat'
    'bothV2v_all_nw.mat'
    'lV3v.flippedrV3v.mat'
    'bothVv_all_nw.mat'
    'lV4.flippedrV4.mat'
    'bothV4_all_nw.mat'
    'lVO1.flippedrVO1.mat'
    
    'lVO2.flippedrVO2.mat'
% %     % lateral
    'lV2d.flippedrV2d.mat'
    'lV3d.flippedrV3d.mat'
    'lLO1.flippedrLO1.mat'
    'lLO2.flippedrLO2.mat'
% %     %     % parietal
    'lV3ab.flippedrV3ab.mat'
% %     'lIPS0.flippedrIPS0.mat'
% %     'lIPS1.flippedrIPS1.mat'
% %     % faces ventral
% %     'l_mfus.flippedr_mfus.mat'
% %     'l_pfus.flippedr_pfus.mat'
% %     'l_V4_fVp.flippedr_V4_fVp.mat'
% %     % places ventral
% %     'l_cos.flippedr_cos.mat'
%         'rV1_all_nw.mat'
%         'lV1_all_nw.mat'
%         % ventral
%         'rV2v_all_nw.mat'
%         'lV2v_all_nw.mat'
%         'rV3v_all_nw.mat'
%         'lV3v_all_nw.mat'
%         'rV4_all_nw.mat'
%         'lV4_all_nw.mat'
%         'rVO1_all_nw.mat'
%         'lVO1_all_nw.mat'
%         'rVO2_all_nw.mat'
%         'lVO2_all_nw.mat'
%         % lateral
%         'rV2d_all_nw.mat'
%         'lV2d_all_nw.mat'
%         'rV3d_all_nw.mat'
%         'lV3d_all_nw.mat'
%         'rLO1_all_nw.mat'
%         'lLO1_all_nw.mat'
%         'rLO2_all_nw.mat'
%         'lLO2_all_nw.mat'
%     %     % parietal
%     'rV3ab_all_nw.mat'
%     'lV3ab_all_nw.mat'
%     'rIPS0_all_nw.mat'
%     'lIPS0_all_nw.mat'
%     'rIPS1_all_nw.mat'
%     'lIPS1_all_nw.mat'
%     % faces ventral
%     'l_mfus_fVp_001_nw.mat'
%     'l_pfus_fVp_001_nw.mat'
%     'l_V4_fVp_001_nw.mat'
%     'r_mfus_fVp_001_nw.mat'
%     'r_pfus_fVp_001_nw.mat'
%     'r_V4_fVp_001_nw.mat'
%     % places ventral
    'l_cos_pVf_001_nw.mat'
    'r_cos_pVf_001_nw.mat'
%     'both_PHCanatXcospvf_nw'
% 'both_VOanatXcospvf_nw'
% 'l_antHIPPanatXcospvf_nw'
% 'l_PHCanatXcospvf_nw'
% 'l_VOanatXcospvf_nw'
% 'r_antHIPPanatXcospvf_nw'
% 'r_PHCanatXcospvf_nw'
% 'r_VOanatXcospvf_nw'
% 'rVO1_all_and_pVf_001_nw'
% 'lVO1_all_and_pVf_001_nw'
% 'rVO2_all_and_pVf_001_nw'
% 'lVO2_all_and_pVf_001_nw'
% 'rPHC1_all_and_pVf_001_nw'
% 'lPHC1_all_and_pVf_001_nw'
% 'rPHC2_all_and_pVf_001_nw'
% 'lPHC2_all_and_pVf_001_nw'
% % 'both_V4_all_and_pVf_001_nw'
% 'both_VO1_all_and_pVf_001_nw'
% 'both_VO2_all_and_pVf_001_nw'
% 'both_PHC1_all_and_pVf_001_nw'
% 'both_PHC2_all_and_pVf_001_nw'
% 'r_PHC_all_and_pVf_001_nw'
% 'l_PHC_all_and_pVf_001_nw'
% 'r_VO_all_and_pVf_001_nw'
% 'l_VO_all_and_pVf_001_nw'
% 'lPHC2pVf.flippedrPHC2pVf.mat'
% 'lPHC1pVf.flippedrPHC1pVf.mat'
% 'lVO2pVf.flippedrVO2pVf.mat'
% 'lVO1pVf.flippedrVO1pVf.mat'

    };
% %
% % % % % savedirectory
saveDir = [roidir 'prfCoveragePlotsbootstrapControls/'];

if ~exist(saveDir)
    mkdir(saveDir);
end

%



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % prosos
% rois = {
% 'rV1_all_nw.14-Apr-2014.Prosos.mat'
% 'lV1_all_nw.14-Apr-2014.Prosos.mat'
% % ventral
% 'rV2v_all_nw.14-Apr-2014.Prosos.mat'
% 'lV2v_all_nw.14-Apr-2014.Prosos.mat'
% 'rV3v_all_nw.14-Apr-2014.Prosos.mat'
% 'lV3v_all_nw.14-Apr-2014.Prosos.mat'
% 'rV4_all_nw.14-Apr-2014.Prosos.mat'
% 'lV4_all_nw.14-Apr-2014.Prosos.mat'
% 'rVO1_all_nw.14-Apr-2014.Prosos.mat'
% 'lVO1_all_nw.14-Apr-2014.Prosos.mat'
% 'rVO2_all_nw.14-Apr-2014.Prosos.mat'
% 'lVO2_all_nw.14-Apr-2014.Prosos.mat'
% % lateral
% 'rV2d_all_nw.14-Apr-2014.Prosos.mat'
% 'lV2d_all_nw.14-Apr-2014.Prosos.mat'
% 'rV3d_all_nw.14-Apr-2014.Prosos.mat'
% 'lV3d_all_nw.14-Apr-2014.Prosos.mat'
% 'rLO1_all_nw.14-Apr-2014.Prosos.mat'
% 'lLO1_all_nw.14-Apr-2014.Prosos.mat'
% 'rLO2_all_nw.14-Apr-2014.Prosos.mat'
% 'lLO2_all_nw.14-Apr-2014.Prosos.mat'
% % parietal
% 'rV3ab_all_nw.14-Apr-2014.Prosos.mat'
% 'lV3ab_all_nw.14-Apr-2014.Prosos.mat'
% 'rIPS0_all_nw.14-Apr-2014.Prosos.mat'
% 'lIPS0_all_nw.14-Apr-2014.Prosos.mat'
% 'rIPS1_all_nw.14-Apr-2014.Prosos.mat'
% 'lIPS1_all_nw.14-Apr-2014.Prosos.mat'
% % faces ventral
% 'l_mfus_fVp_001_nw.14-Apr-2014.Prosos.mat'
% 'l_pfus_fVp_001_nw.14-Apr-2014.Prosos.mat'
% 'l_V4_fVp_001_nw.14-Apr-2014.Prosos.mat'
% 'r_mfus_fVp_001_nw.14-Apr-2014.Prosos.mat'
% 'r_pfus_fVp_001_nw.14-Apr-2014.Prosos.mat'
% 'r_V4_fVp_001_nw.14-Apr-2014.Prosos.mat'
% % places ventral
% 'l_cos_pVf_001_nw.14-Apr-2014.Prosos.mat'
% 'r_cos_pVf_001_nw.14-Apr-2014.Prosos.mat'
% };
% % savedirectory
% saveDir = [roidir 'prfCoveragePlotsWeightedProsos/'];
% theshold to use
thresh.varexp =.1;
thresh.sig = [0 24];
thresh.ecc = [.5 11.5];
thresh.binsize =  0.5;
% need to work on this and vfc settings to add as variable to pass
%% parameters for making prf coverage
vfc.prf_size = true; %if 0 will only plot the centers
vfc.fieldRange = 12;  %radius of stimulus
vfc.method = 'maximum profile';         %method for doing coverage.  another choice is density
vfc.newfig = true;                      %any value greater than -1 will result in a plot
vfc.nboot = 200;                          %number of bootstraps
vfc.normalizeRange = true;              %set max value to 1
vfc.smoothSigma = false;                %not sure
vfc.cothresh = 0;                      %threshold coherence
vfc.eccthresh = [0 1.5*vfc.fieldRange]; 
vfc.nSamples = 128;       %fineness of grid used for making plots     
vfc.meanThresh = 0;   %threshold by mean map, no way to use this at the moment
vfc.weight = 'fixed';  
% vfc.weight = 'variance explained';
vfc.weightBeta = 0;
vfc.cmap = 'hot';						
vfc.clipn = 'fixed';                    
vfc.threshByCoh = false;                
vfc.addCenters = true;                 
vfc.verbose = 1;   %print stuff or not
vfc.dualVEthresh = 0;
vfc.binsize = 0.5;
%     make sure savedir exists
if ~exist(saveDir)
    mkdir(saveDir)
end

% sessionstouse = {
%     %     '42611_AH'
%     '43011_YW'
%     'adult_amk_27yo_042910'
%     'adult_cmb_23yo_070608'
%     %     'adult_dy_25yo_041908'
%     'adult_jw_36yo_061608'
%     %         'adult_kll_18yo_052408'
%     %     'adult_kw_fmri2_27yo_092910'
%     'adult_mem_18yo_062608'
%     %     'adult_jc_27yo_052408'
%     %     'adult_rb_22yo_101908'
%     'adult_acg_39yo_012008'
%     'adult_ca_22yo_061908'
%     %     '41711_TM'
%     '42811_TA'
%     };

sessionsflag = 0; %0 to use all, 1 to use subset



% for each roi
for r=1:length(rois)
    
    %     set path to roi .mat file
    roiFile=[roidir rois{r}];
    %     load it
    load(roiFile);
    %     this automatically puts rm in the workspace
    %     for each subject make a visual field coverage plot
    RFcov = {};
    
    %     do we want just a subset of the sessions?
    if sessionsflag == 1
        %         find sessions to use
        rmstouse = [];
        %         get sessions that are in this roi
        sessionsinroi=[];
        for i=1:length(rm)
            sessionsinroi{i}=rm{i}.session;
        end
        for i=1:length(sessionstouse)
            rmstouse =  [rmstouse   find(strcmp(sessionstouse{i},sessionsinroi))];
        end
    else
        %            use all sessions
        rmstouse = 1:length(rm);
    end
    
    for s=1:length(rmstouse)
        %     make and save plots
        [RFcov{s}, figHandle, all_models, weight, data] = rmPlotCoveragefromROImatfile(rm{rmstouse(s)},vfc);
        %      will want to save these
        saveas(gcf,[saveDir rois{r} '.' rm{rmstouse(s)}.session '.coverage.fig'],'fig');
        saveas(gcf,[saveDir rois{r} '.' rm{rmstouse(s)}.session '.coverage.png'],'png');
        
        close(gcf)
        %         also save as jpg
        
        
    end
    
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    %     make average visual field coverage plot  for each roi
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    
    groupcov = zeros(size(RFcov{1}));
    for k=1:length(rmstouse)
        groupcov = [groupcov + RFcov{k}];
    end
    groupcov = groupcov/length(RFcov);
    figure('Name',['group prf coverage for ' rois{r}],'Color',[1 1 1]);
    
    %     going to borrow the approach from rmPlotCoverage.m
    vfc.fieldRange=12;
    % normalize the color plots to 1
    
    rfMax = max(max(groupcov));
    
    
    img = groupcov ./ rfMax;
    mask = makecircle(length(img));
    img = img .* mask;
    %     stupidly data is derived from the last subject and so if there is no
    %     coverage the code crashes.  data is actually the same as rm except it
    %     pulls out the subset over the coherence threshold
    %     imagesc(data.X(1,:), data.Y(:,1), img);
    imagesc([-12,12],[-12,12],img);
    
    set(gca, 'YDir', 'normal');
    grid on
    
    colormap(vfc.cmap);
    colorbar;
    
    % start plotting
    hold on;
    
    
    % add polar grid on top
    p.ringTicks = (1:3)/3*vfc.fieldRange;
    p.color = 'w';
    polarPlot([], p);
    
%     add prf centers to group plot?
    vfc.addCenters = 0;
    % % add pRF centers if requested
    if vfc.addCenters,
        %             for each subject add the prf centers
        for k=1:length(rmstouse)
            
            inds = rm{rmstouse(k)}.ecc < vfc.fieldRange;
            plot(rm{rmstouse(k)}.x0(inds), rm{rmstouse(k)}.y0(inds), '.', ...
                'Color', [.5 .5 .5], 'MarkerSize', 4);
        end
        
    end
    
    
    % scale z-axis
    % if vfc.normalizeRange
    % 	if isequal( lower(vfc.method), 'maximum profile' )
    % 		caxis([.5 1]);
    % 	else
    % 	    caxis([0 1]);
    % 	end
    % else
    %     if min(RFcov(:))>=0
    %         caxis([0 ceil(max(RFcov(:)))]);
    %     else
    %         caxis([-1 1] * ceil(max(abs(RFcov(:)))));
    %     end
    % end
    axis image;   % axis square;
    xlim([-vfc.fieldRange vfc.fieldRange])
    ylim([-vfc.fieldRange vfc.fieldRange])
    
    
    
    colormap hot;
    colorbar;
    
    title(rm{1}.name, 'FontSize', 24, 'Interpreter', 'none');
    saveas(gcf,[saveDir rois{r} '.group.coverage.fig'],'fig');
    saveas(gcf,[saveDir rois{r} '.group.coverage.png'],'png');
    
    
    
    
end








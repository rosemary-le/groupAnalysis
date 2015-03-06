%  script which given a .mat file containing the prf models for an roi
%  generates various histograms of a pRF parameter across rois.  would be
%  nice to have across subjects bootstrapped confidence intervals, though
%  could specify whether error bars are mixed or random effects.

% add our code to the path
% addpath('/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');
addpath('~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');



% assumes we are in directory with these variables
% controldir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/controlstestinghists/';

datadir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';
% '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/prosoparamshist1degbin/';



% rois to show on a single graph
rois = {
    
%  'l_cos.flippedr_cos.mat', 'l_cos.flippedr_cos.Prosos.mat' 'CoSplacesflippedleft';
'bothV1_all_nw.mat'
% 'bothV1_all_nw.Prosos.mat', 'bothV1';
'bothV2_all_nw.mat'
% bothV2_all_nw.Prosos.mat','bothV2';
%    'bothV3_all_nw.mat','bothV3_all_nw.Prosos.mat','bothV3';
% % %    'bothV2v_all_nw','bothV2v_all_nw.Prosos','bothV2v';
    'bothV3v_all_nw'
% 'bothV3v_all_nw.Prosos','bothV3v';
    'bothV4_all_nw.mat'
% 'bothV4_all_nw.Prosos.mat','bothV4';
% % %     'bothV2d_all_nw','bothV2d_all_nw.Prosos','bothV2d';
% % %   'bothV3d_all_nw','bothV3d_all_nw.Prosos','bothV3d';
% % % % % %     % ventral
  'bothVO1_all_nw.mat'
% ,'bothVO1_all_nw.Prosos.mat','bothVO1';
%   'bothVO2_all_nw.mat'
% ,'bothVO2_all_nw.Prosos.mat','bothVO2';
%    'bothPHC1_all_nw.mat'
%    'bothPHC2_all_nw.mat'
% % % % % %     face rois
% %     % % face rois
%     'both_V4_fVp_001_nw.mat','both_V4_fVp_001_nw.Prosos.mat','bothIOG';
%    'both_pfus_fVp_001_nw.mat','both_pfus_fVp_001_nw.Prosos.mat','bothpFus';
%      'both_mfus_fVp_001_nw.mat','both_mfus_fVp_001_nw.Prosos.mat','bothmFus';
};


% subjects to use
h.controlsessions = {
    %    controls
    '42111_MN'
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
    %         'adult_jc_27yo_052408'
    'adult_rb_22yo_101908'
    'adult_acg_39yo_012008'
    'adult_ca_22yo_061908'
    '41711_TM'
    '42811_TA'};

% give the figure a name
figname = 'V1-hV4';




% directory to save figures in

% savedir = [controldir '/groupedacrossROIs/'];
% savedir = '~/Desktop/hists/';
% savedir =
% '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/ProsoVSControlHists1degbins/';


% if ~exist(savedir)
%     mkdir(savedir);
% end

% param to uses
% stupid naming
h.param = 'ecc';
% paramtouse = '.sigma'

% thresholds on roi and plotting
% optimally, this could be done once but its a lot of working code to fix
% threshold
h.threshco = 0.1;
h.threshecc = [1 12];
h.threshsigma = [0 24];
h.minvoxelcount = 10; %minimum number of voxels in roi
% % 
% % % distributions of parameters  mainly sigma and ecc
% need bins and binsizes for each measure
h.corange = [0 1];
h.cobinsize = .1;
h.eccrange = [h.threshecc(1) h.threshecc(2)];
h.eccbinsize = 1;
h.sigmarange = [h.threshsigma(1) h.threshsigma(2)];
h.sigmabinsize = 1;

% do it!

% want to get and threshold the data for each ROI
for r=1:length(rois)
    % load rms from controls into workspace
    load([datadir char(rois(r))]);
    
    % get only subjects we are interested in
    % find index to rms we want to keep
    rmindex = [];
    % for each rm
    for m=1:length(rm)
        %     check for matching session name
        for s=1:length(h.controlsessions)
            %         if it matches add rm to sbindx
            if strcmp(h.controlsessions(s),rm{m}.session)
                rmindex = [rmindex m];
            end
        end
        
    end
    % get our control data
    controls = rm(rmindex);
    
    
    % unload excess variables
    clear mv rm ECCmv;
    
    % % % % % % % % % % % % % % % % % % % % % % % analyses
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    
    
    
    % threshold the data
    th_controls = f_thresholdRMData(controls,h);
    
    %     now need to extract parameters and create bootstrapped line and save
    [hists{r} th_controls] = f_makePRFhistsForROI(th_controls,h);
%     
%     figure; plot(hists.sigma.pdfsigboots');
%     title(rois(r));
%     figure; plot(hists.ecc.pdfeccboots');
%     title(rois(r));
%     
end


% specify the colors
linecolors = [
1 0 0 %red
1 .4 0 %orange
1 1 0 % yellow
0 1 1 %cyan
0 0 1  %blue
1 0 1% red
1 1 0 %pink
0 1 1  %orange
.25 0 .5 %dark purple
.5 0 .5
1 0 1
];



% define confidence interval
% 68%
h.prctiles = [16 50 84];
%95%
% h.prctiles = [2.5 50 97.5];


% make ecc and sigma parameter histogram plots

figure('Name','distribution of sigmas','Color',[1 1 1]);
%get percentile data
for r=1:length(hists)
%     get percentile data for that area
yc = prctile(hists{r}.sigma.countsigboots,h.prctiles);

ycpdf = prctile(hists{r}.sigma.pdfsigboots,h.prctiles);


x=h.sigmarange(1):h.sigmabinsize:h.sigmarange(end);
y=ycpdf(2,:);
er=[ycpdf(1,:);ycpdf(3,:)];
% function f = errorbar3(x,y,er,direction,color)
f=errorbar3(x,y,er,1,linecolors(r,:));

end

legend(rois);



figure('Name','distribution of ecc','Color',[1 1 1]);
%get percentile data
for r=1:length(hists)
%     get percentile data for that area
yc = prctile(hists{r}.ecc.counteccboots,h.prctiles);

ycpdf = prctile(hists{r}.ecc.pdfeccboots,h.prctiles);


x=h.eccrange(1):h.eccbinsize:h.eccrange(end);
y=ycpdf(2,:);
er=[ycpdf(1,:);ycpdf(3,:)];
% function f = errorbar3(x,y,er,direction,color)
f=errorbar3(x,y,er,1,linecolors(r,:));


end

legend(rois);
legend 'boxoff'

% in separate loop to preserve legend
hold on;
for r=1:length(hists)
    
    ycpdf = prctile(hists{r}.ecc.pdfeccboots,h.prctiles);
x=h.eccrange(1):h.eccbinsize:h.eccrange(end);
y=ycpdf(2,:);
plot(x,y,'Color',linecolors(r,:));
end

% clip off the tail of the distribution
set(gca,'XLim',[h.eccrange(1) h.eccrange(end)-1]);

savedir = [datadir 'VisNeuroRevFigs/'];
figname = 'V1-VO14ecc';
%     % for vss sigma ploats
%     set(gca,'XLim',[0 10],'Ylim',[0 1]);
    saveas(gcf,[savedir figname '.png'],'png');
%
    plot2svg([savedir figname '.svg'],gcf,'svg');
%


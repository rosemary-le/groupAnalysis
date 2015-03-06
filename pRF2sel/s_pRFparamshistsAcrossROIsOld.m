%  script which given a .mat file containing the prf models for an roi
%  generates various histograms of a pRF parameter

% add our code to the path
% addpath('/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');
addpath('~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');



% assumes we are in directory with these variables
% controldir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/controlstestinghists/';

controldir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/controlstestinghists/';
% prosodir =
% '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/prosoparamshist1degbin/';

prosodir = controldir;


% rois to show on a single graph
rois = {
%     'lV1_all_nw'
    % 'lV2v_all_nw'
    % 'lV3v_all_nw'
    % 'lV4_all_nw'
    % 'lVO1_all_nw'
    % 'lVO2_all_nw'
    % 'lPHC1_all_nw'
    % 'lPHC2_all_nw'
    % 'rV1_all_nw'
    % 'rV2v_all_nw'
    % 'rV3v_all_nw'
    % 'rV4_all_nw'
    % 'rVO1_all_nw'
    % 'rVO2_all_nw'
    % 'rPHC1_all_nw'
    % 'rPHC2_all_nw'
    %
    % 'l_V4_fVp_001_nw.mat'
    % 'l_pfus_fVp_001_nw.mat'
    % 'l_mfus_fVp_001_nw.mat'
    % 'r_V4_fVp_001_nw.mat'
    % 'r_pfus_fVp_001_nw.mat'
    % 'r_mfus_fVp_001_nw.mat'
    % 'r_cos_pVf_001_nw'
    % 'l_cos_pVf_001_nw'
    % 'lV2d_all_nw'
    % 'lV3d_all_nw'
    % 'rV3d_all_nw'
    % 'rV2d_all_nw'
    % 'lLO1_all_nw'
%     % 'rLO1_all_nw'
       [controldir 'lV1.flippedrV1.mat']
%        [prosodir 'lV1.flippedrV1.Prosos.mat']
% 'lV1.flippedrV1.Prosos.mat'

%         % ventral
%         'lV2v.flippedrV2v.mat'
[controldir 'lV2v.flippedrV2v.mat']
%        [prosodir 'lV2v.flippedrV2v.Prosos.mat']
%         'lV3v.flippedrV3v.mat'
[controldir 'lV3v.flippedrV3v.mat']
%        [prosodir 'lV3v.flippedrV3v.Prosos.mat']
%     'lV4.flippedrV4.mat'
 [controldir 'lV4.flippedrV4.mat']
%        [prosodir 'lV4.flippedrV4.Prosos.mat']
%     'lVO1.flippedrVO1.mat'
%  [controldir 'lVO1.flippedrVO1.mat']
%        [prosodir 'lVO1.flippedrVO1.Prosos.mat']
%     'lVO2.flippedrVO2.mat'
%  [controldir 'lVO2.flippedrVO2.mat']
%        [prosodir 'lVO2.flippedrVO2.Prosos.mat']
%     'lPHC1.flippedrPHC1.mat'
% [controldir 'lPHC1.flippedrPHC1.mat']
%        [prosodir 'lPHC1.flippedrPHC1.Prosos.mat']
%     'lPHC2.flippedrPHC2.mat'
% [controldir 'lPHC2.flippedrPHC2.mat']
%        [prosodir 'lPHC2.flippedrPHC2.Prosos.mat']
    % lateral
%         'lV2d.flippedrV2d.mat'
% [controldir 'lV2d.flippedrV2d.mat']
%        [prosodir 'lV2d.flippedrV2d.Prosos.mat']
           %     'lV3d.flippedrV3d.mat'
% [controldir 'lV3d.flippedrV3d.mat']
%        [prosodir 'lV3d.flippedrV3d.Prosos.mat']
    %     'lLO1.flippedrLO1.mat'
    %     'lLO2.flippedrLO2.mat'
    %     % parietal
    %     'lV3ab.flippedrV3ab.mat'
    %     'lIPS0.flippedrIPS0.mat'
    %     'lIPS1.flippedrIPS1.mat'
    % faces ventral
%         'l_mfus.flippedr_mfus.mat
% [controldir 'l_mfus.flippedr_mfus.mat']
%        [prosodir 'l_mfus.flippedr_mfus.Prosos.mat']
%         'l_pfus.flippedr_pfus.mat'
% [controldir 'l_pfus.flippedr_pfus.mat']
%        [prosodir 'l_pfus.flippedr_pfus.Prosos.mat']
%         'l_V4_fVp.flippedr_V4_fVp.mat'
% [controldir 'l_V4_fVp.flippedr_V4_fVp.mat']
%        [prosodir 'l_V4_fVp.flippedr_V4_fVp.Prosos.mat']
    % places ventral
    %     'l_cos.flippedr_cos.mat'
%     [controldir 'l_cos.flippedr_cos.mat']
%        [prosodir 'l_cos.flippedr_cos.Prosos.mat']
%     'both_PHCanatXcospvf_nw'
% 'both_VOanatXcospvf_nw'
% 'l_antHIPPanatXcospvf_nw'
% % 'l_PHCanatXcospvf_nw'
% % 'l_VOanatXcospvf_nw'
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
% 'both_V4_all_and_pVf_001_nw'
% 'both_VO1_all_and_pVf_001_nw'
% 'both_VO2_all_and_pVf_001_nw'
% 'both_PHC1_all_and_pVf_001_nw'
% 'both_PHC2_all_and_pVf_001_nw'
% 'r_PHC_all_and_pVf_001_nw'
% 'l_PHC_all_and_pVf_001_nw'
% 'r_VO_all_and_pVf_001_nw'
% 'l_VO_all_and_pVf_001_nw'
% 'lVO1pVf.flippedrVO1pVf.mat'
% 'lVO2pVf.flippedrVO2pVf.mat'
% 'lPHC1pVf.flippedrPHC1pVf.mat'
% 'lPHC2pVf.flippedrPHC2pVf.mat'
    };



figname = 'V1-hV4';

% need better colors
linecolors = [
    
0 1 0 % green
1 0 0 %cyan
0 0 1  %blue
1 0 1% red
1 .5 1 %pink
1 .5 0  %orange

.25 0 .5 %dark purple

.5 0 .5
1 0 1
];

% param to use
% stupid naming
paramtouse = '.ecc'
% paramtouse = '.sigma'

suffix = '.norm.groupplotscis.fig';


% directory to save figures in

savedir = [controldir '/groupedacrossROIs/'];
% savedir = '~/Desktop/hists/';
% savedir =
% '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/ProsoVSControlHists1degbins/';


if ~exist(savedir)
    mkdir(savedir);
end


% do it!


figure('Name',[paramtouse ' ' figname],'Color',[1 1 1]);

for i = 1:length(rois)

%     else.  then the data could be thresholded on the fly
    
    %     open the figure and get the data
    open([rois{i} paramtouse suffix]);
    roidata=get(gcf,'UserData');
    close(gcf);
    
%     roidata = %     [29x16 double]    [1x1 struct]    [500x16 double]    [2x16 double]    [1x16 double]
    
    %     roidata{1} is individual subject data as number of voxels
%     so m subjects x n bins variable grouphist from pRFparamshist.m

    % roidata{2}% this is h struct from pRFparamshist
    %           param: 'sigma'
    %            bins: [0 24]
    %         binsize: 1
    %        threshco: 0.1000
    %       threshecc: [0.5000 11.5000]
    %     threshsigma: [0 24]
    %         savedir: [1x96 char]
    %              ci: [2.5000 97.5000]

    
%     roidata{3} is bootstrapped probability distributions, bootstrapped
%     from roidata{1}
%     m bootstraps x n bins
    
%     roidata{4} is roidata{2}.ci of roidata{3} so confidence intervals

%     roidata{5} is medians of roidata{2}


%   should have an if statement so parameters can be redefined here

% but if we just want what we have
    errorbar3(roidata{2}.bins(1):roidata{2}.binsize:roidata{2}.bins(2),roidata{5},roidata{4},1,linecolors(i,:));
    


% collected our bootstraps for ks test
 btstrps{i}=roidata{3};

 medianpdf{i}=roidata{5};





% outdated code 
% 
% 
%     plot(roidata{2}.bins(1):roidata{2}.binsize:roidata{2}.bins(2),nanmean(nroidata{1}),'Color',linecolors(i,:),'LineWidth',8);
% 
% % %     put error bars at the confidence intervals
% %     upperE = abs(nanmean(nroidata{1})'-ci(:,1));
% %     lowerE = abs(nanmean(nroidata{1})'-ci(:,2));
% %     errorbar(roidata{2}.bins(1):roidata{2}.binsize:roidata{2}.bins(2), nanmean(nroidata{1}), lowerE',upperE')
% %     
% %     show sum
%     disp('voxel proportions add up to: ');
%     sum(nanmean(nroidata{1}))
    
    hold on;
    
end


% kstest on probability distributions
% so this needs real data to work with, otherwise it just compares the
% probability values.

%can we just make a fake data set from our pdfs? 
%here are our bin values
% this is not quite right as ks test is not usefule for discrete
% distributions
% I can use the raw data in this case
bins = roidata{2}.bins(1):roidata{2}.binsize:roidata{2}.bins(2);


%for each of our samples
for p=1:2
    %for each bin
    fakedata{p}=[];
    for b=1:length(bins)
        fakedata{p}=[fakedata{p} bins(b)*ones(1,round(1000*medianpdf{p}(b)))]
    end
end
   
% 
% for k=1:size(btstrps{1},1)
%     
% [h(k) p(k) kstats(k)] = kstest2(btstrps{1}(k,:), btstrps{2}(k,:));
% end


[h p kstats] =kstest2(fakedata{1}',fakedata{2}');

% tttest on counts 
% title(['p  = ' num2str(median(p)) '  k = ' num2str(median(kstats))]);
% title(['median p value from k-s test: ' num2str(median(p))]);
ylabel('proportion of voxels');
xlabel(roidata{2}.param);
% set(gca,'XTick',roidata{2}.bins(1):roidata{2}.binsize:roidata{2}.bins(2),'XTickLabel',roidata{2}.bins(1):roidata{2}.binsize:roidata{2}.bins(2));
box off;
legend(rois);
legend 'boxoff'
% for vss sigma ploats
set(gca,'XLim',[0 10],'Ylim',[0 1]);
saveas(gcf,[savedir figname paramtouse suffix '.png'],'png');

plot2svg([savedir figname paramtouse suffix '.svg'],gcf,'svg');


% maybe want to add a bootstrapped cdf that shows what is happening with
% the k-s test?


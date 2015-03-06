% want a script which assesses the correlation between various neural
% measurements and measurements of behavior


% directory with code
% codeDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
codeDir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
addpath(genpath(codeDir));

% directory with data
% dataDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
% dataDir
% ='~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';

dataDir ='~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

% dataDir ='/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

% rois
% these need to appear as matched triplets
% control data      prosos data        roiname

rois = {
    
    'bothV1_all_nw', 'bothV1_all_nw.Prosos', 'V1';
%   'bothV2_all_nw','bothV2_all_nw.Prosos','bothV2';
%    'bothV3_all_nw','bothV3_all_nw.Prosos','bothV3';
% % %    'bothV2v_all_nw','bothV2v_all_nw.Prosos','bothV2v';
% % %     'bothV3v_all_nw','bothV3v_all_nw.Prosos','bothV3v';
%     'bothV4_all_nw','bothV4_all_nw.Prosos','bothV4';
% % %     'bothV2d_all_nw','bothV2d_all_nw.Prosos','bothV2d';
% % %   'bothV3d_all_nw','bothV3d_all_nw.Prosos','bothV3d';
% % % % % %     % ventrals
  'bothVO1_all_nw','bothVO1_all_nw.Prosos','VO1';
%   'bothVO2_all_nw','bothVO2_all_nw.Prosos','bothVO2';
% % % % % %     face rois
% %     % % face rois
%     'both_V4_fVp_001_nw','both_V4_fVp_001_nw.Prosos','bothIOG';
%    'both_pfus_fVp_001_nw','both_pfus_fVp_001_nw.Prosos','bothpFus';
%      'both_mfus_fVp_001_nw','both_mfus_fVp_001_nw.Prosos','bothmFus';
    'all_ventral_fVp_nw','all_ventral_fVp_nw.Prosos','Face Selective'; 
% 
%  'l_ventral_fVp_nw','l_ventral_fVp_nw.Prosos','lVentFaces'; 
%   'r_ventral_fVp_nw','r_ventral_fVp_nw.Prosos','rVentFaces'; 
%     
% 


%         'lV1.flippedrV1' , 'lV1.flippedrV1.Prosos'    'V1';
% %     %     %     % ventral %
% % % %                 'lV2v.flippedrV2v.mat','lV2v.flippedrV2v.Prosos.mat'         'V2v';
% % % %                 'lV2d.flippedrV2d.mat' 'lV2d.flippedrV2d.Prosos.mat'     'V2d';
% %     %     %     'lV3v.flippedrV3v.mat', 'lV3v.flippedrV3v.Prosos.mat',  'V3v';
% %     %     %     'lV3d.flippedrV3d.mat' 'lV3d.flippedrV3d.Prosos.mat' 'V3d';
% %     %     %
%         'lV2.flippedrV2','lV2.flippedrV2.Prosos' 'V2';
%         'lV3.flippedrV3' 'lV3.flippedrV3.Prosos' 'V3';
%         %
%         %
%         'lV4.flippedrV4','lV4.flippedrV4.Prosos' 'hV4';
%         'lVO1.flippedrVO1', 'lVO1.flippedrVO1.Prosos', 'VO1';
%         %
%         %
%             'lVO2.flippedrVO2' 'lVO2.flippedrVO2.Prosos' 'VO2';
% % %         %     % lateral
% % %         %
% %         %     % faces ventral
%         'l_V4_fVp.flippedr_V4_fVp', 'l_V4_fVp.flippedr_V4_fVp.Prosos' 'IOG';
%         'l_pfus.flippedr_pfus','l_pfus.flippedr_pfus.Prosos'  'pFus';
%         'l_mfus.flippedr_mfus' 'l_mfus.flippedr_mfus.Prosos' 'mFus';
%     %     %
%         %
%     %     %     %
%     %     'l_cos.flippedr_cos.mat', 'l_cos.flippedr_cos.Prosos.mat' 'CoS';
%     %
%     
% % %     % %          left and right
%     'rV1_all_nw', 'rV1_all_nw.Prosos', 'rV1';
%     'lV1_all_nw', 'lV1_all_nw.Prosos', 'lV1';
%     'rV2_all_nw', 'rV2_all_nw.Prosos', 'rV2';
%     'lV2_all_nw', 'lV2_all_nw.Prosos', 'lV2';
%     'rV3_all_nw', 'rV3_all_nw.Prosos', 'rV3';
%     'lV3_all_nw', 'lV3_all_nw.Prosos', 'lV3';
% % %             'rV2v_all_nw.mat', 'rV2v_all_nw.Prosos.mat', 'rV2v';
% % %             'lV2v_all_nw.mat', 'lV2v_all_nw.Prosos.mat', 'lV2v';
% % %             'rV3v_all_nw.mat', 'rV3v_all_nw.Prosos.mat', 'rV3v';
% % %             'lV3v_all_nw.mat', 'lV3v_all_nw.Prosos.mat', 'lV3v';
% % %             'rV2d_all_nw.mat', 'rV2d_all_nw.Prosos.mat', 'rV2d';
% % %             'lV2d_all_nw.mat', 'lV2d_all_nw.Prosos.mat', 'lV2d';
% % %             'rV3d_all_nw.mat', 'rV3d_all_nw.Prosos.mat', 'rV3d';
% % %             'lV3d_all_nw.mat', 'lV3d_all_nw.Prosos.mat', 'lV3d';
%             'rV4_all_nw', 'rV4_all_nw.Prosos', 'rV4';
%             'lV4_all_nw', 'lV4_all_nw.Prosos', 'lV4';
%             'rVO1_all_nw', 'rVO1_all_nw.Prosos', 'rVO1';
%             'lVO1_all_nw', 'lVO1_all_nw.Prosos', 'lVO1';
% % %             'rVO2_all_nw.mat', 'rVO2_all_nw.Prosos.mat', 'rVO2';
% % %             'lVO2_all_nw.mat', 'lVO2_all_nw.Prosos.mat', 'lVO2';
% % % %     % %
%             'l_V4_fVp_001_nw', 'l_V4_fVp_001_nw.Prosos', 'lIOG';
%             'r_V4_fVp_001_nw', 'r_V4_fVp_001_nw.Prosos', 'rIOG';
%             'l_pfus_fVp_001_nw', 'l_pfus_fVp_001_nw.Prosos', 'lpfus';
%             'r_pfus_fVp_001_nw', 'r_pfus_fVp_001_nw.Prosos', 'rpfus';
%             'l_mfus_fVp_001_nw', 'l_mfus_fVp_001_nw.Prosos', 'lmfus';
%             'r_mfus_fVp_001_nw', 'r_mfus_fVp_001_nw.Prosos', 'rmfus';
% % %     % %
%     %         directly compare right and left prosos and controls
%     %             'rV1_all_nw.mat', 'lV1_all_nw.mat', 'cV1';
%     %        'rV1_all_nw.Prosos.mat', 'lV1_all_nw.Prosos.mat', 'pV1';
%     %         'rV2v_all_nw.mat', 'lV2v_all_nw.mat', 'cV2v';
%     %          'rV2v_all_nw.Prosos.mat', 'lV2v_all_nw.Prosos.mat', 'pV2v';
%     %         'rV3v_all_nw.mat', 'lV3v_all_nw.mat', 'cV3v';
%     %        'rV3v_all_nw.Prosos.mat', 'lV3v_all_nw.Prosos.mat', 'pV3v';
%     %         'rV2d_all_nw.mat', 'lV2d_all_nw.mat', 'cV2d';
%     %          'rV2d_all_nw.Prosos.mat', 'lV2d_all_nw.Prosos.mat', 'pV2d';
%     %         'rV3d_all_nw.mat','lV3d_all_nw.mat', 'cV3d';
%     %         'rV3d_all_nw.Prosos.mat', 'lV3d_all_nw.Prosos.mat', 'pV3d';
%     %         'rV4_all_nw.mat', 'lV4_all_nw.mat', 'cV4';
%     %         'rV4_all_nw.Prosos.mat', 'lV4_all_nw.Prosos.mat', 'pV4';
%     %         'rVO1_all_nw.mat', 'lVO1_all_nw.mat', 'cVO1';
%     %         'rVO1_all_nw.Prosos.mat', 'lVO1_all_nw.Prosos.mat', 'pVO1';
%     %         'rVO2_all_nw.mat', 'lVO2_all_nw.mat', 'cVO2';
%     %         'rVO2_all_nw.Prosos.mat', 'lVO2_all_nw.Prosos.mat', 'pVO2';
%     %
%     %         'l_V4_fVp_001_nw.mat','r_V4_fVp_001_nw.mat', 'cIOG';
%     %          'l_V4_fVp_001_nw.Prosos.mat', 'r_V4_fVp_001_nw.Prosos.mat', 'pIOG';
%     %         'l_pfus_fVp_001_nw.mat','r_pfus_fVp_001_nw.mat', 'cpfus';
%     %          'l_pfus_fVp_001_nw.Prosos.mat', 'r_pfus_fVp_001_nw.Prosos.mat', 'ppfus';
%     %         'l_mfus_fVp_001_nw.mat', 'r_mfus_fVp_001_nw.mat', 'cmfus';
%     %         'l_mfus_fVp_001_nw.Prosos.mat', 'r_mfus_fVp_001_nw.Prosos.mat',
%     %         'pmfus';
%     %
%     
    };


% thresholds on roi and plotting
% optimally, this could be done once but its a lot of working code to fix
% threshold
h.threshco = 0;
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
    %    controls
%     '42111_MN'  %shitty retinotopy can't see v4 or vo1
    '42611_AH'
    '43011_YW'
    'adult_amk_27yo_042910'
    'adult_al_22yo_051108'
    'adult_cmb_23yo_070608'
    'adult_dy_25yo_041908'
    'adult_jw_36yo_061608'
    'adult_kll_18yo_052408'
    'adult_kw_fmri2_27yo_092910' % has largest pRFs which might be seen
%     as outlier
    'adult_mem_18yo_062608'
%                 'adult_jc_27yo_052408' measured with bars not rings &
%                 wedges
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


% % we will want to add the behavioral data to the csv file so load it up
s_CFMTdata
% loads behavior struct
% behavior =
%     controlsessions: {16x1 cell}
%     controlRawScore: [1x16 double]
%           controlPC: [1x16 double]
%          controlPC1: [1x16 double]
%          controlPC2: [1x16 double]
%          controlPC3: [1x16 double]
%           controlRT: [1x16 double]
%          controlRT1: [1x16 double]
%          controlRT2: [1x16 double]
%          controlRT3: [1x16 double]
%       prososessions: {7x1 cell}
%       prosoRawScore: [1x7 double]
%             prosoPC: [1x7 double]
%            prosoPC1: [1x7 double]
%            prosoPC2: [1x7 double]
%            prosoPC3: [1x7 double]
%             prosoRT: [1x7 double]
%            prosoRT1: [1x7 double]
%            prosoRT2: [1x7 double]
%            prosoRT3: [1x7 double]


% subsused = 'Allsubs/';
% subsused = 'ControlsOnly/';
% subsused ='subsNoKWKLLTMDY/';
% subsused = 'subsNocakwcmbmemV1varmatched/';
% subsused = 'subsNocakwcmbmemalmnV1varmatched/';
subsused = 'noMN/';

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
for r=1:size(rois,1)
    
    % load control roi
    load([dataDir char(rois(r,1)) '.mat']);
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
    
    %     add behavioral data
    for c=1:length(behavior.controlsessions)
        % could use find but session names appear multiple times will only find
        % the first
        %     compare session names
        for s=1:length(controls)
            %if they match add control behavioral data
            if strcmp(behavior.controlsessions{c},controls{s}.session)
                controls{s}.behaviorsession = behavior.controlsessions{c};
                controls{s}.PC = behavior.controlPC(c);
                controls{s}.PC1 = behavior.controlPC1(c);
                controls{s}.PC2 = behavior.controlPC2(c);
                controls{s}.PC3 = behavior.controlPC3(c);
                controls{s}.RT = behavior.controlRT(c);
                controls{s}.RT1 = behavior.controlRT1(c);
                controls{s}.RT2 = behavior.controlRT2(c);
                controls{s}.RT3 = behavior.controlRT3(c);
                
            end
        end
        
    end
    
    
    % threshold data
    th_controls = f_thresholdRMData(controls,h);
    
    
    
    
    %     clear excess variable
    clear rm
    
    %     do the same for the prosos
    load([dataDir char(rois(r,2)) '.mat']);
    prosos=rm;
    clear rm mv ECCmv;
    
    % add the behavioral data
    for p=1:length(behavior.prososessions)
        % could use find but session names appear multiple times will only find
        % the first
        %     compare session names
        for s=1:length(prosos)
            %if they match add proso behavioral data
            if strcmp(behavior.prososessions{p},prosos{s}.session)
                prosos{s}.behaviorsession = behavior.prososessions{p};
                prosos{s}.PC = behavior.prosoPC(p);
                prosos{s}.PC1 = behavior.prosoPC1(p);
                prosos{s}.PC2 = behavior.prosoPC2(p);
                prosos{s}.PC3 = behavior.prosoPC3(p);
                prosos{s}.RT = behavior.prosoRT(p);
                prosos{s}.RT1 = behavior.prosoRT1(p);
                prosos{s}.RT2 = behavior.prosoRT2(p);
                prosos{s}.RT3 = behavior.prosoRT3(p);
                
            end
        end
        
    end
    
    
    th_prosos = f_thresholdRMData(prosos,h);
    
    all_data = [th_controls th_prosos];
    
    % get stats for each roi
    %get neural measurements
    controlMedians{r} = f_ROIparamsMedians(th_controls,  h);
    prosoMedians{r} = f_ROIparamsMedians(th_prosos, h);
    All_Medians{r}.sessions = [controlMedians{r}.sessions prosoMedians{r}.sessions];
   All_Medians{r}.roiname = rois(r,3);
    All_Medians{r}.co = [controlMedians{r}.co prosoMedians{r}.co];
    All_Medians{r}.ecc = [controlMedians{r}.ecc prosoMedians{r}.ecc];
    All_Medians{r}.sigma = [controlMedians{r}.sigma prosoMedians{r}.sigma];
    All_Medians{r}.name = [controlMedians{r}.name prosoMedians{r}.name];
    All_Medians{r}.percentvoxels = [controlMedians{r}.percentvoxels prosoMedians{r}.percentvoxels];
    All_Medians{r}.size = [controlMedians{r}.size prosoMedians{r}.size];
    All_Medians{r}.origSize = [controlMedians{r}.origSize prosoMedians{r}.origSize];
%     get behavioral measures......awwwwwkward
for a=1:length(all_data)
    All_Medians{r}.behsessions{a}= all_data{a}.behaviorsession;
    All_Medians{r}.PC(a) = all_data{a}.PC;
    All_Medians{r}.PC1(a) = all_data{a}.PC1;
    All_Medians{r}.PC2(a) = all_data{a}.PC2;
    All_Medians{r}.PC3(a) = all_data{a}.PC3;
    All_Medians{r}.RT(a) = all_data{a}.RT;
    All_Medians{r}.RT1(a) = all_data{a}.RT1;
    All_Medians{r}.RT2(a) = all_data{a}.RT2;
    All_Medians{r}.RT3(a) = all_data{a}.RT3;
end
    
end


% concatenate the roi names in the order used
figname=reshape(char(rois(:,3))',1,[]);
% remove spaces
figname=regexprep(figname,' ','');


%so we want neural measures roisize, ecc, varexp, sigma vs
% behavioral measures, PC, PC3, RT, RT3, which is 16 scatter matrices with
% all rois

% params to correlate
field1 = 'sigma';
field2 = 'PC';

[PCxSigmaStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% save figure
saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.png'],'png');
% save as svg
plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');


% params to correlate
field1 = 'co';
field2 = 'PC';

[PCxCoStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname  '.png'],'png');
% save as svg
plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');

% % params to correlate
% field1 = 'size';
% field2 = 'PC';
% 
% [PCxSizeStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % save as svg
% plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');


% params to correlate
field1 = 'origSize';
field2 = 'PC';

[PCxSizeStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% save as svg
plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');


% params to correlate
field1 = 'ecc';
field2 = 'PC';

[PCxEccStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname  '.png'],'png');
% save as svg
plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');

% % params to correlate
% field1 = 'RT';
% field2 = 'sigma';
% 
% [PCxSigmaStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % save as svg
% plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% 
% % params to correlate
% field1 = 'RT';
% field2 = 'co';
% 
% [PCxCoStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % save as svg
% plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% 
% % params to correlate
% field1 = 'RT';
% field2 = 'size';
% saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.png'],'png');
% % save as svg
% plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% 
% 
% [PCxSizeStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % save as svg
% plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% 
% 
% % params to correlate
% field1 = 'RT';
% field2 = 'origSize';
% saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.png'],'png');
% % save as svg
% plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% 
% 
% [PCxSizeStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % save as svg
% plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% 
% % params to correlate
% field1 = 'RT';
% field2 = 'ecc';
% 
% [PCxEccStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % save as svg
% plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% % 
% % 
% % % params to correlate
% % field1 = 'PC3';
% % field2 = 'sigma';
% % 
% % [PCxSigmaStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% % saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % % save as svg
% % plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% % 
% % % params to correlate
% % field1 = 'PC3';
% % field2 = 'co';
% % 
% % [PCxCoStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% % saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % % save as svg
% % plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% % 
% % % params to correlate
% % field1 = 'PC3';
% % field2 = 'size';
% % 
% % [PCxSizeStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% % saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % % save as svg
% % plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% % 
% % % params to correlate
% % field1 = 'PC3';
% % field2 = 'ecc';
% % 
% % [PCxEccStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% % saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % % save as svg
% % plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% % 
% % % params to correlate
% % field1 = 'RT3';
% % field2 = 'sigma';
% % 
% % [PCxSigmaStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% % saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % % save as svg
% % plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% % 
% % % params to correlate
% % field1 = 'RT3';
% % field2 = 'co';
% % 
% % [PCxCoStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% % saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname  '.png'],'png');
% % % save as svg
% % plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% % 
% % % params to correlate
% % field1 = 'RT3';
% % field2 = 'size';
% % 
% % [PCxSizeStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% % saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname  '.png'],'png');
% % % save as svg
% % plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% % 
% % % params to correlate
% % field1 = 'RT3';
% % field2 = 'ecc';
% % 
% % [PCxEccStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% % saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % % save as svg
% % plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% % 
% % 
% % % params to correlate
% % field1 = 'size';
% % field2 = 'co';
% % 
% % [PCxEccStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% % saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % % save as svg
% % plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% % 
% % 
% % % params to correlate
% % field1 = 'sigma';
% % field2 = 'co';
% % 
% % [PCxEccStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% % saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % % save as svg
% % plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% % 
% % 
% % 
% % % params to correlate
% % field1 = 'sigma';
% % field2 = 'size';
% % 
% % [PCxEccStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% % saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % % save as svg
% % plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% % 
% % 
% 
% % params to correlate
% field1 = 'sigma';
% field2 = 'origSize';
% 
% [PCxEccStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % save as svg
% plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% 
% 
% % params to correlate
% field1 = 'ecc';
% field2 = 'sigma';
% 
% [PCxEccStats] = f_makeNxBscatterplots(All_Medians,field1,field2);
% saveas(gcf,[h.saveDir 'NeuroBehavCorr.' field1 'x' field2  '.' figname '.png'],'png');
% % save as svg
% plot2svg([h.saveDir 'NeuroBehavCorr.' field1 'x' field2 '.' figname '.svg'],gcf,'svg');
% 
% 
% 


% given rois data and thresholds, generate a csv file that has the
% following structure

%group      subject roi size  roi var exp prf ecc prf sigma
%control    name    roi(3)    numbers .....
%proso


% standard bookkeeping stuff which should be its own script at this point

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
%         '42111_MN'
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
% 
% % ventral %
% % %         'lV2v.flippedrV2v.mat','lV2v.flippedrV2v.Prosos.mat'         'V2vFlippedLeft';
% % %     'lV3v.flippedrV3v.mat', 'lV3v.flippedrV3v.Prosos.mat',  'V3vFlippedLeft';
% %  'lV4.flippedrV4.mat','lV4.flippedrV4.Prosos.mat' 'V4';
% % 'lVO1.flippedrVO1.mat', 'lVO1.flippedrVO1.Prosos.mat', 'VO1';
% %  'lVO2.flippedrVO2.mat' 'lVO2.flippedrVO2.Prosos.mat' 'VO2';
% %     % lateral
% % % 'lV2d.flippedrV2d.mat' 'lV2d.flippedrV2d.Prosos.mat' 'lV2dFlippedLeft';
% % % 'lV3d.flippedrV3d.mat' 'lV3d.flippedrV3d.Prosos.mat' 'V3dFlippedLeft';
% %     % faces ven tral
% % 'l_mfus.flippedr_mfus.mat' 'l_mfus.flippedr_mfus.Prosos.mat' 'mFus';
% % 'l_pfus.flippedr_pfus.mat','l_pfus.flippedr_pfus.Prosos.mat' 'pFus';
% % 'l_V4_fVp.flippedr_V4_fVp.mat', 'l_V4_fVp.flippedr_V4_fVp.Prosos.mat' 'IOG';
% 
% %  'l_cos.flippedr_cos.mat', 'l_cos.flippedr_cos.Prosos.mat' 'CoSplacesflippedleft';
% 
        'bothV1_all_nw.mat', 'bothV1_all_nw.Prosos.mat', 'bothV1';
  'bothV2_all_nw.mat','bothV2_all_nw.Prosos.mat','bothV2';
   'bothV3_all_nw.mat','bothV3_all_nw.Prosos.mat','bothV3';
% % %    'bothV2v_all_nw','bothV2v_all_nw.Prosos','bothV2v';
% % % %     'bothV3v_all_nw','bothV3v_all_nw.Prosos','bothV3v';
    'bothV4_all_nw.mat','bothV4_all_nw.Prosos.mat','bothV4';
% % % % %     'bothV2d_all_nw','bothV2d_all_nw.Prosos','bothV2d';
% % % % %   'bothV3d_all_nw','bothV3d_all_nw.Prosos','bothV3d';
% % % % % % % %     % ventral
  'bothVO1_all_nw.mat','bothVO1_all_nw.Prosos.mat','bothVO1';
% %   'bothVO2_all_nw.mat','bothVO2_all_nw.Prosos.mat','bothVO2';
% % % % % % %     face rois
% %     'both_V4_fVp_001_nw.mat','both_V4_fVp_001_nw.Prosos.mat','bothIOG';
% %  'both_pfus_fVp_001_nw.mat','both_pfus_fVp_001_nw.Prosos.mat','bothpFus';
% % 'both_mfus_fVp_001_nw.mat','both_mfus_fVp_001_nw.Prosos.mat','bothmFus';
'all_ventral_fVp_nw.mat','all_ventral_fVp_nw.Prosos.mat','bothVentFaces';     
'both_cos_pVf_001_nw.mat', 'both_cos_pVf_001_nw.Prosos.mat','bothCos';

%  'rV1_all_nw.mat', 'rV1_all_nw.Prosos.mat', 'rV1';
%     'lV1_all_nw.mat', 'lV1_all_nw.Prosos.mat', 'lV1';
%     'rV2_all_nw.mat', 'rV2_all_nw.Prosos.mat', 'rV2';
%     'lV2_all_nw.mat', 'lV2_all_nw.Prosos.mat', 'lV2';
%     'rV3_all_nw.mat', 'rV3_all_nw.Prosos.mat', 'rV3';
%     'lV3_all_nw.mat', 'lV3_all_nw.Prosos.mat', 'lV3';
%     'rV4_all_nw.mat', 'rV4_all_nw.Prosos.mat', 'rV4';
%     'lV4_all_nw.mat', 'lV4_all_nw.Prosos.mat', 'lV4';
%     'rVO1_all_nw.mat', 'rVO1_all_nw.Prosos.mat', 'rVO1';
%     'lVO1_all_nw.mat', 'lVO1_all_nw.Prosos.mat', 'lVO1';
%     'r_ventral_fVp_nw.mat','r_ventral_fVp_nw.Prosos.mat', 'rFaces';
%     'l_ventral_fVp_nw.mat','l_ventral_fVp_nw.Prosos.mat', 'lFaces';
%     'r_cos_pVf_001_nw.mat', 'r_cos_pVf_001_nw.Prosos.mat', 'rCoS';
%     'l_cos_pVf_001_nw.mat', 'l_cos_pVf_001_nw.Prosos.mat', 'lCoS';
};



% thresholds on roi and plotting
% optimally, this could be done once but its a lot of working code to fix
% threshold
h.threshco = 0;
h.threshecc = [0 15];
h.threshsigma = [0 30];
h.minvoxelcount = 0; %minimum number of voxels in roi

% make a savedirectory

% should be datadir FullAnalysis / threshold / SubjectsUsed / ROI/ 
threshstring =  ['co' num2str(h.threshco) ...
    '.ecc' num2str(h.threshecc(1)) '_' num2str(h.threshecc(2)) '.sig' ...
    num2str(h.threshsigma(1)) '_' num2str(h.threshsigma(2)) '.minvox' num2str(h.minvoxelcount) ];

subsused = 'Allsubs/';
% subsused ='subsNoKWKLLTMDY/';
% subsused = 'subsNocakwcmbmemV1varmatched/';

% roiname = [char(rois(1,3)) '/'];
% save atlevel above individual rois
h.saveDir = [dataDir 'FullAnalysis/' threshstring '/' subsused];


% we will want to add the behavioral data to the csv file so load it up
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


% open the text file for naming
datafilename = [dataDir 'csvsummaryfiles/' threshstring '.ColHemisFaces.data.csv'];
fileID = fopen(datafilename,'w');
% write header
fprintf(fileID,'group,roi,hemi,subject,roi size,roi var exp,prf ecc,prf sigma,CFMTScore,Score1,Score2,Score3,CFMTRT,RT1,RT2,RT3\n');




% for each roi
for r=1:size(rois,1)
% load rms from controls into workspace
load([dataDir char(rois(r,1))]);

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


% add the behavioral data
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
%             want to specify a hemisphere.  in the case where it is
%             actually both hemispheres this will be wrong but won't be
%             using this column in the anova anyway
            
            
        end
    end
    
end


% load proso roi
load([dataDir char(rois(r,2))]);
prosos = rm;

% unload excess variables
clear mv rm ECCmv;



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






% threshold the data
th_controls = f_thresholdRMData(controls,h);

th_prosos = f_thresholdRMData(prosos,h);

% now make the csv files with the data summaries
% th_controls{1}
%     name: 'lV1_all_nw'
%          vt: 'Gray'
%     session: 'MN'
%      coords: [1x1633 single]
%     indices: [1633x1 double]
%          co: [1x1633 double]
%      sigma1: [1x1633 double]
%      sigma2: [1x1633 double]
%       theta: [1x1633 double]
%        beta: [1x1633 double]
%          x0: [1x1633 double]
%          y0: [1x1633 double]
%          ph: [1x1633 double]
%         ecc: [1x1633 double]
%  the roi name is given by rois(r,3)

%    do the controls
for c =1:length(th_controls)
    %     print line in file
    % 'group,roi,hemi,subject,roi size,roi var exp,prf ecc,prf sigma,score,sc1,sc2,sc3,rt,rt1,rt2,rt3\n'
    fprintf(fileID,'controls,%s,%s,%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g\n',rois{r,3},th_controls{c}.name(1),...
        th_controls{c}.session,length(th_controls{c}.coords),...
        median(th_controls{c}.co),median(th_controls{c}.ecc),median(th_controls{c}.sigma1),...
        th_controls{c}.PC,th_controls{c}.PC1,th_controls{c}.PC2,th_controls{c}.PC3,...
        th_controls{c}.RT,th_controls{c}.RT1,th_controls{c}.RT2,th_controls{c}.RT3);
    
end
% then the prosos
for c =1:length(th_prosos)
    %     print line in file
    % 'group,roi,hemi,subject,roi size,roi var exp,prf ecc,prf sigma\n'
    fprintf(fileID,'prosos,%s,%s,%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g\n',rois{r,3},th_prosos{c}.name(1),...
        th_prosos{c}.session,length(th_prosos{c}.coords),...
        median(th_prosos{c}.co),median(th_prosos{c}.ecc),median(th_prosos{c}.sigma1),...
        th_prosos{c}.PC,th_prosos{c}.PC1,th_prosos{c}.PC2,th_prosos{c}.PC3,...
        th_prosos{c}.RT,th_prosos{c}.RT1,th_prosos{c}.RT2,th_prosos{c}.RT3);
    
end
%
end

fclose(fileID);


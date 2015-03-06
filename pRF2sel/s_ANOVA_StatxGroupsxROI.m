% would really like to do a repeated measures anova where group and roi are
% factors and then test for interactions.  one complication is that I don't
% have all subjects for all rois and matlab can't handle missing data.  one
% thing I can do is a two wan anova with roi and group as factors.  this is
% not repeated measures so it doesn't take into account the way the factors
% covary across the rois.  at the very least it will get the data
% organized and then maybe I can do the same analysis in R.

% the function is
% [p,table,stats,terms] = anovan(y,group,param,val)

% where you specify the inputs as follows

% y = [52.7 57.5 45.9 44.5 53.0 57.0 45.9 44.0]';
% g1 = [1 2 1 2 1 2 1 2]; 
% g2 = {'hi';'hi';'lo';'lo';'hi';'hi';'lo';'lo'}; 
% g3 = {'may';'may';'may';'may';'june';'june';'june';'june'}; 

% and called as 
% p = anovan(y,{g1 g2 g3})
% p =
%   0.4174
%   0.0028
%   0.9140

% where the p-value is for each grouping factor

% to get interactions use the parameter 'model', 'interaction'
% 
% p = anovan(y,{g1 g2 g3},'model','interaction')
% p =
%   0.0347      X1
%   0.0048      X2
%   0.2578      X3
%   0.0158      X1*X2
%   0.1444      X1*X3
%   0.5000      X2*X3


% so ours is 2 way with some measure lets say size, and then the groups are
% subjecttype and roi

% so we set our list of subjects and rois and thresholds


% directory with code
% codeDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
codeDir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/';
addpath(genpath(codeDir));

% directory with data
% dataDir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
% dataDir
% ='~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';

dataDir ='~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

% dataDir =
% '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

% rois
% these need to appear as matched triplets
% control data      prosos data        roiname
rois = {

           'bothV1_all_nw.mat', 'bothV1_all_nw.Prosos.mat', 'bothV1';
  'bothV2_all_nw.mat','bothV2_all_nw.Prosos.mat','bothV2';
   'bothV3_all_nw.mat','bothV3_all_nw.Prosos.mat','bothV3';
%    'bothV2v_all_nw','bothV2v_all_nw.Prosos','bothV2v';
% % %     'bothV3v_all_nw','bothV3v_all_nw.Prosos','bothV3v';
    'bothV4_all_nw.mat','bothV4_all_nw.Prosos.mat','bothV4';
% % %     'bothV2d_all_nw','bothV2d_all_nw.Prosos','bothV2d';
% % %   'bothV3d_all_nw','bothV3d_all_nw.Prosos','bothV3d';
% % % % % % %     % ventral
  'bothVO1_all_nw.mat','bothVO1_all_nw.Prosos.mat','bothVO1';
%   'bothVO2_all_nw.mat','bothVO2_all_nw.Prosos.mat','bothVO2';
% % % % % %     face rois
%     'both_V4_fVp_001_nw.mat','both_V4_fVp_001_nw.Prosos.mat','bothIOG';
%  'both_pfus_fVp_001_nw.mat','both_pfus_fVp_001_nw.Prosos.mat','bothpFus';
% 'both_mfus_fVp_001_nw.mat','both_mfus_fVp_001_nw.Prosos.mat','bothmFus';
      'both_cos_pVf_001_nw.mat', 'both_cos_pVf_001_nw.Prosos.mat','bothCos';
    };


% thresholds on roi and plotting
% optimally, this could be done once but its a lot of working code to fix
% threshold
h.threshco = 0;
h.threshecc = [0 30];
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
%     '42111_MN'
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
                'adult_jc_27yo_052408'
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





subsused = 'Allsubs/';
% subsused ='subsNoKWKLLTMDY/';
% subsused = 'subsNocakwcmbmemV1varmatched/';

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



% variables to store grouping variables and data
ROI = {};
group = {};

% for each roi
for r=1:size(rois,1)
    
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
    
    % get stats for each roi
    %get the stats here
    controlMedians{r} = f_ROIparamsMedians(th_controls,  h);
    prosoMedians{r} = f_ROIparamsMedians(th_prosos, h);
    All_Medians{r}.sessions = [controlMedians{r}.sessions prosoMedians{r}.sessions];
    All_Medians{r}.co = [controlMedians{r}.co prosoMedians{r}.co];
    All_Medians{r}.ecc = [controlMedians{r}.ecc prosoMedians{r}.ecc];
    All_Medians{r}.sigma = [controlMedians{r}.sigma prosoMedians{r}.sigma];
    All_Medians{r}.name = [controlMedians{r}.name prosoMedians{r}.name];
    All_Medians{r}.percentvoxels = [controlMedians{r}.percentvoxels prosoMedians{r}.percentvoxels];
    All_Medians{r}.size = [controlMedians{r}.size prosoMedians{r}.size];
end



% % build pairwise correlation matrix
% [sizerho sizepval]=f_makeAcrossROIsFigures(All_Medians,h,rois,'size');
% [sigmarho sigmapval]=f_makeAcrossROIsFigures(All_Medians,h,rois,'sigma');
% [eccrho eccpval]=f_makeAcrossROIsFigures(All_Medians,h,rois,'ecc');
% [corho copval]=f_makeAcrossROIsFigures(All_Medians,h,rois,'co')

% when finished, do anovan

% so let's construct our variables for the anova
ysize = [];
yco = [];
yecc=[];
ysigma=[];
group = [];
roi = [];

groupnames = {'controls','prosos'};
% for each ROI assumes there are the same number of rois for controls and
% prosos
for r=1:length(controlMedians)
    ysize = [ysize controlMedians{r}.size];
    yco = [yco controlMedians{r}.co];
    yecc = [yecc controlMedians{r}.ecc];
    ysigma= [ysigma controlMedians{r}.sigma];

        group = [group repmat(groupnames(1),1,length(controlMedians{r}.size))];

    
    roi = [roi repmat(rois(r,3),1,length(controlMedians{r}.size))];
end


% do the same thing for prosos

for r=1:length(prosoMedians)
    ysize = [ysize prosoMedians{r}.size];
    yco = [yco prosoMedians{r}.co];
    yecc = [yecc prosoMedians{r}.ecc];
    ysigma= [ysigma prosoMedians{r}.sigma];

        group = [group repmat(groupnames(2),1,length(prosoMedians{r}.size))];

    
    roi = [roi repmat(rois(r,3),1,length(prosoMedians{r}.size))];
end


% [p,table,stats,terms] = anovan(y,group,param,val)
% 
% 
% [p table stats terms] = anovan(ysize,{group, roi},'model','interaction');
% 
% [p table stats terms] = anovan(yco,{group, roi},'model','interaction');
% 
% 
% [p table stats terms] = anovan(yecc,{group, roi},'model','interaction');
% 
% 
% [p table stats terms] = anovan(ysigma,{group, roi},'model','interaction');


% should be a mixed anova with the parameter estimates repeated across rois
% and then a fixed betwween factor which is the group.  I'm still a little
% mystefied about the independence of the repeated measure.  does it make
% sense to treat V1 and V2 as independent measures.  need to think more
% about t he logic of the anova
% function [SSQs, DFs, MSQs, Fs,Ps]=mixed_between_within_anova(X,suppress_output)
% Inputs:
% 
% X: design matrix with four columns (future versions may allow different input configurations)
% so x is nx4 where n is the total amount of data so ROI*subjects
%     - first column  (i.e., X(:,1)) : all dependent variable values
%     - second column (i.e., X(:,2)) : between-subjects factor (e.g., subject group) level codes (ranging from 1:L where 
%         L is the # of levels for the between-subjects factor)
%     - third column  (i.e., X(:,3)) : within-subjects factor (e.g., condition/task) level codes (ranging from 1:L where 
%         L is the # of levels for the within-subjects factor)
%     - fourth column (i.e., X(:,4)) : subject codes (ranging from 1:N where N is the total number of subjects)
% 

% build the design matrix
% subject labels
Xsubs = repmat([1:length(h.sessions)]',size(rois,1),1);

% group labels
grplabels = 2*ones(length(h.sessions),1);
% make control group have label 1
grplabels(1:length(rmindex))=1;
% make into the group column
Xgrps = repmat(grplabels,size(rois,1),1);

% roi labels
% this is dumb
Xrois = [];
for r=1:size(rois,1)
    Xrois = [Xrois; r*ones(length(h.sessions),1)];
end


% dependent variables
Xsigma =[];
Xsize = [];
Xecc = [];
Xvarexp = [];

for r=1:size(rois,1)
   Xsigma = [Xsigma; controlMedians{r}.sigma'; prosoMedians{r}.sigma'];
   Xsize = [Xsize; controlMedians{r}.size'; prosoMedians{r}.size'];
   Xecc = [Xecc; controlMedians{r}.ecc'; prosoMedians{r}.ecc'];
   Xvarexp = [Xvarexp; controlMedians{r}.co'; prosoMedians{r}.co'];
end

% [SSQs, DFs, MSQs, Fs,Ps]=mixed_between_within_anova(X,suppress_output)
% Inputs:
% 
% X: design matrix with four columns (future versions may allow different input configurations)
% so x is nx4 where n is the total amount of data so ROI*subjects
%     - first column  (i.e., X(:,1)) : all dependent variable values
%     - second column (i.e., X(:,2)) : between-subjects factor (e.g., subject group) level codes (ranging from 1:L where 
%         L is the # of levels for the between-subjects factor)
%     - third column  (i.e., X(:,3)) : within-subjects factor (e.g., condition/task) level codes (ranging from 1:L where 
%         L is the # of levels for the within-subjects factor)
%     - fourth column (i.e., X(:,4)) : subject codes (ranging from 1:N
%     where N 

fprintf('mixed 2 way anova for sigma');

[sigSSQs, sigDFs, sigMSQs, sigFs, sigPs]= ...
    mixed_between_within_anova([Xsigma Xgrps Xrois Xsubs]);



fprintf('mixed 2 way anova for size');
[sizeSSQs, sizeDFs, sizeMSQs, sizeFs, sizePs]= ...
    mixed_between_within_anova([Xsize Xgrps Xrois Xsubs]);



fprintf('mixed 2 way anova for ecc');
[sigSSQs, sigDFs, sigMSQs, sigFs, sigPs]= ...
    mixed_between_within_anova([Xecc Xgrps Xrois Xsubs]);



fprintf('mixed 2 way anova for varexp');
[sigSSQs, sigDFs, sigMSQs, sigFs, sigPs]= ...
    mixed_between_within_anova([Xvarexp Xgrps Xrois Xsubs]);

% suppress_output: defaults to 0 (meaning it displays the ANOVA table as output). If you don't want to display the table,
%  just pass in a non-zero value
% 
% Outputs:
% 
% SSQs, DFs, MSQs, Fs, Ps : Sum of squares, degrees of freedom, mean squares, F-values, P-values. All the same values 
%  that are shown in the table if you choose to display it. All will be cell matrices. Values within will be in the same 
%  order that they are shown in the output table.
% 




% for mixed linear effects modeling need to output as csv for analysis in R
% make file name
% h.saveDir = [dataDir 'FullAnalysis/' threshstring subsused];
filename = [h.saveDir 'Alldata.txt'];
% 
% % open file with that name
% fileID = fopen(filename,'w');
% 
% % for each roi
% % going to assume same number of rois in both groups
% for r=1:length(controlMedians)
% %    read in data from controls for that roi
%     for c=1:length(controlMedians{r}.name)
%         hemiroiname= controlMedians{r}.name{c};
%         sessionname = controlMedians{r}.sessions{c};
%         %  group  roi hemisphere subject size co ecc sigma
%         fprintf(fileID,'controls,%s,%s,%s,%g,%g,%g,%g\n',...
%             rois{r,3},hemiroiname,sessionname,...
%             controlMedians{r}.size(c), controlMedians{r}.co(c),...
%             controlMedians{r}.ecc(c), controlMedians{r}.sigma(c))
%     end  
% %     read in data from prosos for that roi
%     for c=1:length(prosoMedians{r}.name)
%         hemiroiname= prosoMedians{r}.name{c};
%         sessionname = prosoMedians{r}.sessions{c};
%         %  group  roi hemisphere subject size co ecc sigma
%         fprintf(fileID,'prosos,%s,%s,%s,%g,%g,%g,%g\n',...
%             rois{r,3},hemiroiname,sessionname,...
%             prosoMedians{r}.size(c), prosoMedians{r}.co(c),...
%             prosoMedians{r}.ecc(c), prosoMedians{r}.sigma(c))
%     end  
% end
% 
% status=fclose(fileID);
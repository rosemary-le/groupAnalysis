% have a number of size vs ecc plots that we would like to recreate across
% rois


% the first is the random effects within group line plus cis plot


% path to .mat files

% add our code to the path
addpath('/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');

% to get roi size from a plot we would do

% assumes we are in directory with these variables
cd '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';

savedir = '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/sizeXeccplotsVSS1sigma/';

savedir = '~/Desktop/vssfacesXecc/';

if ~exist(savedir)
    mkdir(savedir)
end

%
prosodir = 'sizeXeccplotsProsos/';
% controldir = 'sizeXeccplots/';

controldir = 'sizeXeccplotsVSS/';

% rois to use

roistoload = {
%     'bothV1_all_nw.pRF_submedbstpci.fig'
%     % % % ventral
%     'bothV2v_all_nw.pRF_submedbstpci.fig'
%     'bothV3v_all_nw.pRF_submedbstpci.fig'
%     'bothV4_all_nw.pRF_submedbstpci.fig'
%     'bothVO1_all_nw.pRF_submedbstpci.fig'
%     'bothVO2_all_nw.pRF_submedbstpci.fig'
    % % 'bothV3ab_all_nw.pRF_submedbstpci.fig'
    % % 'bothLO1_all_nw.pRF_submedbstpci.fig'
    % % 'bothLO2_all_nw.pRF_submedbstpci.fig'
    % % 'bothVO1_all_nw.pRF_submedbstpci.fig'
    % 'rV1_all_nw.pRF_submedbstpci.fig'
    % 'lV1_all_nw.pRF_submedbstpci.fig'
    % % % ventral
    % 'rV2v_all_nw.pRF_submedbstpci.fig'
    % 'lV2v_all_nw.pRF_submedbstpci.fig'
    % 'rV3v_all_nw.pRF_submedbstpci.fig'
    % 'lV3v_all_nw.pRF_submedbstpci.fig'
    % 'rV4_all_nw.pRF_submedbstpci.fig'
    % 'lV4_all_nw.pRF_submedbstpci.fig'
    % % 'rVO1_all_nw.pRF_submedbstpci.fig'
    % % 'lVO1_all_nw.pRF_submedbstpci.fig'
    % % 'rVO2_all_nw.pRF_submedbstpci.fig'
    % % 'lVO2_all_nw.pRF_submedbstpci.fig'
    % % % lateral
    % 'rV2d_all_nw.pRF_submedbstpci.fig'
    % 'lV2d_all_nw.pRF_submedbstpci.fig'
    % 'rV3d_all_nw.pRF_submedbstpci.fig'
    % 'lV3d_all_nw.pRF_submedbstpci.fig'
    % % % 'rLO1_all_nw.pRF_submedbstpci.fig'
    % % % 'lLO1_all_nw.pRF_submedbstpci.fig'
    % % % 'rLO2_all_nw.pRF_submedbstpci.fig'
    % % % 'lLO2_all_nw.pRF_submedbstpci.fig'
    % % % % parietal
    % 'rV3ab_all_nw.pRF_submedbstpci.fig'
    % 'lV3ab_all_nw.pRF_submedbstpci.fig'
    % % 'rIPS0_all_nw.pRF_submedbstpci.fig'
    % % 'lIPS0_all_nw.pRF_submedbstpci.fig'
    % % 'rIPS1_all_nw.pRF_submedbstpci.fig'
    % % 'lIPS1_all_nw.pRF_submedbstpci.fig'
    % % % faces ventral
    %
    'l_mfus_fVp_001_nw.pRF_ffx_sergefit.fig'
    'l_pfus_fVp_001_nw.pRF_ffx_sergefit.fig'
    'l_V4_fVp_001_nw.pRF_ffx_sergefit.fig'
% %     
%     'r_mfus_fVp_001_nw.pRF_ffx_sergefit.fig'
%     'r_pfus_fVp_001_nw.pRF_ffx_sergefit.fig'    
%     'r_V4_fVp_001_nw.pRF_ffx_sergefit.fig'
    % % places ventral
    % 'l_cos_pVf_001_nw.pRF_submedbstpci.fig'
    % 'r_cos_pVf_001_nw.pRF_submedbstpci.fig'
    };

% make plots

savename = 'rightfaces';

% need better colors
linecolors = [
    
0 1 0 % green
0 1 1 %cyan
0 0 1  %blue
1 0 0% red
1 .5 1 %pink
1 .5 0  %orange

.25 0 .5 %dark purple

.5 0 .5
1 0 1
];

prosoOrControls = 'c';

    %     make figure
figure('Name','size vs ecc across rois','Color',[1 1 1]);
    hold on;


for p=1:length(roistoload)
    %     get data
    switch(prosoOrControls)
        case('p')
            open([prosodir roistoload{p}])
            roidata=get(gcf,'UserData');
            close(gcf);
        case('c')
            open([controldir roistoload{p}])
            roidata=get(gcf,'UserData');
            close(gcf);
    end
    
    
    % for each figure of that type you can use get user data

% data{2}
% 
% ans = 
% 
%       xfit: [2x1 double]
%       yfit: [2x1 double]
%          x: [23x1 double]
%          y: [23x1 double]
%     ysterr: [23x1 double]
%        roi: [1x1 struct]
% 
    hold on;
      errorbar(roidata{2}.x,roidata{2}.y,roidata{2}.ysterr,'ko');
    plot(roidata{2}.x,roidata{2}.y,'ko',...
        'MarkerFaceColor',linecolors(p,:));
%     plot(roidata{2}.xfit,roidata{2}.yfit','k','LineWidth',2);
    
    plot(roidata{2}.x,roidata{2}.y,'Color',linecolors(p,:));
    
    legend(roistoload);
    legend 'boxoff';
    plot(0:.2:6,0:.2:6,'k--');
    

%     
%     
%     %     means and cis
%     %     errorbar(prosos{1}{1}.eccbins, prosos{7},
%     %     prosos{8}(:,1),prosos{8}(:,2))
%     
%     %     plot control individual data
%     scatter(controls{3},controls{4},'go');
%     %     means and cis
%     %     errorbar(controls{1}{1}.eccbins, controls{7},
%     %     controls{8}(:,1),controls{8}(:,2))
%     
%     %     plot proso individual data
%     scatter(prosos{3},prosos{4},'ro');
    
    xlabel('eccentricity in degrees');
    ylabel('sigma in degrees');
    set(gca,'XLim',[0 6.5],'YLim',[0 10]);
    
end

saveas(gcf,[savedir savename '.png'],'png');

plot2svg([savedir savename '.svg'],gcf,'svg');

% 
% 
% %   can we choose a subset of controls who have data that matches the
% %   prosos in the early visual areas and produce some sanity in the result?
% % for example, look at rV1
% 
% for p=1:length(roistoload)
%     
%     open([prosodir roistoload{p}])
%     prosos=get(gcf,'UserData');
%     close(gcf);
%     
%     open([controldir roistoload{p}])
%     controls=get(gcf,'UserData');
%     close(gcf);
%     
%     
%     colororder = [
%         0.00  0.00  1.00
%         0.00  0.50  0.00
%         1.00  0.00  0.00
%         0.00  0.75  0.75
%         0.75  0.00  0.75
%         0.75  0.75  0.00
%         0.25  0.25  0.25
%         0.75  0.25  0.25
%         0.95  0.95  0.00
%         0.25  0.25  0.75
%         0.75  0.75  0.75
%         0.00  1.00  0.00
%         0.76  0.57  0.17
%         0.54  0.63  0.22
%         0.34  0.57  0.92
%         1.00  0.10  0.60
%         0.88  0.75  0.73
%         0.10  0.49  0.47
%         0.66  0.34  0.65
%         0.99  0.41  0.23
%         ];
%     
%     % get the sessions
%     sessions={};
%     for s = 1:length(controls{1})
%         sessions{s}=controls{1}{s}.session;
%     end
%     
%     figure('Name',roistoload{p},'Color',[1 1 1]);
%     set(gcf,'DefaultAxesColorOrder',colororder);
%     plot(0.5:.5:11.5,controls{2},'LineWidth',6)
%     legend(sessions,'Location','EastOutside');
% end
% 
% % if we look at this we can see that some subjects have larger rfs than
% % others.  the most frequent offenders have some good retinotopies.  the
% % most obvious are dy bad ret really, and jc who has a different retinotopy
% % than everyone else.  after that probably KLL and maybe KW and RB.  all
% % three are good retinotopies.
% % so you would have to go through the sessions in each one to find those
% % subjects
% % sessions'
% %
% % ans =
% %
% %     '42611_AH'
% %     '43011_YW'
% %     'adult_amk_27yo_042910'
% %     'adult_cmb_23yo_070608'
% %     'adult_dy_25yo_041908'
% %     'adult_jw_36yo_061608'
% %     'adult_kll_18yo_052408'
% %     'adult_kw_fmri2_27yo_092910'
% %     'adult_mem_18yo_062608'
% %     'adult_jc_27yo_052408'
% %     'adult_rb_22yo_101908'
% %     'adult_ca_22yo_061908'
% %
% sessionstouse = {
%     '42111_MN'
%         '42611_AH'
%     '43011_YW'
%     'adult_amk_27yo_042910'
%     'adult_cmb_23yo_070608'
%             'adult_dy_25yo_041908'
%     'adult_jw_36yo_061608'
%     'adult_kll_18yo_052408'
%     'adult_kw_fmri2_27yo_092910'
%     'adult_mem_18yo_062608'
%         'adult_jc_27yo_052408'
%         'adult_rb_22yo_101908'
%     'adult_acg_39yo_012008'
%     'adult_ca_22yo_061908'
%     '41711_TM'
%     '42811_TA'
%     };
% 
% for p=1:length(roistoload)
%     %     get data
%     open([prosodir roistoload{p}])
%     prosos=get(gcf,'UserData');
%     close(gcf);
%     
%     open([controldir roistoload{p}])
%     controls=get(gcf,'UserData');
%     close(gcf);
%     
%     %     make figure
%     figure('Name',roistoload{p},'Color',[1 1 1]);
%     hold on;
%     
%     
%     %     means and cis
%     %     errorbar(prosos{1}{1}.eccbins, prosos{7},
%     %     prosos{8}(:,1),prosos{8}(:,2))
%     
%     %     plot control individual data
%     %     first let's get the  sesions that exist for this roi
%     sessions={};
%     for s = 1:length(controls{1})
%         sessions{s}=controls{1}{s}.session;
%     end
%     
%     %     then plot each subject that you want to use
%     for k=1:length(sessionstouse)
%         if sum(strcmp(sessionstouse{1},sessions))==1
%             %             get row with data
%             sdata = find(strcmp(sessionstouse{k},sessions));
%             %             sometimes the subject you want to use won't have this roi so
%             %             skip
%             if ~isempty(sdata)
%                 scatter(controls{1}{1}.eccbins,controls{2}(sdata,:),'go');
%             end
%         end
%     end
%     %     means and cis
%     %     errorbar(controls{1}{1}.eccbins, controls{7},
%     %     controls{8}(:,1),controls{8}(:,2))
%     
%     %     plot proso individual data
%     scatter(prosos{3},prosos{4},'ro');
%     
%     xlabel('eccentricity in degrees');
%     ylabel('sigma in degrees');
%     
%     set(gca,'XLim',[0 10],'YLim',[0 10]);
% end
% 
% 
% 
% 

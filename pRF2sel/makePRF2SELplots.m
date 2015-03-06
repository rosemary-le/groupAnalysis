
roitouse = {
%     'lIPS0_nw.09-Jan-2014.mat'
%     'lIPS1_nw.09-Jan-2014.mat'
%     'lIPS2_nw.10-Jan-2014.mat'
%     'lIPS3_nw.10-Jan-2014.mat'
%     'lIPS4_nw.10-Jan-2014.mat'
%     'lLO1_nw.09-Jan-2014.mat'
%     'lLO2_nw.09-Jan-2014.mat'
%     'lPHC1_and_pVf_001_nw.10-Jan-2014.mat'
%     'lPHC1_and_pVo_001_nw.10-Jan-2014.mat'
%     'lPHC1_nw.09-Jan-2014.mat'
%     'lPHC2_and_pVf_001_nw.10-Jan-2014.mat'
%     'lPHC2_and_pVo_001_nw.10-Jan-2014.mat'
%     'lPHC2_nw.09-Jan-2014.mat'
%     'lTO1_nw.09-Jan-2014.mat'
%     'lTO2_nw.09-Jan-2014.mat'
%     'lV1_nw.09-Jan-2014.mat'
%     'lV2d_nw.09-Jan-2014.mat'
%     'lV2v_nw.09-Jan-2014.mat'
%     'lV3ab_nw.09-Jan-2014.mat'
%     'lV3d_nw.09-Jan-2014.mat'
%     'lV3v_nw.09-Jan-2014.mat'
%     'lV4_nw.09-Jan-2014.mat'
%     'lVO1_and_pVf_001_nw.06-Jan-2014.mat'
%     'lVO1_and_pVf_001_nw.10-Jan-2014.mat'
%     'lVO1_and_pVo_001_nw.10-Jan-2014.mat'
%     'lVO1_nw.09-Jan-2014.mat'
%     'lVO2_and_pVf_001_nw.10-Jan-2014.mat'
%     'lVO2_and_pVo_001_nw.10-Jan-2014.mat'
%     'lVO2_nw.09-Jan-2014.mat'
%     'l_V4_fVp_001_nw.10-Jan-2014.mat'
%     'l_cos_pVf_001_nw.06-Jan-2014.mat'
%     'l_cos_pVf_001_nw.10-Jan-2014.mat'
%     'l_mfus_fVp_001_nw.10-Jan-2014.mat'
%     'l_pfus_fVp_001_nw.10-Jan-2014.mat'
%     'rIPS0_nw.09-Jan-2014.mat'
%     'rIPS1_nw.09-Jan-2014.mat'
%     'rIPS2_nw.09-Jan-2014.mat'
%     'rIPS3_nw.09-Jan-2014.mat'
%     'rIPS4_nw.09-Jan-2014.mat'
%     'rLO1_nw.09-Jan-2014.mat'
%     'rLO2_nw.09-Jan-2014.mat'
%     'rPHC1_and_pVf_001_nw.10-Jan-2014.mat'
%     'rPHC1_and_pVo_001_nw.10-Jan-2014.mat'
%     'rPHC1_nw.09-Jan-2014.mat'
%     'rPHC2_and_pVf_001_nw.10-Jan-2014.mat'
%     'rPHC2_and_pVo_001_nw.10-Jan-2014.mat'
%     'rPHC2_nw.09-Jan-2014.mat'
%     'rTO1_nw.09-Jan-2014.mat'
%     'rTO2_nw.09-Jan-2014.mat'
%     'rV1_nw.06-Jan-2014.mat'
%     'rV1_nw.09-Jan-2014.mat'
%     'rV2d_nw.09-Jan-2014.mat'
%  'rV2v_nw.06-Jan-2014.mat'
%     'rV2v_nw.09-Jan-2014.mat'
%     'rV3ab_nw.09-Jan-2014.mat'
%     'rV3d_nw.09-Jan-2014.mat'
%     'rV3v_nw.09-Jan-2014.mat'
%     'rV4_nw.09-Jan-2014.mat'
%     'rVO1_and_pVf_001_nw.10-Jan-2014.mat'
%     'rVO1_and_pVo_001_nw.10-Jan-2014.mat'
%     'rVO1_nw.09-Jan-2014.mat'
 %   'rVO2_and_pVf_001_nw.10-Jan-2014.mat'
%     'rVO2_and_pVo_001_nw.10-Jan-2014.mat'
%     'rVO2_nw.09-Jan-2014.mat'
%     'r_V4_fVp_001_nw.06-Jan-2014.mat'
%     'r_V4_fVp_001_nw.10-Jan-2014.mat'
%     'r_anthipp_pVf_001_nw.10-Jan-2014.mat'
%    'r_cos_pVf_001_nw.10-Jan-2014.mat'
%     'r_mfus_fVp_001_nw.10-Jan-2014.mat'
%     'r_pfus_fVp_001_nw.10-Jan-2014.mat'
% 'both_PHCanatXcospvf_nw.24-Mar-2014.mat'
% 'both_VOanatXcospvf_nw.24-Mar-2014.mat'
'both_antHIPPanatXcospvf_nw.24-Mar-2014.mat'
    };


for r=1:length(roitouse)
    load(roitouse{r});
    
    savedir = mv{1}.roi.name;
    % check to see if the directory exists if not make it
    
    if ~exist(savedir)
        mkdir(savedir);
    end
    
    % set threshold and bounds for roi analysis
    rmvarthresh=.1;
    
    eccbounds = [0 14];
    
    % move this out to compute contrast
    % compute face V places contrast
    % contrast name
    cname = 'facesVplaces';
    % condition names in contrast
    condnames1 = {'child', 'man'};
    condnames2 = {'indoor', 'outdoor'};
    % compute contrast and add to mv.cname
    mv = mvContrastCompute(mv,cname,condnames1,condnames2);
    
    % % % % % % % % % % % Eccentricity GLM
    
    % compute fovea vs per contrast
    % contrast name
    cname = 'foveaVperiphery';
    % condition names in contrast
    condnames1 = {'face fov', 'plc fov'};
    condnames2 = {'face per', 'plc per'};
    % compute contrast and add to mv.cname
    ECCmv = mvContrastCompute(ECCmv,cname,condnames1,condnames2);
    
%    compute faces vs. places contrast
    cname = 'facesVplaces';
        % condition names in contrast
    condnames1 = {'face fov', 'face per'};
    condnames2 = {'plc fov', 'plc per'};
    % compute contrast and add to mv.cname
    ECCmv = mvContrastCompute(ECCmv,cname,condnames1,condnames2);
    
    
    
    
    
%     fovea vs periphery vs rm from ecc glm
    
    % make some scatterplots
    cname = 'foveaVperiphery';
    mvVSrmPlot(ECCmv,rm,'tval','ypos',cname,rmvarthresh,eccbounds)
    title('ecc glm');
    mvVSrmPlot(ECCmv,rm,'tval','co',cname,rmvarthresh,eccbounds)
    title('ecc glm');
    mvVSrmPlot(ECCmv,rm,'tval','ecc',cname,rmvarthresh,eccbounds)
    title('ecc glm');
    mvVSrmPlot(ECCmv,rm,'tval','sigma',cname,rmvarthresh,eccbounds)
    title('ecc glm');
    
%    faces vs places vs rm from ecc glm
     cname='facesVplaces';
    mvVSrmPlot(ECCmv,rm,'tval','ypos',cname,rmvarthresh,eccbounds)
    title('ecc glm');
    mvVSrmPlot(ECCmv,rm,'tval','co',cname,rmvarthresh,eccbounds)
    title('ecc glm');
    mvVSrmPlot(ECCmv,rm,'tval','ecc',cname,rmvarthresh,eccbounds)
    title('ecc glm');
    mvVSrmPlot(ECCmv,rm,'tval','sigma',cname,rmvarthresh,eccbounds)
    title('ecc glm');
    
%     faces vs places vs rm from loc glm
      cname='facesVplaces';
    mvVSrmPlot(mv,rm,'tval','ypos',cname,rmvarthresh,eccbounds)
    title('loc glm');
    mvVSrmPlot(mv,rm,'varexp','co',cname,rmvarthresh,eccbounds)
    title('loc glm');
    mvVSrmPlot(mv,rm,'tval','co',cname,rmvarthresh,eccbounds)
    title('loc glm');
    mvVSrmPlot(mv,rm,'tval','ecc',cname,rmvarthresh,eccbounds)
    title('loc glm');
    mvVSrmPlot(mv,rm,'tval','sigma',cname,rmvarthresh,eccbounds)
    title('loc glm');
    
    % close all;
    
    
    
    
    % individual scatterplots
    
    
    
    % wonder about the relationship between eccentricity and coherence in the
    % prfs.   seems like there is a tendency for larger more eccentric prfs to
    % have a better fit.  it makes sense that smaller rfs would be fit more
    % noisily if they are below the resolution of the stimulus, or largerly
    % outside or larger than the whole field of view.  but seems like there
    % should be a sweet spot. you could always plot x0 vs y0 and then grid and
    % show the average variance explained inside that grid.
    
    
    % need bins
    % this is reversed so that the matrix gets filled like an image
    gridbins = [14:-2:-14];
    
    % can generate one of these for each subject and then add them together
    
    % move xy locations to nearest point in grid
    for s=1:length(rm)
        %     go through x and ys and bin them
        %     for each voxel
        for i=1:length(rm{s}.x0)
            %         find closest point in grid and round to that
            [difx indx] = min(abs(gridbins-rm{s}.x0(i)));
            rm{s}.binx0(i) = gridbins(indx);
            [dify indy] = min(abs(gridbins-rm{s}.y0(i)));
            rm{s}.biny0(i) = gridbins(indy);
        end
    end
    
    % find all voxels corresponding to each point in the grid and take the
    % average of their coherence
    
    % grid to hold values
    vf = zeros(length(gridbins));
    
    % lets do fixed effects (lot of loops!)
    
    %     pick a point in the grid
    for i=1:length(gridbins)
        for j=1:length(gridbins)
            %         variable to collect our coherences from across subjects for a
            %         point
            coh = [];
            %             find all the values that correspond to it in a
            %             subject
            for s=1:length(rm)
                %             find indices to x location in grid
                [xx xi] = find(rm{s}.binx0==gridbins(i));
                % find indices to y location in grid
                [yy yi] = find(rm{s}.biny0==gridbins(j));
                % find intersection of indices
                voxi = intersect(xi,yi);
                % store coherences
                coh = [coh rm{s}.co(voxi)];
            end
            %         take median of coherences and assign to that point in the grid
            %         if no receptive fields in that area then set that point to 0
            if isempty(coh)
                vf(j,i)=0;
                meanvf(j,i)=0;
            else
                vf(j,i)=nanmedian(coh);
                meanvf(j,i)=nanmean(coh);
            end
        end
    end
    
    figure('Name','median variance explained across visual field','Color',[1 1 1]);
    imagesc(fliplr(vf))
    colorbar;
    title(mv{1}.roi.name);
    set(gca,'XTick',1:length(gridbins),'YTick',1:length(gridbins),...
        'XTickLabel',gridbins,'YTickLabel',fliplr(gridbins));
%     
%     figure('Name','average variance explained across visual field','Color',[1 1 1]);
%     imagesc(fliplr(meanvf))
%     colorbar;
%     title(mv{1}.roi.name);
%     set(gca,'XTick',1:length(gridbins),'YTick',1:length(gridbins),...
%         'XTickLabel',gridbins,'YTickLabel',fliplr(gridbins));
%     
%     
    
    %then hist on the y
    
    % the find i,j and fill grid
    
    % then imagesc
    
    
    
    
    
    % histograms
    
    
    
end
% script for combining the .mat files for subjects across hemispheres.  

% path tocode
addpath('~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/');


% assumes we are in directory with these variables
% cd '/Volumes/biac4-kgs/Projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/RMECCLOCfiles/';
savedir = '~/projects/retinotopy/adult_ecc_karen/Analyses/pRF2sel/pRF2sel15degFiles/';

cd(savedir);

% list of rois to combine rghtROI leftROI combinedROI
rois ={
    % % %     controls
    'r_V4_fVp_001_nw','r_pfus_fVp_001_nw','r_mfus_fVp_001_nw','rh_faces';
    'l_V4_fVp_001_nw','l_pfus_fVp_001_nw','l_mfus_fVp_001_nw','lh_faces';
    % % %    prosos
    'r_V4_fVp_001_nw.Prosos','r_pfus_fVp_001_nw.Prosos',...
        'r_mfus_fVp_001_nw.Prosos','rh_faces.Prosos';
    'l_V4_fVp_001_nw.Prosos','l_pfus_fVp_001_nw.Prosos',...
        'l_mfus_fVp_001_nw.Prosos','lh_faces.Prosos';
     
    };



% make the files
for r = 1:size(rois,1)
    
%   load face rois
    iog=load([rois{r,1} '.mat']);
    pfus=load([rois{r,2} '.mat']);
    mfus=load([rois{r,3} '.mat']);
    
%   now need to combine them within subjects (not just double the number of
%   rois.  this means that we treat roi as a fixed effect but subject as a
%   random effect
%     
    for rs=1:length(iog.rm)
        iogsessions{rs} = iog.rm{rs}.session;
    end
    
    for rs=1:length(pfus.rm)
        pfussessions{rs} = pfus.rm{rs}.session;
    end
    
    for rs=1:length(pfus.rm)
        mfussessions{rs} = pfus.rm{rs}.session;
    end
    
%     then find the number of unique session names

    allsessions = unique([iogsessions pfussessions mfussessions]);
    
%     go through unique sessions and combine rois across ventral stream
    for s=1:length(allsessions)
%       every subject will have at least one roi
        if length(find(strcmp(allsessions(s),[rightsessions leftsessions])))==2
%             then combine them
            rtrm = right.rm{strcmp(allsessions(s),[rightsessions])};
            lftrm = left.rm{strcmp(allsessions(s),[leftsessions])};
%             now combine
            rm{s}.coords = [rtrm.coords lftrm.coords]; %roi coordinates
            rm{s}.indices = [rtrm.indices; lftrm.indices]; %roi indices
            rm{s}.name = [rtrm.name 'and' lftrm.name]; %roi name
            rm{s}.curScan = 1;
            rm{s}.vt = rtrm.vt; %view
            rm{s}.co = [rtrm.co lftrm.co]; % variance explained by model
            rm{s}.sigma1 = [rtrm.sigma1 lftrm.sigma1];%sigma
            rm{s}.sigma2 = [rtrm.sigma2 lftrm.sigma2];%sigma2
            rm{s}.theta = [rtrm.theta lftrm.theta];%theta
            rm{s}.beta = [rtrm.beta; lftrm.beta];%beta
            rm{s}.x0 = [rtrm.x0 lftrm.x0];%x position of prf center
            rm{s}.y0 = [rtrm.y0 lftrm.y0]; %y position of prf center
            rm{s}.ph = [rtrm.ph lftrm.ph]; %angle of prf center
            rm{s}.ecc = [rtrm.ecc lftrm.ecc];%eccentricity of prf center
            rm{s}.session = rtrm.session;%subject
        else
            %just set rm{s} to be the right or left depending
            %if its not the right one
            if ~isempty(find(strcmp(allsessions(s),rightsessions)))
             rm{s}=right.rm{strcmp(allsessions(s),rightsessions)};
            %then it must be the left one
            else
              rm{s}=left.rm{strcmp(allsessions(s),leftsessions)};
                
            end
        end
        
    end

%     save the rm file
    save([savedir rois{r,3} '.mat'], 'rm');
    clear rm right left  rightsessions leftsessions;

end



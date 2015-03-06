% counter separate from rois
counter =1;

% for each subject
for s=1:length(retsessions)
    % for s=10
    % get retmodel data
    %     cd to ret session
    cd([sessiondir retsessions{s}]);
    %     open hidden view
    if strcmp(vw,'Gray')
        hV =initHiddenGray(retdts{s},[],roi);
    else
        hV=initHiddenInplane(retdts(s),[],roi);
    end
    
%     would like to get the surface area as well as the volume of each roi.
%     in order to do that we need to load a mesh and use
%       [area smoothedArea] = roiSurfaceArea(vw, roi, msh)
    
    
    %     check to see if roi exists
    if isempty(hV.ROIs)
        disp(['no roi for this subject ' retsessions{s}]);
    else
% % % % % % % % % % % % % % %         
% % % % % % % % % % get prf fit parameters
        hV=rmSelect(hV,2,retmodels(s));
        hV=rmLoadDefault(hV);
        %     get ret params
        rm{counter}=rmGetParamsFromROI(hV);
        rm{counter}.session = retsessions{s};
        
% % % % % % % % % % % % % % % % % 
% % % % % % % % % % get localizer glm for roi
        %     if ret and sel data are in same session we can just use the one we
        %     have
        if ~strcmp(LOCsessions{s},retsessions{s})
            clear hV;
            cd([sessiondir LOCsessions{s}]);
            
            %     open hidden view
            if strcmp(vw,'Gray')
                hV =initHiddenGray(GLMdataTypes,[],roi);
            else
                hV=initHiddenInplane(GLMdataTypes,[],roi);
            end
        end
        %     now get the mv struct for that roi
        [hV mv{counter}] = get_mv(hV,GLMdataTypes,LOCscans(s,:),1);
        %     [h mv]=get_mvstruct(dt,scan,roi,v,cmprss)
        
   % % % % % % % % % % % % % % % % % 
% % % % % % % % % % get ecc glm for roi
        %     if loc and ecc data are in same session we can just use the one we
        %     have     
         if ~strcmp(LOCsessions{s},ECCsessions{s})
            clear hV;
            cd([sessiondir ECCsessions{s}]);
            
            %     open hidden view can use same data type
            if strcmp(vw,'Gray')
                hV =initHiddenGray(GLMdataTypes,[],roi);
            else
                hV=initHiddenInplane(GLMdataTypes,[],roi);
            end
        end
        %     now get the mv struct for that roi
        [hV ECCmv{counter}] = get_mv(hV,GLMdataTypes,ECCscans(s,:),1);
        %     [h mv]=get_mvstruct(dt,scan,roi,v,cmprss)
        
        
        counter=counter+1;
        
    end
end






% let's save the three structs as a .mat file and then write some plotting
% functions that use it

% check to see if the save directory exists

% if not make it

% save the file
% 
% 
% 
% 
% % now we can save this huge struct or do some kind of analysis on it.
% 
% % mv
% %         trials: [1x1 struct]
% %            params: [1x1 struct]
% %            coords: [3x311 single]
% %           tSeries: [396x311 single]
% %           voxData: [4-D double]
% %               roi: [1x1 struct]
% %     coordsAnatomy: [3x311 double]
% %     coordsInplane: [3x311 double]
% %                ui: [1x1 struct]
% %               glm: [1x1 struct]
% %              amps: [311x8 double]
% %            roiInd: [1x311 double]
% 
% % rm
% %    coords: [3x311 single]
% %     indices: [311x1 double]
% %        name: 'l_cos_pVf_001_nw'
% %     curScan: 1
% %          vt: 'Gray'
% %          co: [1x311 double]
% %      sigma1: [1x311 double]
% %      sigma2: [1x311 double]
% %       theta: [1x311 double]
% %        beta: [311x3 double]
% %          x0: [1x311 double]
% %          y0: [1x311 double]
% %          ph: [1x311 double]
% %         ecc: [1x311 double]
% %     session: '42111_MN'
% 
% % some questions
% 
% % how do the two model fits relate to one another (i.e. is the variance
% % explained by the glm, related to variance explained by ret
% 
% figure('Name','variance explained by models','Color',[1 1 1]);
% for i=1:length(mv)
%     %     for i=5
%     %     in the cases where the data comes from separate sessions, sometimes
%     %     you can end up with fewer indices than coordinates.  the indices are
%     %     found by taking the intersection of the roi coordinates with the
%     %     volume coordinates, and sometimes there are roi coordinates that
%     %     don't exist on the volume.  I don't know why that is, so it makes me
%     %     nervous, since all the data are referenced to a shared volume.  this
%     %     problem can be dealt with by finding the shared volume indices
%     %     between the rois, but I would like to know why this error happens.
%     %     [shared values, index to a, index to b] = intersectCols(a,b)
%     %             [c ia ib] = intersectCols(mv{i}.roiInd', rm{i}.indices);
%     %     scatter(mv{i}.glm.varianceExplained(ia), rm{i}.co(ib),'ro');
%     %     hold on;
%     %     or we could skip such subjects
%     hold on
%     if(length(mv{i}.glm.varianceExplained)==length(rm{i}.indices))
%         scatter(mv{i}.glm.varianceExplained, rm{i}.co,'bo');
%     else
%         disp(['skipping ' rm{i}.session 'as mv and rm have different number of indices']);
%         
%     end
%     
% end
% % end
% box off;
% xlabel('variance explained glm');
% ylabel('variance explained ret');
% 
% 
% 
% % how does selectivity relate to pRF fits?   for a given roi, does
% % increased selectivity mean less retinotopy?  is the selectivity related
% % to the eccentricity or size or xy location of the pRF?
% %  Localizer condition numbers
% %   1  'blank'
% %   2  'child'
% %   3  'man'
% %   4  'indoor'
% %   5  'outdoor'
% %   6  'car'
% %   7  'AbstObj'
% %   8  'text'
% %   9  'noise'
% 
% % ecc bias conditions
% % 1 faces fovea
% % 2 faces periphery
% % 3 places fovea
% % 4 places periphery
% 
% 
% % contrast name
% cname = 'facesVplaces';
% 
% 
% % for each subject
% for s=1:length(mv)
%     % contrast we want to make
%     condnames1 = {'child', 'man'};
%     condnums1 = [];
%     condnames2 = {'indoor', 'outdoor'};
%     condnums2 = [];
%     % find the condition numbers
% %     need to subtract 1 from condition names position in list since the
% %     first condition (blank) isn't counted in the contrast function
%     for i=1:length(condnames1)
%         condnums1 = [condnums1 find(strcmp(mv{s}.trials.condNames,condnames1(i)))-1];
%     end
%     for i=1:length(condnames2)
%         condnums2 = [condnums2 find(strcmp(mv{s}.trials.condNames,condnames2(i)))-1];
%     end
% %     compute the contrast
%     [mv{s}.(cname).stat2, mv{s}.(cname).ces2, mv{s}.(cname).TVal2, mv{s}.(cname).units2]= ...
%         glm_contrast(mv{s}.glm, condnums1, condnums2, 'size', size(mv{s}.coords) );
% %     here is the way the function is called from the gui
% % 	mapVol(:,:,slice) = glm_contrast(model, active, control, ...
% % 									   'size', viewGet(vw, 'sliceDims'), opts);
%     
%      
% end
% 
% figure('Name','Eccentricity vs. Selectivity','Color',[1 1 1]);
% % let's try plotting eccentricity against selectivity
% for i=1:length(mv)
% %     skip subject with indexing error
%     if(length(rm{i}.ecc)==length(mv{i}.(cname).TVal2))
%     scatter(rm{i}.ecc,mv{i}.(cname).TVal2,'ro');
%     hold on;
%     end
% end
% box off;
% title([cname ' tvalues']);
% xlabel('eccentricity in degrees');
% ylabel('t value selectivity');
% 
% 
% % % % do localizer vs. sigma
% figure('Name','Sigma vs. Selectivity','Color',[1 1 1]);
% % let's try plotting eccentricity against selectivity
% for i=1:length(mv)
% %     skip subject with indexing error
%     if(length(rm{i}.sigma1)==length(mv{i}.(cname).TVal2))
%     scatter(rm{i}.sigma1,mv{i}.(cname).TVal2,'ro');
%     hold on;
%     end
% end
% box off;
% title([cname ' tvalues']);
% xlabel('pRF size in degrees');
% ylabel('t value selectivity');
% 
% 
% 
% 
% 
% 
% % do this as subplots
% 
% figure('Name','Eccentricity vs. Selectivity Individuals','Color',[1 1 1]);
% % let's try plotting eccentricity against selectivity
% [m n] = subplotsize(length(mv));
% for i=1:length(mv)
%     subplot(m,n,i);
%     %     skip subject with indexing error
%     if(length(rm{i}.ecc)==length(mv{i}.(cname).TVal2))
%         scatter(rm{i}.ecc,mv{i}.(cname).TVal2,'ro');
%         hold on;
%     end
%     box off;
%     title([cname ' tvalues']);
%     xlabel('eccentricity in degrees');
%     ylabel('t value selectivity');
% end
% 
% 
% 
% figure('Name','Eccentricity vs. Selectivity Individuals','Color',[1 1 1]);
% % let's try plotting eccentricity against selectivity
% [m n] = subplotsize(length(mv));
% for i=1:length(mv)
%     subplot(m,n,i);
%     %     skip subject with indexing error
%     if(length(rm{i}.ecc)==length(mv{i}.(cname).TVal2))
%         scatter(rm{i}.ecc,mv{i}.(cname).stat2,'ro');
%         hold on;
%     end
%     box off;
%     title([cname ' tvalues']);
%     xlabel('eccentricity in degrees');
%     ylabel('logp value selectivity');
% end
% 
% 
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % Eccentricity GLM
% 
% 
% % contrast name
% ECCcname = 'foveaVperiphery';
% 
% 
% % for each subject
% for s=1:length(mv)
%     % contrast we want to make
%     ECCcondnames1 = {'face fov', 'plc fov'};
%     ECCcondnums1 = [];
%     ECCcondnames2 = {'face per', 'plc per'};
%     ECCcondnums2 = [];
%     % find the condition numbers
% %     need to subtract 1 from condition names position in list since the
% %     first condition (blank) isn't counted in the contrast function
%     for i=1:length(ECCcondnames1)
%         ECCcondnums1 = [ECCcondnums1 find(strcmp(ECCmv{s}.trials.condNames,ECCcondnames1(i)))-1];
%     end
%     for i=1:length(ECCcondnames2)
%         ECCcondnums2 = [ECCcondnums2 find(strcmp(ECCmv{s}.trials.condNames,ECCcondnames2(i)))-1];
%     end
% %     compute the contrast
%     [ECCmv{s}.(ECCcname).stat2, ECCmv{s}.(ECCcname).ces2, ECCmv{s}.(ECCcname).TVal2, ECCmv{s}.(ECCcname).units2]= ...
%         glm_contrast(ECCmv{s}.glm, ECCcondnums1, ECCcondnums2, 'size', size(ECCmv{s}.coords) );
% %     here is the way the function is called from the gui
% % 	mapVol(:,:,slice) = glm_contrast(model, active, control, ...
% % 									   'size', viewGet(vw, 'sliceDims'), opts);
%     
%      
% end
% 
% figure('Name','Eccentricity vs. Selectivity','Color',[1 1 1]);
% % let's try plotting eccentricity against selectivity
% for i=1:length(ECCmv)
% %     skip subject with indexing error
%     if(length(rm{i}.ecc)==length(ECCmv{i}.(ECCcname).TVal2))
%     scatter(rm{i}.ecc,ECCmv{i}.(ECCcname).TVal2,'ro');
%     hold on;
%     end
% end
% box off;
% title([ECCcname ' tvalues']);
% xlabel('eccentricity in degrees');
% ylabel('t value selectivity');
% 
% 
% % do this as subplots
% 
% figure('Name','Eccentricity vs. Selectivity Individuals','Color',[1 1 1]);
% % let's try plotting eccentricity against selectivity
% [m n] = subplotsize(length(ECCmv));
% for i=1:length(ECCmv)
%     subplot(m,n,i);
%     %     skip subject with indexing error
%     if(length(rm{i}.ecc)==length(ECCmv{i}.(ECCcname).TVal2))
%         scatter(rm{i}.ecc,ECCmv{i}.(ECCcname).TVal2,'ro');
%         hold on;
%     end
%     box off;
%     title([ECCcname ' tvalues']);
%     xlabel('eccentricity in degrees');
%     ylabel('t value selectivity');
% end
% % 
% 
% 
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % %   category selectivity vs fov and periphery
% 
% 
% 
% figure('Name','Eccentricity vs. Selectivity','Color',[1 1 1]);
% % let's try plotting eccentricity against selectivity
% for i=1:length(ECCmv)
% %     skip subject with indexing error
%     if(length(rm{i}.ecc)==length(ECCmv{i}.(ECCcname).TVal2))
%        scatter(mv{i}.(cname).TVal2,ECCmv{i}.(ECCcname).TVal2,'ro');
%     hold on;
%     end
% end
% box off;
% title([ECCcname ' tvalues']);
%     ylabel('fov v periphery');
%     xlabel('face v place ');
% 
% % do this as subplots
% 
% figure('Name','Eccentricity vs. Selectivity Individuals','Color',[1 1 1]);
% % let's try plotting eccentricity against selectivity
% [m n] = subplotsize(length(ECCmv));
% for i=1:length(ECCmv)
%     subplot(m,n,i);
%     %     skip subject with indexing error
%     if(length(mv{i}.(cname).TVal2)==length(ECCmv{i}.(ECCcname).TVal2))
%         scatter(mv{i}.(cname).TVal2,ECCmv{i}.(ECCcname).TVal2,'ro');
%         hold on;
%     end
%     box off;
%     title([ECCcname ' tvalues']);
%     ylabel('fov v periphery');
%     xlabel('face v place ');
% end
% % 
% 
% 
% 

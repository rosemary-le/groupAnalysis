function mvVSrmPlot(mv, rm, mvVar, rmVar, cname, rmvarthresh, eccbounds)

% scatter mv rv
% arguments
% mv struct
% rm struct
% mv variable
% rm variable
% contrast name

% since everything comes from the same glm, shouldn't have to do this



figure('Name', [mvVar ' vs. ' rmVar],'Color',[1 1 1]);
% let's try plotting eccentricity against selectivity
for i=1:length(mv)
    
    %     skip subject with indexing error
    if(length(rm{i}.ecc)==length(mv{i}.(cname).TVal2))
        %         since data are now all in the same session vectors of parameters
        %         should be the same length
        
        
        % suppose we wanted to threshold by variance explained in the prf?
        %         pRF variance explained threshold
        rmvarvox = find(rm{i}.co>rmvarthresh);
        %         pRF eccentricity boundary threshold
        eccboundvox = find(rm{i}.ecc>eccbounds(1) & rm{i}.ecc<eccbounds(2));
        %         intersection of good voxels
        voxtouse = intersect(rmvarvox,eccboundvox);
        
        % because the data have been upsampled to the grey matter, each inplane
        % voxel will have multiple values on the gray.  if nearest neighbor was
        % used for the sampling these will show up as duplicate t-values or
        % duplicate variance explained
        % for now getting rid of this and only using it to assign the labels
        
        switch(mvVar)
            case('tval')
                %                 mvVals = unique(mv{i}.(cname).TVal2);
                mvVals = mv{i}.(cname).TVal2(voxtouse);
                yl = [cname ' t values'];
                
            case('varexp')
                %                 mvVals = unique(mv{i}.glm.varianceExplained);
                mvVals = mv{i}.glm.varianceExplained(voxtouse);
                yl = 'var exp by glm';
        end
        
        %         get subset of mvVals  I'm really not sure how this is supposed to
        %         work.  voxtouse is all voxels which passed a threshold but the
        %         indexing is broken by taking the unique ones first
        %             mvVals = mvVals(voxtouse);
        
        
        
        
        %         get rm values to plot
        switch(rmVar)
            case('ecc')
                rmVals = rm{i}.ecc;
                xl = 'ecc in degrees';
            case('co')
                rmVals = rm{i}.co;
                xl = 'var exp by pRF';
            case('sigma')
                rmVals = rm{i}.sigma1;
                xl = 'pRF sigma in degrees';
            case('xpos')
                rmVals = rm{i}.x0;
                xl = 'x pos of pRF center in degrees';
            case('ypos');
                rmVals = rm{i}.y0;
                xl= 'y pos of pRF center in degrees';
        end
        %         ger subset of rmVals
        rmVals = rmVals(voxtouse);
        %         check that rm and mv values have same length
        if length(rmVals)==length(mvVals)
            %             plot
            scatter(rmVals,mvVals,'ro');
        else
            fprintf('skipping %s because mv and rm vectors are different lengths\n',...
                mv{i}.params.sessionCode);
        end
        hold on;
    end
end
box off;
title(mv{1}.roi.name);
xlabel(xl);
ylabel(yl);
% axis equal;
end
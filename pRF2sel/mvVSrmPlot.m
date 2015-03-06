function mvVSrmPlot(mv, rm, mvVar, rmVar, cname, rmvarthresh, eccbounds)

% scatter mv rv
% arguments
% mv struct
% rm struct
% mv variable
% rm variable
% contrast name




figure('Name', [mvVar ' vs. ' rmVar],'Color',[1 1 1]);
% let's try plotting eccentricity against selectivity
for i=1:length(mv)
    %     skip subject with indexing error
    if(length(rm{i}.ecc)==length(mv{i}.(cname).TVal2))
        
        
        
%       find voxels above thresholds
% variance explained by prf
        rmvarvox = find(rm{i}.co>rmvarthresh);
%         pr eccentricity
        eccboundvox = find(rm{i}.ecc>eccbounds(1) & rm{i}.ecc<eccbounds(2));
%         voxels we want to plot
        voxtouse = intersect(rmvarvox,eccboundvox);

%         get values to plot from mv

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


function [rho pval]=makeAcrossROIsFigures(All_medians,h,measure)
% want a matrix where every column is an roi and rows are subjects
% since rois have both left and right for each subject need to have one for
% left and right and can concatenate after

L_roidatamatrix = nan(length(h.sessions),size(All_Medians,2));
R_roidatamatrix = nan(length(h.sessions),size(All_Medians,2));
% convert h.sessions to shortened names returned by f_ROIparamsMedians
% this sad little hack is probably adding more confusion in my code than
% clarity in my figures.  you should probably just be done at the point of
% making the figure.
for s=1:length(h.sessions)
    if length(h.sessions{s})>4
        
        if length(h.sessions{s})<10
            subjects{s} = h.sessions{s}(7:end);
        else
            subjects{s}=h.sessions{s}(7:9);
        end
    end
end





% for each roi that we actually got
for r=1:size(All_Medians,2)
    % this matrix will have many nans but is easy for bookkeeping
    %     for every subject
    for s=1:length(h.sessions)
        %   this is for the case where left and right rois are in same rm struct
        %     does roi exist for this subject in either hemisphere
        roindx = find(strcmp(subjects{s},All_Medians{r}.sessions));
        
        %         if at least one exists assign to left or right hemisphere
        if ~isempty(roindx)
            for hemi = roindx
                %             get first letter of roi (so hacky!)
                side= All_Medians{r}.name{hemi}(1);
                
                switch(side)
                    %            if its l assign it to the left side
                    case('l')
                        L_roidatamatrix(s,r)=All_Medians{r}.(measure)(hemi);
                        %                    if its r assign it to the right side
                    case('r')
                        R_roidatamatrix(s,r)=All_Medians{r}.(measure)(hemi);
                end
            end
        end
        
    end
    
end

% concatenate
% data collapsed across hemisphere
All_roidatamatrix = [L_roidatamatrix; R_roidatamatrix];
% compare hemispheres
LvsR_roidatamatrix = [L_roidatamatrix R_roidatamatrix];

% get the correlation matrix for the data
[rho, pVal] = corr(All_roidatamatrix,'rows','pairwise','tail','both');

figure('Name',measure);
% plot all our correlations
[H,AX,BigAx,P,PAx]=plotMatrix(All_roidatamatrix);

% H is an nxn matrix the same size as the plotmatrix
% these are figure properties like linestyle
% AX is an nxn matrix with the handles for the axes
% BigAx is the whole figure axis
% P and Pax control the histogram scales

% roi names along top and sides
for r=1:length(rois)
%     label above top row
    title(AX(1,r),rois(r,3));
%     label left side
    ylabel(AX(r,1),rois(r,3));

end

%     add label for rho and p by using xlabel so that it ends up on the
%     plot below it
% 
% for r1=1:length(rois)
%     for r2=1:length(rois)
% %         make sure its not on the diagonal
%     if ~isequal(r1,r2)
% %         make the right axis current
%         axes(AX(r1,r2));
% %         have to custom set the position for each axis
%       ylims = get(gca,'YLim');
%       xlims = get(gca,'XLim');
% %       positions which we want to be percentage of the axis
%       xpos=xlims(1)+.1*diff(xlims);
%         ypos=ylims(1)+.9*diff(ylims);
%         set(gca,'FontSize',1);
%         text(xpos,ypos,['r=' num2str(rho(r1,r2)) ' p=' num2str(pVal(r1,r2))], ...
%             'FontSize',1);
%     
%         
% %        if the correlation is significant, lets change the dots to red
%         if(pVal(r1,r2)<0.05)
%         set(H(r1,r2),'MarkerFaceColor','r');
%         end
%     end
%         
%         
%     end
% end


% might be just as nice to make some heat maps of the pvals and rhos
% 
figure('Name',['correlation of subject ' measure ' across rois'],'Color',[1 1 1],...
    'Position',get(0,'ScreenSize'));


subplot(1,2,1);
imagesc(rho);
colorbar; caxis([-1 1]);
set(gca,'YTickLabel',rois(:,3),'XTickLabel',rois(:,3))
title('correlation rho');


subplot(1,2,2);
imagesc(pVal);
colorbar; caxis([0 .2]);
set(gca,'YTickLabel',rois(:,3),'XTickLabel',rois(:,3))
title('p value');

return;
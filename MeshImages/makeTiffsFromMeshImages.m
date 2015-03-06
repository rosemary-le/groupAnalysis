
function makeTiffsFromMeshImages(img, input, hemisphere, roiname)


% function makeTiffsFromMeshImages(img, input)
% function that takes the figures that are mesh screenshots and saves them
% as tiffs.  the print function is pretty crude, so I could do better but
% matlab figures are not wyswyg so excuses.
% img is a 1xn cell array of images
% input is a struct with the fields used to make the images
% input =
%
%       dataType: {12x1 cell}
%       sessions: {12x1 cell}
%          scans: [2 1 2 2 1 2 2 1 2 2 1 2]
%       blockdir: '/biac2/kgs/projects/retinotopy/adult_ecc_karen/'
%           cmap: 'hsvCmap'
%        mapType: 'corAnal'
%      threshold: 0.1000
%       savepath: '/biac2/kgs/projects/retinotopy/adult_ecc_karen/Analyses/MeshImages/retino_rois/'
%            roi: {1x18 cell}
%      roicolors: [18x3 double]
%     hemisphere: {'left'}
%        pathhem: 'Left'
%         meshes: {12x1 cell}
%          names: {12x1 cell}
%      meshangle: {'l_ven_big_nw'}
%            map: 'corAnal.mat'
%
% of these fields you need at least names, map, threshold, roi, and
% roicolors
% these are put on the figure so can be altered to anonymize the figures or
% reduce the number of rois etc..
% hemisphere is which hemisphere was used.  I would use it from input, but
% I often run both hemispheres together so that field gets changed.
% roiname is a text string that is added at the end of the filename.
% usually I use it to specify something about the rois that might be on the
% mesh

% nw 11/11


for s=1:length(input.sessions)
    % so
    figure('name', input.sessions{s}, 'color' ,[1 1 1],'Position',[0 0 1920 1200]);
    
    
    %
    image(img{s});
    
    box off;  axis off;
    
    % now to add our subject and map info
    
    txt =  ['map: ' input.map '  thresholded at ' num2str(input.threshold)];
    text(0, .08, input.names{s},...
        'FontSize',10,'FontWeight','Bold',...
        'units','Normalized','interpreter','none');
    text(0, .04, txt,...
        'FontSize',10,'FontWeight','Bold',...
        'units','Normalized','interpreter','none');
    
    
    % if we have any white rois, let's change them to gray so we can see them
    if isfield(input,'roi')
        for i=1:length(input.roi)
            %make sure we specified a color
            if isfield(input,'roicolors')
                if input.roicolors(i,:) == [1 1 1]
                    input.roicolors(i,:) = [.5 .5 .5];
                end
            end
        end
    end
    
%     % then our list of rois with the names colored as the rois
%     if isfield(input,'roi')
%         for i=1:length(input.roi)
%             text(0, 1-i*.02, input.roi{i},...
%                 'FontSize',5,'FontWeight','Bold','Color',input.roicolors(i,:),...
%                 'units','Normalized','interpreter','none');
%         end
%     end
%     
    %     then save a high quality jpg or png
    %  save name is
    %  subjectname_hemisphere_map_threshold_roisuppliedbyuser.tiff
    svname = [input.sessions{s} '_' hemisphere '_' input.map '_' num2str(input.threshold) '_' roiname '.tiff'];
    
    print(gcf,'-dtiff','-opengl',svname)
    
    close(gcf)
end

end
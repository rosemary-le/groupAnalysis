% show a figure script

% load the .mat file you want

load 13_fVoROIs_fovVper.mat_0.03fovVper.03.mat

% has variables in it like this
% adult_lmeshes        12x1                  1278  cell
%   adult_rmeshes        12x1                  1288  cell
%   adult_rois_lven       1x12            616640400  cell
%   adult_rois_rven       1x12            616640400  cell
%   adult_sessions       12x1                  1112  cell
%   input                 1x1                  8842  struct

% the rois_lven and rven are the actual images in a cell array
% the adult_sessions are the names of the subjects in the same order as the
% images
% input is a struct that has all the variables used to make the images so
% that I can check my work as I make some mistakes

%
% % to see an image
% % make a figure window


% or if you want to see all the images
for i=1:length(adult_rois_rven)
    figure('name', adult_sessions{i}, 'color' ,[1 1 1]);
    image(adult_rois_rven{i});
    box off;  axis off;
end

% let's turn this into a script that makes nice looking jpgs of our images
% and saves them in the subjects images directory.


% things we would like
% text on the jpg that has
% subject name  input.session{i}
% maptype input.map
% input.roi which could be a lot
% input.threshold
 
% 
% Normalized units map the...
%     
% lower left corner of the rectangle defined by 
% the axes to (0,0) and the upper right corner to (1.0,1.0). 

for s=1:length(adult_sessions)
    % so
    figure('name', adult_sessions{s}, 'color' ,[1 1 1]);
   

%     
    image(adult_rois_rven{s});
%      axes('Position',[0 0 1920 1200]);,'Position',[0 0 1920 1200]
    box off;  axis off;
    
    % now to add our subject and map info
    
    txt =  ['subject:   ' input.names{s} '              ', ...
        'map: ' input.map '  thresholded at ' num2str(input.threshold)];
    text(.1, .05, txt,...
        'FontSize',10,'FontWeight','Bold',...
        'units','Normalized','interpreter','none');
    
    % if we have any white rois, let's change them to gray so we can see them
    for i=1:length(input.roi)
        if input.roicolors(i,:) == [1 1 1]
            input.roicolors(i,:) = [.5 .5 .5];
        end
    end
    
    
    % then our list of rois with the names colored as the rois
    for i=1:length(input.roi)
        text(0, 1-i*.02, input.roi{i},...
            'FontSize',5,'FontWeight','Bold','Color',input.roicolors(i,:),...
            'units','Normalized','interpreter','none');
    end
    
  
%     then save a high quality jpg or png
%  save name is
%  subjectname_hemisphere_map_threshold_roisuppliedbyuser.tiff
    svname = [input.names{s} '_' input.pathhem '_' input.map '_' num2str(input.threshold) '_facesVobjects.tiff'];

     print(gcf,'-dtiff','-opengl',svname)
    
     close(gcf)
end

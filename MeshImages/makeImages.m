

function cimg = makeImages(img, input, names)
% function cimg = makeImages(img, input, names)
% img is a 1 xnumsubjects cell array with each cell containing a 2d image
% matrix
% input is a struct created in the script which produced the images 
% input = 
% 
%       sessions: {1x8 cell}
%          scans: [2 1 2 1 1 1 1 1 1]
%       blockdir: '/biac2/kgs/projects/Prosopagnosia/fMRIData/'
%           cmap: 'autumnCmap'
%     hemisphere: {'left'}
%        pathhem: 'Left'
%         meshes: {1x8 cell}
%            map: 'ChildManVObjCar.mat'
%      meshangle: {'lh_ventral_gg'}
% names is a cell array of strings with the names for labelling each brain.
%  generally can use input.sessions, but for presentations want these to be
%  anonymous.  should make this default when not specified.


% %then organize the saved mesh screenshots into a figure.
% % rory's approach is to assemble the images into a big matrix
% img_final=imageMontage(img);
% fig2=figure('Units', 'norm', 'Position', [.1 .2 .7 .9], 'Name', 'Mesh Images','Color',[ 1 1 1]);
% image(img_final);
% axis off;
% %this makes the images big but unlabeled
% 
% %alina's approach is to put them all in subplots
% %which allows for labels and control but the images are smaller
% fig4=figure('Name', input.map, 'Color', [1 1 1]);
% [m n] =subplotsize(length(input.sessions));
% for i = 1:length(input.sessions)
%     subplot(m,n,i);
%     image(img{i});
%     %     zoom(1.5)
%     title(input.sessions(i));
%     axis off;
% end

% a hack is to show each image in a figure, add some text/annotation then
% use getframe to pull out the part of the image you want.  then assemble
% into a montage using rory's approach.  questions of location make this
% more specific than should be


%if you are calling this using the images from mesh amplitude maps you will
%need to reshap the image vector to be 1 x m*n  instead of m x n
if(numel(size(img))==2)
   img= reshape(img',1,size(img,1)*size(img,2));
end

% first label your images and then grab them



for i= 1:length(img)
    %want the figure to be large since we are capturing a bitmap and this
    %will set the resolution
    figure('name','icapt','Position', [0 0 1000000 1000000],'color',[1 1 1]);
    image(img{i});
    axis off;
    %want to add text.  for unknown reasons, the scale on mesh images runs
    %from (0,500) to (500,0) with the brain in the center.  we could get
    %cute and add some way of centering the text but for now, bottom left
    text(50, 450, names(i),'FontSize',60,'FontWeight','Bold','interpreter','none');
    %want to make these anonymous.  should have an anonymous line to go
    %with the sessions.
    
    %     now want to grab just the interior of the figure. the function
    %     getframe grabs a specfied part of the figure in pixels.  we want
    %     what is inside the axes, but those are in % of the figure size.
    %     fortunately we can get the figure size and multiply so
    f=getframe(gcf,get(gca,'position').*get(gcf,'position'));
    %just grab the image
    cimg{i}=f.cdata;
    %close the figure
%     close('icapt');
end



%then organize the saved mesh screenshots into a figure.
% rory's approach is to assemble the images into a big matrix
imgf=imageMontage(cimg);
figure('Units', 'norm', 'Position', [.1 .2 .7 .9], 'Name', 'croppedmontage','Color',[ 1 1 1]);
image(imgf);
axis off;



end




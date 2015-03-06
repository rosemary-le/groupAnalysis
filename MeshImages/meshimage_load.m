function hG = meshimage_load(hG, inputz)

%  this function loads a specified mesh and then updates with the data 
% takes as arguments the structs hG and inputz.  
% 
% hG is the hidden gray with the parameter map and/or rois
% to be seen initialized.  generating hG can be done using the function hG_load
%  
% inputz is a struct with the following arguments relevant here (also used
% for hG_load)
%  hemisphere:  which hemisphere to retrieve (or both)
%  NW 7/10



% basic preferences for the mesh
L.ambient = [.5 .5 .4];
L.diffuse = [.3 .3 .3];
setpref('mesh', 'layerMapMode', 'all');
setpref('mesh', 'overlayLayerMapMode', 'mean');



%% load up a mesh for the view

for ii=1:length(inputz.hemisphere)
    % first, we set the hemisphere, by setting the cursor position's 3rd dim.
    if isequal(lower(inputz.hemisphere{ii}), 'left')
        hG.loc = [100 100 1];
    else
        hG.loc = [100 100 200];
    end

    % load the mesh
    hG = meshLoad(hG, inputz.meshname{ii}, 1);
    
    %retrieve the angle you want to view the mesh from and update
   [mesh1, settings] = meshRetrieveSettings(hG.mesh{ii}, inputz.meshangle{ii});

    % % try re-computing the vertex map just to be safe
    vertexGrayMap = mrmMapVerticesToGray(...
        meshGet(mesh1, 'initialvertices'),...
        viewGet(hG, 'nodes'),...
        viewGet(hG, 'mmPerVox'),...
        viewGet(hG, 'edges'));

    %get your new map 
    hG.mesh{ii} = meshSet(hG.mesh{ii}, 'vertexgraymap', vertexGrayMap);

    % Set the mesh lighting to be the same across meshes
    meshLighting(hG, hG.mesh{ii}, L, 1);
    
    % Make the mesh as big as the screen (y in pixels, x in pixels)
     mrmSet(hG.mesh{ii},'windowSize',1200,1920)
    
    %draw maps and rois onto your current mesh
    meshColorOverlay(hG);
end

end
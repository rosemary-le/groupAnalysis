function   img = get_meshImages(input)


%generate our images

for i=1:length(input.sessions)
    disp('loading session ..');
    input.sessions{i}
    %set some parameters for the mesh
    input.scan_num = input.scans(i); %which scan
%     this line might cause problems
    input.meshname = {[input.blockdir input.sessions{i} '/3DAnatomy/' input.pathhem '/3DMeshes/' input.meshes{i}]}; %name of the mesh
%     meshname could just be 
%     input.meshname = {input.meshes{i}};
    
    %     datatype
    if length(input.dataType)>1
        input.dt  = input.dataType{i};
    else
        input.dt = input.dataType{1};
    end
    
%     add the rotation to the colormap if desired 
    if isfield(input,'phoffsets')
        input.phoffset = input.phoffsets(i);
    end
    
%     give the name for the prf model if you are trying to load one
    if isfield(input,'prfModels');
        input.prfModel = input.prfModels{i};
    end
    
    %need to put the session in a separate variable for hG_load
    input.sess = input.sessions{i};
    %go to our subject directory
    cd([input.blockdir input.sessions{i}]);
    %load our hidden gray, maps and rois
    hG= hG_load(input);
    %     hG = hG_load2(input);
    %set up our mesh and update with maps and rois
    hG = meshimage_load(hG, input);
    %get a screenshot of the image
    img{i} = mesh_scrnsht(hG,input);
    % close the meshes
    hG = meshDelete(hG, Inf);
end





end
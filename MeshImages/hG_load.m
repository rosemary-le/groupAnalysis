function hG = hG_load(inputz)

%loads a hidden gray volume and adds rois and parameter map specified
% by user.  the output can then be passed to meshimage_load.m for
% initializing a mesh and getting a screenshot of it

% takes as an input a struct inputz with fields
%  blockdir:  experiment directiory
%  sess:   session directory
%  scannum:   scan to initialize hG for using mean map or which glm to load
%  roi:   cell containing strings with names of rois to draw on mesh
%  roicolors: n (number or rois) x 3 color map, that should be in the same
%  order as the rois
%  map:  string with name of map to load
%  mapType:  type of map to load (mean, coranal, parameter)
%  nw 7/10


% need to add some variables if desired including
% clipmode:  pair of values that will set the min and max value for the
% color map index
% roiDrawMethod:  boxes, perimeter, etc.
% threshold:  minimum value of map to show on mesh
% cohParamMap:  if this is defined then load a parameter map into the
% cothresh
% coherence field and then use threshold value on this.  proportion
% variance explained is a good choice for this.
% coScaleFlag determines whether or how to scale the map loaded to
% the coherence field as per loadCoherenceMap.m
% also, all field checks should be switched to isfield to avoid having to
% pass dummy parameters.



% You have the option of loading the mean map on the mesh
if strcmpi(inputz.mapType, 'mean')
    hG=initHiddenGray('MotionComp_RefScan1', inputz.scan_num);
    
    %% load the ROI, get ready for the main loop
    %     [hG , ok] = loadROI(hG, inputz.roi, 0);
    
    
    
    
    %% load the user prefs -- meshColorOverlay needs a 'ui' field :P
    hG.ui = load('Gray/userPrefs.mat');
    hG.ui.dataTypeName= 'MotionComp_RefScan1'; % in case ui preferences are different
    
    hG=loadMeanMap(hG);
    hG=setDisplayMode(hG,'map');
    hG=setClipMode(hG, 'map', [0 10000]);
    % Uses the 'Hot' color map
    hG.ui.mapMode=setColormap(hG.ui.mapMode, 'hotCmap');
    hG=refreshScreen(hG);
    %set map threshold, p=3
    %hG=setMapWindow(hG, [3 Inf]);
    
end

%   or load a corAnal onto the gray
if strcmpi(inputz.mapType, 'corAnal')
    disp('loading corAnal.......');
    %     hG=initHiddenGray('MotionComp_RefScan1', inputz.scan_num);
    hG=initHiddenGray(inputz.dt, inputz.scan_num);
    mapPath=fullfile(inputz.blockdir, inputz.sess, 'Gray', inputz.dt,inputz.map);
    %% load the user prefs -- meshColorOverlay needs a 'ui' field :P
    hG.ui = load('Gray/userPrefs.mat');
    
    %     load the chosen coranal and then set to phase and choose a coherence threshold
    hG= loadCorAnal(hG,char(mapPath));
    hG=setDisplayMode(hG,'ph');
    hG=setCothresh(hG, inputz.threshold);
    hG=refreshScreen(hG);
    
    disp('our hidden view struct')
    hG
    
    
    %     can't use phMode for a lot of the phase colormaps
    %         hG.ui.phMode=setColormap(hG.ui.phMode, inputz.cmap);
    hG.ui.phMode=setColormap(hG.ui.phMode,'hsvCmap');
    %     need to write an eval here I think since each phase colormap mode is
    %     its own function.  for the moment
    %     hG = cmapRedgreenblue(hG, 'ph', 1);
    
    %     sometimes you want to rotate the phase map so if the field for that
    %     exists do it
    if isfield(inputz,'phoffset')
        disp('rotating colormap');
        hG = rotateCmap(hG,inputz.phoffset);
    end
    
    %     since this is a coranal we will set the layerMapMode to 1 for the
    %     meshes we open.  this should be a variable somewhere
    setpref('mesh','layerMapMode','layer1')
    
    
    hG=refreshScreen(hG);
    
end

% or load a prf model and then a parameter map
if strcmpi(inputz.mapType, 'prf')
    disp('loading prf model...');
    %     hG=initHiddenGray('MotionComp_RefScan1', inputz.scan_num);
    hG=initHiddenGray(inputz.dt, inputz.scan_num);
    mapPath=fullfile(inputz.blockdir, inputz.sess, 'Gray', inputz.dt,inputz.prfModel);
    mapPath = inputz.prfModel;
    %% load the user prefs -- meshColorOverlay needs a 'ui' field :P
    hG.ui = load('Gray/userPrefs.mat');
    %     load the chosen prfmodel and then set to phase and choose a
    %     coherence threshold
    % vw = rmSelect([vw=current view], [loadModel=0], [rmFile=dialog]);
    hG= rmSelect(hG, 1, mapPath);
    hG=rmLoadDefault(hG);
    %     we set this to whatever we want to see
    % 'anat'    anatomy
    % 'co'      coherence
    % 'amp' prf size
    % 'ph'    is polar angle
    % 'map'   is eccentricity
    switch(inputz.whichMap)
        case{'size to ecc ratio'}
            %prf sigma / prf center eccentricity
            disp('loading size ecc ratio map');
            hG=rmLoad(hG,1,'size to ecc ratio','amp');
            %             make sure we are looking at the amplitude field
            hG=setDisplayMode(hG,'amp');
            %             set the color map
            hG.ui.ampMode=setColormap(hG.ui.ampMode, 'hsvTbCmap')
            %           clip it
            hG=setClipMode(hG,'amp',[0 5]);
            %         ipsilateral visual field coverage
        case{'ipsi cov map'}
            %              view = rmLoad([view=current view], model, parameter, field);
            hG=rmLoad(hG,1,'ipsi overlap deg','amp');
            %             make sure we are looking at the amplitude field
            hG=setDisplayMode(hG,'amp');
            %             set the color map
            hG.ui.ampMode=setColormap(hG.ui.ampMode, 'hsvTbCmap')
            %           clip it  need to pass this is as a parameter
            hG=setClipMode(hG,'amp',[0 4]);
            
            %             'prf size'
        case{'amp'}
            hG=setDisplayMode(hG,inputz.whichMap);
            hG.ui.ampMode=setColormap(hG.ui.ampMode, inputz.cmap)
            
            %             any of the default maps
            %             these need to be split so that it will handle the color maps
            %             correctly
        case{'co','map'}
            
            hG=setDisplayMode(hG,inputz.whichMap);
            
        case{'ph'}
            %             polar angle
            hG=setDisplayMode(hG,inputz.whichMap);
            %        %should pass rotation as a parameter if using it
            hG = rotateCmap(hG,270);
            
    end
    hG=setCothresh(hG, inputz.threshold);
    %     set the color map
    % the different colormaps may have slightly different ways of being loaded
    %     if they are wedge maps or phase maps (I think)
    if strcmp(inputz.cmap(1:5),'Wedge')
        %         then use this method
        hG=cmapImportModeInformation(hG, 'phMode', inputz.cmap);
        %          4 band both visual fields map
    elseif strcmp(inputz.cmap,'rygb4bands')
        hG = cmapRedgreenblue(hG, 'ph', 1);
        
    else
        %            regular method
        %         hG.ui.phMode=setColormap(hG.ui.phMode, inputz.cmap);
        hG.ui.phMode=setColormap(hG.ui.phMode,inputz.cmap);
    end
    %     sometimes you want to rotate the phase map so if the field for that
    %     exists do it
    if isfield(inputz,'phoffset')
        disp('rotating colormap');
        hG = rotateCmap(hG,inputz.phoffset);
    end
    
    hG=refreshScreen(hG);
    
    
    
end

%or default to a parameter map
if strcmpi(inputz.mapType, 'parameter')
    % initialize mesh with scan number
    hG=initHiddenGray('GLMs',inputz.scan_num);
    mapPath=fullfile(inputz.blockdir, inputz.sess, 'Gray', inputz.dataType{1},inputz.map);
    
    
    
    %% load the user prefs -- meshColorOverlay needs a 'ui' field :P
    hG.ui = load('Gray/userPrefs.mat');
    hG.ui.dataTypeName= 'GLMs'; % in case ui preferences are different
    
    hG= loadParameterMap(hG, mapPath);
    
    
    
    
    %     set color map and threshold
    %is your cmap bicolor:
    if strcmpi(inputz.cmap, 'bicolor')
        hG = bicolorCmap(hG);
        %         hG= setCothresh(hG, .02);
        hG=setCothresh(hG, inputz.threshold);
        hG = refreshScreen(hG, 1);
        %no map to load
    elseif strcmpi(inputz.cmap, '')
        
        % or just positive values from the contrast:
    else
        hG.ui.mapMode=setColormap(hG.ui.mapMode, inputz.cmap);
        hG.ui.mapMode.clipMode = [3 5];
        hG.ui.displayMode='map';
        %set map threshold, p=2
        %             hG=setMapWindow(hG, [3 Inf]);
        hG=setMapWindow(hG,[inputz.threshold Inf]);
    end
    
    
end





%     sometimes you want to threshold a map using another map.  in this
%     case you will load it into the coherence field and set that field to
%     some value.

if isfield(inputz, 'coParamMap')
    %         load the map
    %     this map appears to need a full file path to its location
    %
    hG= loadCoherenceMap(hG,...
        [inputz.blockdir '/' inputz.sess '/Gray/' inputz.dt '/' inputz.coParamMap],...
        inputz.coScaleFlag);
    % threshold
    hG=setCothresh(hG, inputz.threshold);
end



% sometimes we don't want any maps so haven't yet initialized hG
if ~exist('hG')
    hG=initHiddenGray('MotionComp_RefScan1', inputz.scan_num);
    %     in some versions of matlab (2007a) if we don't set the hG.ui.display
    %     field then meshColorOverlay will crash when we draw to the mesh
    hG.ui.displayMode = 'anat';
end




%  %% load ROIs if there are any
if isfield(inputz, 'roi')
    %load the rois
    [hG , ok] = loadROI(hG, inputz.roi, 0);
    % set roi drawing method if desired
    
    if isfield(inputz, 'roiDrawMethod')
        %     %may want to specify the roi view (i.e. perimeter, filled
        %     boxes,
        %     hG.ui.roiDrawMethod = 'perimeter'  'boxes'
        disp('setting roi drawing method');
        hG.ui.roiDrawMethod = inputz.roiDrawMethod
    else
        %      default to perimeter
        disp('setting roi draw method to default perimeter');
        hG.ui.roiDrawMethod = 'perimeter';
    end
    
    
end






%set roi colors if desired
if isfield(inputz,'roicolors')
    %check to see if that subject has the roi
    for j=1:size(inputz.roicolors,1)
        %check to see if the roi exists
        for i=1:length(hG.ROIs)
            %if the jth roi is one of the loaded ones
            if (findstr([hG.ROIs(i).name],inputz.roi{j}))
                %then change its color
                %                 display(['setting color to'
                %                 num2str(inputz.roicolors(:,j))]);
                hG.ROIs(i).color = inputz.roicolors(j,:);
            end
        end
    end
    hG=refreshScreen(hG,1);
end

%sometimes ROIs might be set to hide ROIs, so to make sure they appear
hG.ui.showROIs = -2;

%     %may want to specify the roi view (i.e. perimeter, filled boxes, etc..)
if isfield(inputz,'roiDrawMethod')
    switch(inputz.roiDrawMethod)
        case('perimeter')
            hG.ui.roiDrawMethod = 'perimeter';
        case('boxes');
            hG.ui.roiDrawMethod = 'boxes';
    end
end

% hG.ui.roiDrawMethod = 'perimeter';
hG = refreshScreen(hG);


end
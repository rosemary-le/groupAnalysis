function hG = hG_load2(inputz)

%loads a hidden gray volume and adds rois and parameter map specified
% by user.  the output can then be passed to meshimage_load.m for
% initializing a mesh and getting a screenshot of it.  idea is to improve
% upon hG_load by having the user specify more parameters thus simplifying
% this function

% takes as an input a struct inputz with fields
%  blockdir:  experiment directiory
%  sess:   session directory
%  scannum:   scan to initialize hG for using mean map or which glm to load
%  roi:   cell containing strings with names of rois to draw on mesh
%  roicolors: n (number or rois) x 3 color map, that should be in the same
%  order as the rois
%  map:  string with name of map to load
%  dt:  dataType to load
% threshold:  minimum value of map to show on mesh

%  nw 7/10


% need to add some variables if desired including
% clipmode:  pair of values that will set the min and max value for the
% color map index
% roiDrawMethod:  boxes, perimeter, etc.

% cohParamMap:  if this is defined then load a parameter map into the
% cothresh
% coherence field and then use threshold value on this.  proportion
% variance explained is a good choice for this.
% coScaleFlag determines whether or how to scale the map loaded to
% the coherence field as per loadCoherenceMap.m


% also should add a list of checks here for default variable settings

% some default choices for map thresholds
if ~isfield(inputz,'threshold')
    %     bicolor map
    if strcmpi(inputz.cmap, 'bicolor')
        inputz.threshold = .02;
    end
    %      parameter map
    if strcmpi(inputz.cmap, 'bicolor')
        inputz.threshold = 3;
    end
end




% load hidden gray and put map and rois on it

% You have the option of loading the mean map on the mesh
if strcmpi(inputz.map, 'mean')
    hG=initHiddenGray('MotionComp_RefScan1', inputz.scan_num);

    %% load the ROI, get ready for the main loop
    [hG , ok] = loadROI(hG, inputz.roi, 0);




    %% load the user prefs -- meshColorOverlay needs a 'ui' field :P
    hG.ui = load('Gray/userPrefs.mat');
    hG.ui.dataTypeName= 'MotionComp_RefScan1'; % in case ui preferences are different

    hG=loadMeanMap(hG);
    hG=setDisplayMode(hG,'map');
    hG=setClipMode(hG, 'map', [1000 15000]);
    % Uses the 'Hot' color map
    hG.ui.mapMode=setColormap(hG.ui.mapMode, 'hotCmap');
    hG=refreshScreen(hG);
    %set map threshold, p=3
    %hG=setMapWindow(hG, [3 Inf]);



else
    % initialize mesh with scan number
%     hG=initHiddenGray('GLMs',inputz.scan_num);
      hG=initHiddenGray(inputz.dataType,inputz.scan_num);
%     mapPath=fullfile(inputz.blockdir, inputz.sess, 'Gray', 'GLMs',inputz.map);
  mapPath=fullfile(inputz.blockdir, inputz.sess, 'Gray', inputz.dataType,inputz.map);
    %% load the ROI, get ready for the main loop
    if isfield(inputz, 'roi')
        %load the rois
        [hG , ok] = loadROI(hG, inputz.roi, 0);
    end

    %% load the user prefs -- meshColorOverlay needs a 'ui' field :P
    hG.ui = load('Gray/userPrefs.mat');
    hG.ui.dataTypeName = inputz.dataType;
%     hG.ui.dataTypeName= 'GLMs'; % in case ui preferences are different
    %sometimes ROIs might be set to hide ROIs, so to make sure they appear
    hG.ui.showROIs = -2;
    hG= loadParameterMap(hG, mapPath);



    %set roi colors if desired
    if isfield(inputz,'roicolors')
        %check to see if that subject has the roi
        for j=1:length(inputz.roicolors)
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


    %     %may want to specify the roi view (i.e. perimeter, filled boxes, etc..)
    %     hG.ui.roiDrawMethod = 'perimeter';
    hG.ui.roiDrawMethod = 'boxes';
    hG.ui.roiDrawMethod = 'perimeter';
    %     hG = refreshScreen(hG);


    %     set color map and threshold
    %is your cmap bicolor:
    if strcmpi(inputz.cmap, 'bicolor')
        hG = bicolorCmap(hG);
        %         hG= setCothresh(hG, .02);
        hG=setCothresh(hG, inputz.threshold);
        hG = refreshScreen(hG, 1);
        %no map to load
    else if strcmpi(inputz.cmap, '')

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
        hG= loadCoherenceMap(hG, inputz.coParamMap, inputz.coscaleFlag);
        % threshold
        hG=setCothresh(hG, inputz.cothresh);
    end


    hG = refreshScreen(hG, 1);


end
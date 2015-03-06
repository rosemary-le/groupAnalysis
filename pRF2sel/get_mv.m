function [hV mv]=get_mv(hV,dt,scan,cmprss)

%function [h mv]=get_mv(dt,scan,roi,cmprss)
% initializes an roi and runs the glm on each voxel
% arguments are
% hidden view
%  dataType
%  scans
%cmprss 0 to keep timeseries and voxData, 1 to remove them
% assumes you are in the correct subject directory

if notDefined('cmprss') cmprss=0; end


%get rid of any extraneous variables
% clear dataTYPES mrSESSION vANATOMYPATH

    %set params for glm just to be sure
    % enforce consistent preprocessing / event-related parameters
    % want to add params as an argument
    params = er_getParams(hV,scan(1),dt);
    params.glmHRF = 3; % flag for spm HIRF
    params.ampType = 'betas';
    er_setParams(hV, params,scan(1),dt);


    display('initializing mv');
    % get data from the voxels
    mv = mv_init(hV, [], scan, dt, 0);
    display('applying glm to voxels');
    % apply the glm to the voxels
    mv = mv_applyGlm(mv);

    %  get the amplitudes
    % will probably want to put this elsehwere so that we can specify which
    % amplitudes
    display('getting mv amps');
    mv.amps = mv_amps(mv);

    %  add some fields to help keep track of the anatomy indices
    [mv.roiInd, mv.coords] = roiIndices(hV, mv.roi.coords, 1);

    
    %should add a flag in case we want to strip the tSeries and voxData which makes
    %the files very large and is maybe not necessary to keep
    if cmprss == 1
        display('stripping tSeries and voxData fields');
        mv=rmfield(mv,'tSeries');
        mv=rmfield(mv,'voxData');
    end

end
function rmROI = rmGetParamsFromROI(vw)
% rmROI = rmGetParamsFromROI(vw)
% get and return all prf params for given an open view, loaded retmodel, and selected roi
% returns rmROI.roi with coords, indices, roi name, and view
% roi has viewtype, coherence, sigmas, thetas, betas, x, y, phase, and ecc
% NW 12 2013

% %  check that everything is loaded
if notDefined('vw'),           error('View must be defined.'); end


%% load different pRF parameters
try
    rmModel   = viewGet(vw,'rmSelectedModel');
catch %#ok<CTCH>
    error('Need retModel information. Try using rmSelect. ');
end

if isempty(viewGet(vw, 'roiCoords')),  error('no roi selected'); end

% Get coordinates for current ROI
rmROI.coords   = viewGet(vw, 'roiCoords');
rmROI.indices  = viewGet(vw, 'roiIndices');
rmROI.name     = viewGet(vw, 'roiName');
rmROI.curScan      = viewGet(vw, 'curScan');

% Get co and ph (vectors) for the current scan, within the
% current ROI.
rmROI.vt      = vw.viewType;
rmROI.co      = rmCoordsGet(rmROI.vt, rmModel,'varexp',     rmROI.indices);
rmROI.sigma1  = rmCoordsGet(rmROI.vt, rmModel,'sigmamajor', rmROI.indices);
rmROI.sigma2  = rmCoordsGet(rmROI.vt, rmModel,'sigmaminor', rmROI.indices);
rmROI.theta   = rmCoordsGet(rmROI.vt, rmModel,'sigmatheta', rmROI.indices);
rmROI.beta    = rmCoordsGet(rmROI.vt, rmModel,'beta',       rmROI.indices);
rmROI.x0      = rmCoordsGet(rmROI.vt, rmModel,'x0',         rmROI.indices);
rmROI.y0      = rmCoordsGet(rmROI.vt, rmModel,'y0',         rmROI.indices);

clear rmModel

%%%%%%%%%%%%%%
% y flip note (r.a.s., 10/2009):
% ------------------------------
% I believe the stimulus generation code has had problems (from around
% 2006-2009) where all stimuli were up/down flipped with respect to the pRF
% sampling grid [X, Y]. As a consequence, all models solved in this time
% seem to have a Y flip. The values saved on disk are off; you can
% manually test this with an ROI like V2d which covers a quarterfield.
%
% I'm now trying to fix this issue. All accessor functions seem to have
% implicitly corrected the flip, but in hard to trace ways. (This involves
% a lot of post-hoc calls to functions like 'flipud' which made things
% confusing.) I'm trying to (1) fix the core problems in the stim code; and
% (2) remove the post-hoc corrections to the accessor code.
%
% But for now, there are a lot of models saved on disk, and it will take a
% long time to fix them. So, I'm keeping the y-flip correction, but making
% it explicit here. When the code is fixed and most models saved on disk
% are correct, we can remove this.
rmROI.y0 = -rmROI.y0;

% ok. I think it is time to remove. I suggest putting in a flag to flip the
% y-dimension if requested, but otherwise not to.
if getpref('VISTA', 'verbose')
    warning('Negative y values plotted as lower visual field. This may be incorrect for old pRF models, as old code used to treat neagitve y as upper field.'); %#ok<*WNTAG>
end
%%%%%%%%%%%%%%

% grabbing both (x0, y0) and (pol, ecc) are redundant, and allow for the
% two specifications to get separated (because of the y-flip issue). So,
% re-express ecc and pol using x0 and y0.
[rmROI.ph rmROI.ecc] = cart2pol(rmROI.x0, rmROI.y0);


end
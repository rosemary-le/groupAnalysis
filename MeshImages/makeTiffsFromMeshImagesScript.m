% load your images


load 12_fVoROIs_corAnal.mat_0.15ecc.15.mat

% call makeTiffs

makeTiffsFromMeshImages(adult_rois_rven,input,'Right','facesVobjects')
makeTiffsFromMeshImages(adult_rois_lven,input,'Left','facesVobjects')
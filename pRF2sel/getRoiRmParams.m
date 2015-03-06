function roidata = getRoiRmParams(rm,h)

% function roidata = getRoiRmParams(rm,h)
% gets prf parameter from each voxel in roi
% rm is a struct with data for each subject
% rm{1}
% 
% ans = 
% 
%      coords: [3x1633 single]
%     indices: [1633x1 double]
%        name: 'lV1_all_nw'
%     curScan: 1
%          vt: 'Gray'
%          co: [1x1633 double]
%      sigma1: [1x1633 double]
%      sigma2: [1x1633 double]
%       theta: [1x1633 double]
%        beta: [1633x3 double]
%          x0: [1x1633 double]
%          y0: [1x1633 double]
%          ph: [1x1633 double]
%         ecc: [1x1633 double]
%     session: '42111_MN'
% 
% h is a struct with threshold information for selecting which voxels and
% subjects to use in analysis
% h = 
% 
%           param: 'ecc'
%            bins: [0 12]
%         binsize: 1
%        threshco: 0.1
%       threshecc: [0.5 11.5]
%     threshsigma: [0 24]
%              ci: [2.5 97.5]


%  should add subjects field
% will get just relevant subjects here

for s=1:length(rm)

 
    %     get index to values satisfying thresholds
    indx = 1:length(rm{s}.co);
    %     threshold by coherence
    coindx = find(rm{s}.co>=h.threshco);
    %     good voxels by coherence
    indx = intersect(indx,coindx);
    % threshold by ecc
    eccindx = intersect(find(rm{s}.ecc>=h.threshecc(1)),find( rm{s}.ecc<=h.threshecc(2)));
    %     goodvoxels by eccentricity
    indx = intersect(indx,eccindx);
    %     good voxels by sigma
    sigindx = intersect(find(rm{s}.sigma1>=h.threshsigma(1)),find( rm{s}.sigma1<=h.threshsigma(2)));
    
    indx = intersect(indx,sigindx);


%     extract relevant paramter

     roidata{s} = rm{s}.(h.param)(indx);

    
   

end

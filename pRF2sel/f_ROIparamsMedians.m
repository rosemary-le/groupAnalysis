function    roiData = f_ROIparamsMedians(rm,h)



% struct for our output

roiData.sessions = {};
roiData.co = [];
roiData.ecc = [];
roiData.sigma = [];
roiData.name = [];
roiData.percentvoxels = [];
roiData.size =[];
roiData.origSize = [];

%     figure out which sessions you want to use
%     can't preallocate since we don't know how many we will have

%     now collect it from across rm
%     this needs to be a function
for r=1:length(rm)
    
    
    %
    
    %     loop across subjects and get data from rm struct you just loaded
    roiData.name{r} = rm{r}.name;
    
%     think that thresholding already does this
%     %get shortened session name:  sad little hack
% %    make sure this hasn't happened already, bug somewhere
%   if length(rm{r}.session)>4
%       
%     if length(rm{r}.session)<10
%          roiData.sessions{r} = rm{r}.session(7:end);
%     else
%         roiData.sessions{r}=rm{r}.session(7:9);
%     end
%   end
    roiData.sessions{r} = rm{r}.session;
    %     get index to values satisfying thresholds
    indx = 1:length(rm{r}.co);
    %     threshold by coherence
    coindx = find(rm{r}.co>=h.threshco);
    %     good voxels by coherence
    indx = intersect(indx,coindx);
    % threshold by ecc
    eccindx = intersect(find(rm{r}.ecc>=h.threshecc(1)),...
        find( rm{r}.ecc<=h.threshecc(2)));
    %     goodvoxels by eccentricity
    indx = intersect(indx,eccindx);
    %     good voxels by sigma
    sigindx = intersect(find(rm{r}.sigma1>=h.threshsigma(1)),...
        find(rm{r}.sigma1<=h.threshsigma(2)));
    
    indx = intersect(indx,sigindx);
    

    
    %         get all measures
    %     roi size
    roiData.size = [roiData.size length(rm{r}.coords(indx))];
%     original size of roi assumes you ran thresholding f_thresholdrmdata
    roiData.origSize = [roiData.origSize length(rm{r}.origindices)];
    %                 roi variance explaine                 roiData.subdata = [roiData.subdata mean(rm{r}.co)];
    roiData.co = [roiData.co median(rm{r}.co(indx))];
%     should build this out into a switch
%  roiData.co = [roiData.co mean(rm{r}.co(indx))];
    %             eccentricity
    roiData.ecc = [roiData.ecc median(rm{r}.ecc(indx))];
%         roiData.ecc = [roiData.ecc mean(rm{r}.ecc(indx))];
    %                 prf sigma
    roiData.sigma = [roiData.sigma median(rm{r}.sigma1(indx))];
%         roiData.sigma = [roiData.sigma mean(rm{r}.sigma1(indx))];

    %                 proportion of voxels from roi used
    roiData.percentvoxels = [roiData.percentvoxels length(rm{r}.coords(indx))/length(rm{r}.coords)];
        
    
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    end

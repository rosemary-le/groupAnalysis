
set_pRF2selVars15deg;

roi = 'lV2_all_nw.mat';
roi = 'rV2_all_nw.mat';
% for each subject
for s=1:length(retsessions)
    % for s=10
    % get retmodel data
    %     cd to ret session
%     cd([sessiondir retsessions{s}]);
%     %     open hidden view
%     if strcmp(vw,'Gray')
%         hV =initHiddenGray(retdts{s},[],roi);
%     else
%         hV=initHiddenInplane(retdts(s),[],roi);
%     end
%     
    %     check to see if roi exists
    if ~exist([sessiondir retsessions{s} '/3DAnatomy/ROIs/' roi]);
%     if isempty(hV.ROIs)
        disp(['no roi for this subject ' retsessions{s}]);
    end
    
end
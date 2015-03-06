% sometimes I want to have %variance explained maps to use as a coherence
% threshold and then pass on to the mesh.  in cases where the first map is
% a parameter map and then the %var exp is from that same glm, this is no
% problem.  but sometimes I want the % var exp from some other map.  when
% that happens I need to name and stick that map somewhere.  In this case I
% want to have % var exp from the ecc experiment so that I can threshold my
% bivariate distributions.
% NW 5/11

% save name for your map
mapname = 'ecc_varexp.mat';

% get some sessions info
set_sessions;

% glm scan which has the map we want
adultglmscans = [3 4 6 9 2 3 5 2 3 3 3];
prosoglmscans = [3 5 3 3 3 3 3 3 ];
% 
% for each subject
for i=1:length(adult_sessions)
%    load the map
    oldmap=load([expDir '/' adult_sessions{i}...
        '/Gray/GLMs/Proportion Variance Explained.mat']);
    map={oldmap.map{adultglmscans(i)}};
    mapName='varExp';
    mapUnits='percent';
    save([expDir '/' adult_sessions{i}...
        '/Gray/MotionComp_RefScan1/' mapname], ...
        'map', 'mapName', 'mapUnits');
    
end



% for each subject
for i=1:length(proso_sessions)
%    load the map
    oldmap=load([pexpDir '/' proso_sessions{i}...
        '/Gray/GLMs/Proportion Variance Explained.mat']);
    map={oldmap.map{prosoglmscans(i)}};
    mapName='varExp';
    mapUnits='percent';
    save([pexpDir  proso_sessions{i}...
        '/Gray/MotionComp_RefScan1/' mapname], ...
        'map', 'mapName', 'mapUnits');
    
end
function   img = mesh_scrnsht(hG, inputz)

%  takes a screenshot of the mesh and crops it if the view is ventral
%  takes initialized hidden gray as argument (use hG_load then
%  meshImage_load)
%  adopted from RAS, and just split into separate function for readability
%  NW 7/10



% grab the snapshot
img= mrmGet( hG.mesh{1}, 'screenshot' ) ./ 255;

%     and crop it if it is a ventral view
if ~isempty(findstr(inputz.meshangle{1}, 'ventral'))
    img=img(60:526, 83:425, :);

end


end
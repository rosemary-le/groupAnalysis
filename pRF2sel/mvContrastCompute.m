function mv = mvContrastCompute(mv,cname,condnames1, condnames2);




% for each subject
for s=1:length(mv)
        % find the condition numbers
    condnums1 = [];    condnums2 = [];
%     need to subtract 1 from condition names position in list since the
%     first condition (blank) isn't counted in the contrast function
    for i=1:length(condnames1)
        condnums1 = [condnums1 find(strcmp(mv{s}.trials.condNames,condnames1(i)))-1];
    end
    for i=1:length(condnames2)
        condnums2 = [condnums2 find(strcmp(mv{s}.trials.condNames,condnames2(i)))-1];
    end
%     compute the contrast
    [mv{s}.(cname).stat2, mv{s}.(cname).ces2, mv{s}.(cname).TVal2, mv{s}.(cname).units2]= ...
        glm_contrast(mv{s}.glm, condnums1, condnums2, 'size', size(mv{s}.coords) );
        
end
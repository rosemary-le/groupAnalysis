% need a safety check on the rois, especially the face ones.  its a lot of
% manual entry, and it is very easy to misname an roi.  so for example to
% accidentally call V2v V3v.  then you might end up with two rois which are
% V2v but have different names.  the easiest way to check is to see if any
% two rois for a particular subject are the same size, if they are flag
% them. and check if they have same coordinates.  then need to fix manually
% and rerun scripts.  
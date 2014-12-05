close all; 
clear;


zeroid = find(abs(diff(sign(x)))==2);
if length(zeroid)>0,
    maxvalues = zeros(length(zeroid),1);
    maxids = zeros(length(zeroid),1);
    for z=1:length(zeroid)-1,
       [val,id]  = max(x(zeroid(z):zeroid(z+1),1));
    end
end

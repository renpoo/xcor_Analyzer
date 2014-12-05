[filename,pathname]=uigetfile('*.mat');
load(fullfile(pathname, filename));
whos
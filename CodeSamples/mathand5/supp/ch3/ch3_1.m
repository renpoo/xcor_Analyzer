data_in=rand(1,100);
data_time=rand(1,100);
[filename,pathname]=uiputfile('*.mat');
save(fullfile(pathname, filename),'data_in','data_time');

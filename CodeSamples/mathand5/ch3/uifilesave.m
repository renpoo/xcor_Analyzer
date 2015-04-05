%データの保存data_in, data_time変数を保存するスクリプト
data_in=rand(1,100);
data_time=rand(1,100);
filename=uiputfile('*.mat');
save(filename,'data_in','data_time')

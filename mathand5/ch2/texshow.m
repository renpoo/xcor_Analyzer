fid=fopen('texchar.txt');
data=fread(fid);
fclose(fid);
data=char(data)';
data=data(find(~(data==13)));
data=data(find(~(data==10)));
index=find(data==',');
index=[0 index];
for i=1:length(index)-1
  subplot(10,10,i);axis off
  text(0.5,0.5,['\fontsize{30}',data((index(i)+1):(index(i+1)-1))])
end

data = zeros(10,100);
for ii=1:10
  data(ii,:) = sin((1:100)*ii*0.1);
end
rootname = 'file'; % Root filename
extension = '.dat'; % Extension for the files
for jj = 1:10
  tmpdata = data(jj,:);
  filename = [rootname, int2str(jj), extension];
  eval(['save ', filename , ' tmpdata -ascii'])
end

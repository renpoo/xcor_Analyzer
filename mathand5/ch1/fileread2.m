clear
data = zeros(10,100);
rootname = 'file'; % Root filename
extension = '.dat'; % Extension of the files
for jj = 1:10
  variable = [rootname, int2str(jj)];
  filename = [variable, extension];
  eval(['load ', filename])
  eval(['data(', num2str(jj), ',:) = ', variable, ';'])
  eval(['clear ', variable])
end

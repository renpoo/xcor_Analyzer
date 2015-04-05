new_yy=zeros(size(yy));
for i=2:(length(yy)-1)
  new_yy(i)=(yy(i-1)+yy(i)+yy(i+1))/3;
end

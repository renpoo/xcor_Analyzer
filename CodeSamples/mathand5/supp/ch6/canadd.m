function y=canadd(a,b)
y=a+b;
if (ischar(a)|ischar(b)) y=str2num(a)+str2num(b);end

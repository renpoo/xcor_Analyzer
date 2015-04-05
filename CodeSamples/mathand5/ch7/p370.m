Fs = 11025;
y = sin(((1:Fs)-1)/Fs*2);
yy = y + .1*(rand(size(y))-0.5)+.5*cos(((1:length(y))-1)/Fs*5);
t = ((1:length(y))-1)/Fs;
n=4;
A=t(:).^n;
for i=(n-1):-1:0
  A=[A t(:).^i];
end
B=yy(:);
plot(t,yy,t,A*(A\B),'r--')
lsqpara=A\B;
lsqstr=['y='];
for i=1:n
  if lsqpara(i)>0,pmstr='+';
  else pmstr='-';end
  lsqstr=[lsqstr,pmstr,num2str(abs(lsqpara(i))),'x^',num2str(n+1-i)];
end
if lsqpara(n+1)>0,pmstr='+';
else pmstr='-';end
lsqstr=[lsqstr,pmstr,num2str(abs(lsqpara(n+1)))];
legend('y',lsqstr);

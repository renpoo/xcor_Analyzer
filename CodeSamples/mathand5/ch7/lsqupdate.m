n=round(get(ui1,'value'));
A=t(:).^n;
for i=(n-1):-1:0
A=[A,t(:).^i];
end
B=yy(:);
set(lines(2),'ydata',A*(A\B));
lsqpara=A\B;
lsqstr=['y='];
for i=1:n
if lsqpara(i)>0,pmstr='+';
else pmstr='-';end
lsqstr=[lsqstr,pmstr,num2str(abs(lsqpara(i))),'x^',
num2str(n+1-i)];
end
if lsqpara(n+1)>0,pmstr='+';
else pmstr='-';end
lsqstr=[lsqstr,pmstr,num2str(abs(lsqpara(n+1)))];
legend('y',lsqstr);
title([' Ÿ”=',num2str(n)]);

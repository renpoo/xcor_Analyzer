t=(1:1000)*0.001-0.001;
freq=25;T=1/freq;
u=sin(2*pi*freq*t)+sin(2*pi*300*t);
%%%%%%%%%%%%%%%%%%
[num,den]=c2dm([T 0],conv([T 1],[T 1]),0.001);
%y(2)=0;
%y(k+2)=(-den(2)*y(k+1)-den(3)*y(k)+num(1)*u(k+2)+num(2)*u(k+1)+num(3)*u(k))/den(1);
y=[0 0];
for i=3:length(t)
  val=(-den(2)*y(end)-den(3)*y(end-1)+num(1)*u(i)+num(2)*u(i-1)+num(3)*u(i-2))/den(1);
  y=[y val];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,1,1);plot(t,u,t,sin(2*pi*freq*t),'r');
axis([0 0.2 -1.5 1.5]);
subplot(2,1,2);plot(t,y);
axis([0 0.2 -1.5 1.5]);

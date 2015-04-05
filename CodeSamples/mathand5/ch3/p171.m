[num,den]=c2dm([T 0],conv([T 1],[T 1]),0.001);
y=filter(num,den,u);
subplot(2,1,1);plot(t,u,t,sin(2*pi*freq*t),'r');
axis([0 0.2 -1.5 1.5]);
subplot(2,1,2);plot(t,y);
axis([0 0.2 -1.5 1.5]);

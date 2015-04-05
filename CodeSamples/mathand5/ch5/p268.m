close all;clear all;
figure(1);tic;
axes1=axes;
plt1=plot(cos(0),sin(0),'o');axis([-1.2 1.2 -1.2 1.2]);
set(axes1,'drawmode','fast');
set(plt1,'erasemode','xor');
for x=0:0.01:2*pi;
	set(plt1,'xdata',cos(x),'ydata',sin(x));
	drawnow;
end;
toc

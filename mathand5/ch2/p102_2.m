figure(1);
plot1=plot(sin(0),cos(0),'ob');axis([-2 2 -2 2]);
axis('square');set(gca,'drawmode','fast');
set(plot1,'erasemode','xor');
for x=0:0.01:10
	set(plot1,'xdata',sin(x),'ydata',cos(x));
	drawnow;
end

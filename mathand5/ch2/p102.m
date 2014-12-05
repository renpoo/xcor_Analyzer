close all;
for x=0:0.01:10;
	plot(sin(x),cos(x),'ob');
	axis([-2,2,-2,2]);
	axis square;
	drawnow;
end

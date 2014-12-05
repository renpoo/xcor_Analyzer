close all;clear all
figure('Renderer','zbuffer')
t=0:pi/100:5*pi;
p3=plot3(sin(t),cos(t),zeros(size(t)),'b')
title('Helix');xlabel('sin(x)');ylabel('cos(x)');zlabel('t')
grid;text(0,0,0,'Origin');zlim([0 20])
set(gca,'NextPlot','replaceChildren');
count=1;
for k=0.1:0.01:1;
set(p3,'zdata',k*t)
drawnow;
M(count)=getframe;
count=count+1;
end
disp('Please push any key to start movie')
pause;close all;movie(M)

close all;figure(1);
t=0:pi/100:5*pi;
abc=plot3(sin(t),cos(t),t,'b')
title('Helix');xlabel('sin(x)');ylabel('cos(x)');zlabel('t')
grid;text(0,0,0,'Origin');zlim([0 20])
for k=0.1:0.01:1;set(abc,'zdata',k*t);drawnow;end

close all
untitled
set(0,'showhiddenhandles','on');
[x,y,z]=peaks(20);
surface(x,y,z);
axis([-5 5 -5 5 -5 5]);
set(0,'showhiddenhandles','off');

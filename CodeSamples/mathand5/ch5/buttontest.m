close all;clear all;
fig1=figure;
plt1=plot(sin(0:0.01:2*pi));

set(fig1,'ButtonDownFcn','disp(''ButtonDownFcn figure'');');
set(gca,'ButtonDownFcn','disp(''ButtonDownFcn axes'');');
set(plt1,'ButtonDownFcn','disp(''ButtonDownFcn line'');');

set(fig1,'KeyPressFcn','disp(''KeyPressFcn figure'');');
set(fig1,'WindowButtonDownFcn','disp(''WindowButtonDownFcn figure'');');
%set(fig1,'WindowButtonMotionFcn','disp(''WindowButtonMotionFcn figure'');');
set(fig1,'WindowButtonUpFcn','disp(''WindowButtonUpFcn figure'');');
set(fig1,'WindowKeyPressFcn','disp(''WindowKeyPressFcn figure'');');
set(fig1,'WindowKeyReleaseFcn','disp(''WindowKeyReleaseFcn figure'');');
set(fig1,'WindowScrollWheelFcn','disp(''WindowScrollWheelFcn figure'');');

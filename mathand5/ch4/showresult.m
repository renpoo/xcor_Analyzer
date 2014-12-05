close all;clear all
initmot
sim('smotor')
subplot(2,1,1);
plot((1:length(simout.signals.values))*0.001,simout.signals.values(:,1))
xlabel('time[sec]');ylabel('\theta [rad]');xlim([0.5,2]);
subplot(2,1,2);
plot((1:length(simout.signals.values))*0.001,simout.signals.values(:,2))
xlabel('time[sec]');ylabel('thetadot [rad/sec]');xlim([0.5,2]);

[t01,xyz01] = ode45('lorenz',[0,30],[5;3;1]); % Ver.A
[t02,xyz02] = ode45('lorenz',[0,30],[30;3;1]); % Ver.B
[t03,xyz03] = ode45('lorenz',[0,30],[100;0;1]); % Ver.C
[t04,xyz04] = ode45('lorenz',[0,30],[0;100;1]); % Ver.D
[t05,xyz05] = ode45('lorenz',[0,30],[5;3;100]); % Ver.E

figure();
grid on; hold on;

fig01 = plot3(xyz01(:,1), xyz01(:,2), xyz01(:,3));
fig02 = plot3(xyz02(:,1), xyz02(:,2), xyz02(:,3));
fig03 = plot3(xyz03(:,1), xyz03(:,2), xyz03(:,3));
fig04 = plot3(xyz04(:,1), xyz04(:,2), xyz04(:,3));
fig05 = plot3(xyz05(:,1), xyz05(:,2), xyz05(:,3));


xlabel('x');
ylabel('y');
zlabel('z');
hold off;
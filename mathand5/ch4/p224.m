yds=simout.signals.values;
plot(t,y,t,yds);
xlabel('Time[sec]');
ylabel('Magnitude');
axis([0 t(end) -1.2 1.2]);

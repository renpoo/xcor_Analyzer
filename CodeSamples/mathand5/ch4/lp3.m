dt=0.01;t=(1:1000)*dt-dt;
u=ones(size(t));theta=1;wn=1;
figure(1);
tt=1;
for theta=0:0.1:0.9
	sim('lowpass',t([1,end]));
	subplot(5,2,tt);plot(t,simout);
	tt=tt+1;
	title(['\theta=',num2str(theta)]);
end
set(0,'ShowHiddenHandles','on');% show hidden handles
set(findobj('type','text'),'fontsize',5);
set(findobj('type','axes'),'fontsize',5);
set(0,'ShowHiddenHandles','off');% resume hidden handles

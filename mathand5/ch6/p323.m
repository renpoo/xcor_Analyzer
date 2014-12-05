clear all;
i=1;
for L=1:0.1:2;
subplot(3,4,i);ode45(@pend2,[0 10],[0;45*pi/180],[],L);
i=i+1;title(L);
end
set(findobj('marker','o'),'marker','.')

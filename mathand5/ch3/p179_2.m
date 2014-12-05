x=1:0.1:20;
plot(x,sign(sin(x)),'b:',x,interp1(1:20,sign(sin(1:20)),x,'spline'),'b')

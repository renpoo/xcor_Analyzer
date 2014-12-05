function dxdt = pend(t,x)
g=9.8;L=1;
theta=x(1);omega=x(2);
dxdt = [omega;-g/L*sin(theta)];

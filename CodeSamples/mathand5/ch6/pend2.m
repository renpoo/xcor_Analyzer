function dxdt = pend2(t,x,L)
g=9.8;L
theta=x(1);omega=x(2);
dxdt = [omega;-g/L*sin(theta)];

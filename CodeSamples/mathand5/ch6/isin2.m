function [x,y]=isin2(z)
xx=fminsearch(@tmpsin,[0;0],[],z);
x=xx(1);y=xx(2);
function zz=tmpsin(xx,z)
x=xx(1);y=xx(2);
zz=(sin2(x,y)-z)^2;

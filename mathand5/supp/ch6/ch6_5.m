function x=ch6_5(y)
x=fminsearch(@errfunc,0,[],y);
function z=errfunc(x,y)
z = (x^2-y)^2;

function x=isin1(y)
x=fminsearch(@tmpsin,0,[],y);
function z=tmpsin(x,y)
z=(sin1(x)-y)^2;

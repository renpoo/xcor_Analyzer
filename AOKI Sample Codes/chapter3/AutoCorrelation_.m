function r=AutoCorrelation_(x,window_size)
r=zeros(1,window_size);
den=0;
for n=1:window_size,
   den=den+x(n)*x(n);
end
for m=1:window_size,
   for n=1:window_size-m+1,
      r(m)=r(m)+x(n)*x(n+m-1);
   end
   r(m)=r(m)/den;
end

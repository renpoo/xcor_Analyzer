function r=AutoCorrelation_(x,window_size)
r=zeros(1,window_size);
den = 0.00000000001;

den = x(1:window_size)' * x(1:window_size);
#den = x' * x;


for m=1:window_size,
  #x_sub = x(1:window_size);
  #x_sub_shift_m = x(m:window_size+m-1);
  x_sub = x(1:window_size-m+1);
  x_sub_R_shift_m = x(m:window_size);
  r(m) = x_sub' * x_sub_R_shift_m;
  #for n=1:window_size-m+1,
  #  r(m)=r(m)+x(n)*x(n+m-1);
  #end
end

r = r / den;
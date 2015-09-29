function e=LpcInverseFiltering_(s,parcor,lpc_order)
length_of_s=length(s);
gamma=zeros(1,lpc_order+1);
f=zeros(1,lpc_order+1);
b=zeros(1,lpc_order+1);
e=zeros(1,length_of_s);
for m=1:lpc_order+1,
   gamma(m)=-parcor(m);
end
for n=1:length_of_s,
   f(1)=s(n);
   for k=2:lpc_order+1,
      f(k)=f(k-1)+gamma(k)*b(k-1);
   end
   for k=lpc_order+1:-1:2, 
      b(k)=b(k-1)+gamma(k)*f(k-1);
   end
   b(1)=s(n);
   e(n)=f(lpc_order+1);
end

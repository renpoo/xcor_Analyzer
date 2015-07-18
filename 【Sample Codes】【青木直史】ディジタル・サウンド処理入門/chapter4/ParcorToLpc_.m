function lpc=ParcorToLpc_(parcor,lpc_order)
a=zeros(1,lpc_order+1);
lpc=zeros(1,lpc_order+1);
gamma=zeros(1,lpc_order+1);
for k=1:lpc_order+1,
   gamma(k)=-parcor(k);
end
lpc(1)=1;
lpc(2)=gamma(2);
for k=3:lpc_order+1,
   for m=1:k-1,
      a(m)=lpc(m);
   end
   a(k)=0;
   for m=1:k,
      lpc(m)=a(m)+gamma(k)*a(k+1-m);
   end
end

function parcor=LpcToParcor_(lpc,lpc_order)
a=zeros(1,lpc_order+1);
parcor=zeros(1,lpc_order+1);
gamma=zeros(1,lpc_order+1);
for k=lpc_order+1:-1:2,
   gamma(k)=lpc(k);
   for m=1:k,
      a(m)=lpc(m);
   end
   for m=1:k,
      lpc(m)=(a(m)-gamma(k)*a(k-m+1))/(1-gamma(k)*gamma(k));
   end
end
for k=1:lpc_order+1,
   parcor(k)=-gamma(k);
end

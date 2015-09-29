function [lpc,parcor]=LevinsonDurbin_(s,lpc_order)
length_of_s=length(s);
a=zeros(1,lpc_order+1);
r=zeros(1,lpc_order+1);
lpc=zeros(1,lpc_order+1);
gamma=zeros(1,lpc_order+1);
parcor=zeros(1,lpc_order+1);
epsilon=zeros(1,lpc_order+1);
for m=1:lpc_order+1,
   for n=1:length_of_s-m+1,
      r(m)=r(m)+s(n)*s(n+m-1);
   end
end
epsilon(1)=r(1);
gamma(2)=-r(2)/epsilon(1);
lpc(1)=1;
lpc(2)=gamma(2);
epsilon(2)=epsilon(1)*(1-gamma(2)*gamma(2));
for k=3:lpc_order+1,
   for m=1:k-1,
      a(m)=lpc(m);
   end
   a(k)=0;
   num=0;
   for m=1:k,
      num=num+a(m)*r(k+1-m);
   end
   gamma(k)=-num/epsilon(k-1);
   for m=1:k,
      lpc(m)=a(m)+gamma(k)*a(k+1-m);
   end
   epsilon(k)=epsilon(k-1)*(1-gamma(k)*gamma(k));
end
for m=1:lpc_order+1,
   parcor(m)=-gamma(m);
end

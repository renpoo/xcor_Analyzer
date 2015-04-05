function s=LpcSpeechSynthesis_(e,parcor,lpc_order)
length_of_e=length(e);
gamma=zeros(1,lpc_order+1);
f=zeros(1,lpc_order+1);
b=zeros(1,lpc_order+1);
s=zeros(1,length_of_e);
for m=1:lpc_order+1,
   gamma(m)=-parcor(m);
end
for n=1:length_of_e,
   f(lpc_order+1)=e(n);
   for k=lpc_order+1:-1:2,
      f(k-1)=f(k)-gamma(k)*b(k-1);
   end
   for k=lpc_order+1:-1:2, 
      b(k)=b(k-1)+gamma(k)*f(k-1);
   end
   s(n)=f(1);
   b(1)=s(n);
end

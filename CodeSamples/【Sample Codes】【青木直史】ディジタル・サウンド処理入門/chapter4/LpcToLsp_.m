function lsp=LpcToLsp_(lpc,lpc_order,fs)
dft_size=4096;
lsp=zeros(1,lpc_order);
omega=zeros(1,lpc_order/2);
theta=zeros(1,lpc_order/2);
p=zeros(1,dft_size);
q=zeros(1,dft_size);
p(1)=lpc(1);
q(1)=lpc(1);
for n=2:lpc_order+1,
   p(n)=lpc(n)+lpc(lpc_order+3-n);
   q(n)=lpc(n)-lpc(lpc_order+3-n);
end
p(lpc_order+2)=lpc(1);
q(lpc_order+2)=-lpc(1);
P=abs(fft(p,dft_size));
m=1;
for k=2:dft_size/2,
   if P(k-1)>P(k) & P(k)<P(k+1)
      omega(m)=k-1;
      m=m+1;
   end
end
Q=abs(fft(q,dft_size));
m=1;
for k=2:dft_size/2,
   if Q(k-1)>Q(k) & Q(k)<Q(k+1)
      theta(m)=k-1;
      m=m+1;
   end
end
for m=1:lpc_order/2,
   lsp(2*m-1)=omega(m)*fs/dft_size;
   lsp(2*m)=theta(m)*fs/dft_size;
end

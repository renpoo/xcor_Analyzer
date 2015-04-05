function lpc=LspToLpc_(lsp,lpc_order,fs)
lpc=zeros(1,lpc_order+1);
c=zeros(1,lpc_order);
e=zeros(1,lpc_order+1);
s=zeros(1,lpc_order+1);
xa=zeros(1,lpc_order+1);
xb=zeros(1,lpc_order+1);
xc=zeros(1,lpc_order+1);
xd=zeros(1,lpc_order+1);
for m=1:lpc_order,
   c(m)=-2*cos(lsp(m)*2*pi/fs);
end
s(1)=1;
e(1)=s(1);
for n=2:lpc_order+1,
   xa(1)=s(n-1)/2;
   xb(1)=s(n-1)/2;
   for m=2:2:lpc_order,
      xa(m)=c(m-1)*xa(m-1)+xc(m-1);
      xa(m+1)=xa(m-1)+xc(m);
      xb(m)=c(m)*xb(m-1)+xd(m-1);
      xb(m+1)=xb(m-1)+xd(m);
   end
   y=0;
   for m=2:2:lpc_order,
      y=y+xa(m)+xb(m);
   end
   e(n)=s(n)+y+xa(lpc_order+1)-xb(lpc_order+1);
   for m=1:lpc_order,
      xc(m)=xa(m);
      xd(m)=xb(m);
   end 
end
for m=1:lpc_order+1,
   lpc(m)=e(m);
end

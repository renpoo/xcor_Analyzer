function x0=HybridDecoder_(lsp0,c0,Rx,B0,B1,fs,lpc_order,window_size,shift_size,dct_size)
e0=MdctDecoder_(c0,Rx,B1,dct_size);
length_of_e0=length(e0);
e1=zeros(1,length_of_e0);
e1(1)=e0(1);
for n=2:length_of_e0,
   e1(n)=e0(n)+0.98*e1(n-1);
end
number_of_frame=floor((length_of_e0-(window_size-shift_size))/shift_size);
length_of_x0=shift_size*(number_of_frame-1)+window_size;
x0=zeros(1,length_of_x0);
lsp=zeros(1,lpc_order);
e=zeros(1,window_size);
w=HanningWindow_(window_size);
step_size=(fs/2)/(power(2,B0)-1);
for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for n=1:window_size,
      e(n)=e1(offset+n)*w(n);
   end
   offset=lpc_order*(frame-1);
   for m=1:lpc_order,
      lsp(m)=lsp0(offset+m)*step_size;
   end
   x=LspSpeechSynthesis_(e,lsp,lpc_order,fs);
   offset=shift_size*(frame-1);
   for n=1:window_size,
      x0(offset+n)=x0(offset+n)+x(n);
   end
end

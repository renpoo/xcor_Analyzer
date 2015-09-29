function x0=LpcVocoderDecoder_(lsp0,pitch0,gain0,Rx,B0,B1,B2,fs,lpc_order,window_size,shift_size)
length_of_lsp0=length(lsp0);
number_of_frame=length_of_lsp0/lpc_order;
length_of_e0=shift_size*(number_of_frame-1)+window_size;
e0=zeros(1,length_of_e0);
step_size1=(power(2,B1)-1)/(power(2,B1)-1);
step_size2=Rx/(power(2,B2)-1);
period=0;
for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   if pitch0(frame)==0
      for n=1:shift_size,
         e0(offset+n)=gain0(frame)*step_size2*(rand-0.5);
      end
      period=0;
   else
      for n=1:shift_size,
         if period>=round(pitch0(frame)*step_size1)
            e0(offset+n)=gain0(frame)*step_size2;
            period=0;
         end
         period=period+1;  
      end
   end    
end
e1=zeros(1,length_of_e0);
e1(1)=e0(1);
for n=2:length_of_e0,
   e1(n)=e0(n)+0.98*e1(n-1);
end
length_of_x0=shift_size*(number_of_frame-1)+window_size;
x0=zeros(1,length_of_x0);
lsp=zeros(1,lpc_order);
e=zeros(1,window_size);
w=HanningWindow_(window_size);
step_size0=(fs/2)/(power(2,B0)-1);
for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for n=1:window_size,
      e(n)=e1(offset+n)*w(n);
   end
   offset=lpc_order*(frame-1);
   for m=1:lpc_order,
      lsp(m)=lsp0(offset+m)*step_size0;
   end
   x=LspSpeechSynthesis_(e,lsp,lpc_order,fs);
   offset=shift_size*(frame-1);
   for n=1:window_size,
      x0(offset+n)=x0(offset+n)+x(n);
   end
end

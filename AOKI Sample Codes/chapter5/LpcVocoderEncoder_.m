function [lsp0,pitch0,gain0]=LpcVocoderEncoder_(x0,Rx,B0,B1,B2,fs,lpc_order,window_size,shift_size)
length_of_x0=length(x0);
x1=zeros(1,length_of_x0);
x1(1)=0;
for n=2:length_of_x0,
   x1(n)=x0(n)-0.98*x0(n-1);
end
number_of_frame=floor((length_of_x0-(window_size-shift_size))/shift_size);
length_of_lsp0=lpc_order*number_of_frame;
lsp0=zeros(1,length_of_lsp0);
length_of_e0=shift_size*(number_of_frame-1)+window_size;
e0=zeros(1,length_of_e0);
x=zeros(1,window_size);
w=HanningWindow_(window_size);
step_size0=(fs/2)/(power(2,B0)-1);
for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for n=1:window_size,
      x(n)=x1(offset+n)*w(n);
   end
   [lpc,parcor]=LevinsonDurbin_(x,lpc_order);
   e=LpcInverseFiltering_(x,parcor,lpc_order);
   lsp=LpcToLsp_(lpc,lpc_order,fs);
   offset=shift_size*(frame-1);
   for n=1:window_size,
      e0(offset+n)=e0(offset+n)+e(n);
   end
   offset=lpc_order*(frame-1);
   for m=1:lpc_order,
      lsp0(offset+m)=round(lsp(m)/step_size0);
   end
end
fe=500;
delta=1000;
[b,filter_size]=FirLpf_(fs,fe,delta);
a(1)=1;
e1=filter(b,a,e0);
pitch0=zeros(1,number_of_frame);
gain0=zeros(1,number_of_frame);
e=zeros(1,window_size);
step_size1=(power(2,B1)-1)/(power(2,B1)-1);
step_size2=Rx/(power(2,B2)-1);
for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for n=1:window_size,
      e(n)=e1(offset+n);
   end
   pitch=PitchExtraction_(e,fs);
   pitch0(frame)=round(pitch*fs/step_size1);
   offset=shift_size*(frame-1);
   for n=1:window_size,
      e(n)=e0(offset+n);
   end
   gain=GainEstimation_(e);
   gain0(frame)=round(gain/step_size2);
end

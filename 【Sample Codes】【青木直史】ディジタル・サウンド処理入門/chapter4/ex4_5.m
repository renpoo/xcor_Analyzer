clear;
fs=8000;
lpc_order=10;
window_size=256;
shift_size=128;
fid=fopen('ai[simplified_residual].txt','rt');
e0=fscanf(fid,'%f');
fclose(fid);
length_of_e0=length(e0);
fid=fopen('ai[parcor].txt','rt');
parcor0=fscanf(fid,'%f');
fclose(fid);
length_of_parcor0=length(parcor0);
e1=zeros(1,length_of_e0);
e1(1)=e0(1);
for n=2:length_of_e0,
   e1(n)=e0(n)+0.98*e1(n-1);
end
number_of_frame=floor((length_of_e0-(window_size-shift_size))/shift_size);
length_of_s0=shift_size*(number_of_frame-1)+window_size;
s0=zeros(1,length_of_s0);
parcor=zeros(1,lpc_order+1);
e=zeros(1,window_size);
w=HanningWindow_(window_size);
for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for n=1:window_size,
      e(n)=e1(offset+n)*w(n);
   end
   offset=(lpc_order+1)*(frame-1);
   for m=1:lpc_order+1,
      parcor(m)=parcor0(offset+m);
   end
   s=LpcSpeechSynthesis_(e,parcor,lpc_order);
   offset=shift_size*(frame-1);
   for n=1:window_size,
      s0(offset+n)=s0(offset+n)+s(n);
   end
end
wavwrite(s0,fs,16,'ai[simplified_resynthesized].wav');
sound(s0,fs);
pause(2);
s1=wavread('ai.wav');
sound(s1,fs);

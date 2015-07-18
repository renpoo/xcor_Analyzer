clear;
fs=8000;
lpc_order=10;
window_size=256;
shift_size=128;
fid=fopen('ashi[residual].txt','rt');
e0=fscanf(fid,'%f');
fclose(fid);
length_of_e0=length(e0);
fe=500;
delta=1000;
[b,filter_size]=FirLpf_(fs,fe,delta);
a(1)=1;
e1=filter(b,a,e0);
number_of_frame=floor((length_of_e0-(window_size-shift_size))/shift_size);
pitch0=zeros(1,number_of_frame);
gain0=zeros(1,number_of_frame);
e=zeros(1,window_size);
for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for n=1:window_size,
      e(n)=e1(offset+n);
   end
   pitch=PitchExtraction_(e,fs);
   pitch0(frame)=pitch;
   offset=shift_size*(frame-1);
   for n=1:window_size,
      e(n)=e0(offset+n);
   end
   gain=GainEstimation_(e);
   gain0(frame)=gain;
end
fid=fopen('ashi[pitch].txt','wt');
fprintf(fid,'%f\n',pitch0);
fclose(fid);
fid=fopen('ashi[gain].txt','wt');
fprintf(fid,'%f\n',gain0);
fclose(fid);

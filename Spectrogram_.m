function [S,time,frequency]=Spectrogram_(s,fs,window_size,shift_size)
dft_size=window_size;
length_of_s=length(s);
number_of_frame=floor((length_of_s-(window_size-shift_size))/shift_size);
x=zeros(1,window_size);
w=HanningWindow_(window_size);
S=zeros(dft_size/2+1,number_of_frame);
for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for n=1:window_size,
      x(n)=s(offset+n)*w(n);
   end
   X=fft(x,dft_size);
   for k=1:dft_size/2+1,
      S(k,frame)=20*log10(abs(X(k)));
   end
end
time=zeros(1,number_of_frame);
for frame=1:number_of_frame,
   time(frame)=(frame-1)*shift_size/fs;
end
frequency=zeros(1,dft_size/2+1);
for k=1:dft_size/2+1,
   frequency(k)=(k-1)*fs/dft_size;
end

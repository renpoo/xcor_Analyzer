pkg load io;
pkg load signal;

close all; 
clear;
fs=8000;
fc=2000;

lpc_order=10;
window_size=256;
shift_size=128;
dft_size=1024;
#s0=wavread('ai.wav');
#s0=wavread('../../Sounds/Akan00.wav');
[ s0, fs, bits ] = wavread('Sounds/Akan00.wav');
#[ s0, fs, bits ] = wavread('141011_01.WAV');

sound( s0, fs );


[b,a]=IirLpf_(fs,fc);



length_of_s0=length(s0);
duration = length_of_s0 / fs;  %duration (of input signal)


s1=zeros(1,length_of_s0);
s1(1)=0;
for n=2:length_of_s0,
   s1(n)=s0(n)-0.98*s0(n-1);
end
number_of_frame=floor((length_of_s0-(window_size-shift_size))/shift_size);
length_of_e0=shift_size*(number_of_frame-1)+window_size;
e0=zeros(1,length_of_e0);
length_of_lpc0=(lpc_order+1)*number_of_frame;
lpc0=zeros(1,length_of_lpc0);
length_of_parcor0=(lpc_order+1)*number_of_frame;
parcor0=zeros(1,length_of_parcor0);
s=zeros(1,window_size);

#w=HanningWindow_(window_size);
#w=HammingWindow_(window_size);
#w=BlackmanWindow_(window_size);
w=RectangularWindow_(window_size);

x=zeros(1,dft_size);
A=zeros(1,dft_size/2+1);
frequency=zeros(1,dft_size/2+1);
   
   
for k=1:dft_size/2+1,
   frequency(k)=(k-1)*fs/dft_size;
end


#X_real = fft(s0, 513);
#plot( frequency, X_real );
#x_real = ifft(X_real, 513);
#plot( 1:513, x_real );
#sound( x_real, fs );
#return;



for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for n=1:window_size,
      s(n)=s1(offset+n)*w(n);
   end

  if(0),
   X_real = real( fft(s, dft_size/2+1) );
   #plot( frequency, X_real );
   for n=2:window_size,
      X_real(n) = X_real(n) - 0.98 * x(n-1);
   end
   #X_real = X_real + 1000.0;
   
   x_real = real( ifft(X_real, dft_size/2+1) );

   for n=1:window_size,
      x(offset+n) = x_real(n); #*w(n);
   end

   #plot( window_size, x );
   #hold on;

   continue;
  endif;
   
   
   [lpc,parcor]=LevinsonDurbin_(s,lpc_order);
   for n=1:lpc_order+1,
      x(n)=lpc(n);
   end
   X=fft(x,dft_size);
   
   
   for k=1:dft_size/2+1,
      A(k)=-20*log10(abs(X(k)));
   end
   offset=0.1*A(1);
   for k=1:dft_size/2+1,
      A(k)=-0.1*A(k)+offset+frame;
   end
   #plot(A,frequency);
   #plot(frequency, A);
   #hold on;
   [maxVal, maxPoint] = max( A(:) );
   freqOnAmax(frame) = frequency( maxPoint );
   #result = soundGeneratedSinusoid_(freqOnAmax(frame), fs, duration/number_of_frame, 0);
   result = soundGeneratedSinusoid_(freqOnAmax(frame), fs, 0.2, 0);
   sound( result, fs);
   
   #break;
   
   #[x_real, x_imag] = IFFT_(frequency, zeros(1,dft_size/2+1), dft_size);
   #x_real = ifft(frequency, dft_size);
   #sound( x_real, fs );
   #plot( (1:dft_size), x_real );
   
   
   e=LpcInverseFiltering_(s,parcor,lpc_order);
   offset=shift_size*(frame-1);
   for n=1:window_size,
      e0(offset+n)=e0(offset+n)+e(n);
   end
   offset=(lpc_order+1)*(frame-1);
   for m=1:lpc_order+1,
      lpc0(offset+m)=lpc(m);
      parcor0(offset+m)=parcor(m);
   end
end


spl = interp1 ([1:number_of_frame], freqOnAmax, [1:0.01:number_of_frame], "spline");
plot( spl );
#sound( spl, fs );

#sound( soundGeneratedSinusoid_(spl', fs, 0.5, 0), fs );

#plot( 1:length(x), x );
#sound( x, fs );
#wavwrite (x, fs, 'tmp.wav');

#sound( e0, fs );



if(0),
fid=fopen('ai[residual].txt','wt');
fprintf(fid,'%f\n',e0);
fclose(fid);
fid=fopen('ai[lpc].txt','wt');
fprintf(fid,'%f\n',lpc0);
fclose(fid);
fid=fopen('ai[parcor].txt','wt');
fprintf(fid,'%f\n',parcor0);
fclose(fid);
endif;
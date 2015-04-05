clear;
fs=8000;
dft_size=256;
lifter_size=12;
x=wavread('guitar_a3.wav');
xc=Cepstrum_(x,dft_size);
for m=lifter_size+1:dft_size/2+1,
   xc(m)=0;
   xc(dft_size+2-m)=0;
end
Xc=fft(xc,dft_size);
A=zeros(1,dft_size/2+1);
frequency=zeros(1,dft_size/2+1);
for k=1:dft_size/2+1,
   A(k)=20*real(Xc(k));
   frequency(k)=(k-1)*fs/dft_size;
end
plot(frequency,A);
hold on;
x=wavread('guitar_a3.wav');
w=HanningWindow_(dft_size);
for n=1:dft_size,
   x(n)=x(n)*w(n);
end
X=fft(x,dft_size);
A=zeros(1,dft_size/2+1);
frequency=zeros(1,dft_size/2+1);
for k=1:dft_size/2+1,
   A(k)=20*log10(abs(X(k)));
   frequency(k)=(k-1)*fs/dft_size;
end
plot(frequency,A);
hold off;

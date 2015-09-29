clear;
fs=8000;
dft_size=1024;
x=wavread('guitar_1024.wav');
getf('HanningWindow_.sci');
w=HanningWindow_(dft_size);
for n=1:dft_size,
   x(n)=x(n)*w(n);
end
X=fft(x);
A=zeros(1,dft_size/2+1);
frequency=zeros(1,dft_size/2+1);
for k=1:dft_size/2+1,
   A(k)=20*log10(abs(X(k)));
   frequency(k)=(k-1)*fs/dft_size;
end
plot(frequency,A);

clear;
fs=8000;
dft_size=1024;
x=wavread('guitar_a3.wav');
X=fft(x,dft_size);
A=zeros(1,dft_size/2+1);
frequency=zeros(1,dft_size/2+1);
for k=1:dft_size/2+1,
   A(k)=abs(X(k));
   frequency(k)=(k-1)*fs/dft_size;
end
plot(frequency,A);

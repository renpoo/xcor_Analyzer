pkg load io;
pkg load signal;

close all; 
clear;
fs=8000;
lpc_order=10;
window_size=256;
dft_size=1024;
#s0=wavread('a.wav');
s0=wavread('../../Sounds/Akan00.wav');
length_of_s0=length(s0);
s1=zeros(1,length_of_s0);
s1(1)=0;
for n=2:length_of_s0,
   s1(n)=s0(n)-0.98*s0(n-1);
end
s=zeros(1,window_size);
w=HanningWindow_(window_size);
for n=1:window_size,
   s(n)=s1(n)*w(n); 
end
[lpc,parcor]=LevinsonDurbin_(s,lpc_order);
x=zeros(1,dft_size);
for n=1:lpc_order+1,
   x(n)=lpc(n);
end
X=fft(x,dft_size);
A=zeros(1,dft_size/2+1);
frequency=zeros(1,dft_size/2+1);
for k=1:dft_size/2+1,
   A(k)=-20*log10(abs(X(k)));
   frequency(k)=(k-1)*fs/dft_size;
end
plot(frequency,A);

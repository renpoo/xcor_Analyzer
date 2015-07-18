clear;
fs=8000;
dft_size=256;
x=wavread('guitar_a3.wav');
xc=Cepstrum_(x,dft_size);
a=zeros(1,dft_size/2+1);
quefrency=zeros(1,dft_size/2+1);
for m=1:dft_size/2+1,
   a(m)=real(xc(m));
   quefrency(m)=(m-1)*1000/fs;
end
plot(quefrency,a);

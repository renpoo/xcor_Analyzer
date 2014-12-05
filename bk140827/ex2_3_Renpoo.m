clear;
#fs=8000;
dft_size=1024;
dft_size=1024*2;
#dft_size=1024*4;
#dft_size=1024*8;
[x_real, fs, bits] = wavread('Sounds/birdselffree.wav');
#x_imag = zeros(1,dft_size);
x_imag = zeros(1, length(x_real));
[X_real,X_imag]=FFT_(x_real,x_imag,dft_size);
A=zeros(1,dft_size/2+1);
frequency=zeros(1,dft_size/2+1);
for k=1:dft_size/2+1,
   A(k)=sqrt(X_real(k)*X_real(k)+X_imag(k)*X_imag(k));
   frequency(k)=(k-1)*fs/dft_size;
end
plot(frequency,A);

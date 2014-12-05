clear;
dft_size=60;
x_real=wavread('test.wav');
x_imag=zeros(1,dft_size);
[X_real,X_imag]=DFT_(x_real,x_imag,dft_size);
A=zeros(1,dft_size);
T=zeros(1,dft_size);
frequency=zeros(1,dft_size);
for k=1:dft_size,
   A(k)=sqrt(X_real(k)*X_real(k)+X_imag(k)*X_imag(k));
   T(k)=atan(X_imag(k)/X_real(k));
   frequency(k)=k-1;
end
subplot(2,1,1);
stem(frequency,A);
subplot(2,1,2);
stem(frequency,T);

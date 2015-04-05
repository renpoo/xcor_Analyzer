function [x_real,x_imag]=IDFT_(X_real,X_imag,dft_size)
x_real=zeros(1,dft_size);
x_imag=zeros(1,dft_size);
for n=1:dft_size,
   for k=1:dft_size,
      w_real=cos(2*pi*(k-1)*(n-1)/dft_size);
      w_imag=sin(2*pi*(k-1)*(n-1)/dft_size);
      x_real(n)=x_real(n)+w_real*X_real(k)-w_imag*X_imag(k);
      x_imag(n)=x_imag(n)+w_real*X_imag(k)+w_imag*X_real(k);
   end
   x_real(n)=x_real(n)/dft_size;
   x_imag(n)=x_imag(n)/dft_size;
end

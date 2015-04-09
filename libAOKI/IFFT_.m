function [x_real,x_imag]=IFFT_(X_real,X_imag,dft_size)
x_real=zeros(1,dft_size);
x_imag=zeros(1,dft_size);
number_of_stage=log2(dft_size);
for stage=1:number_of_stage,
   for i=1:power(2,(stage-1)),
      for j=1:power(2,(number_of_stage-stage)),
         n=power(2,(number_of_stage-stage+1))*(i-1)+j;
         m=power(2,(number_of_stage-stage))+n;
         r=power(2,(stage-1))*(j-1);
         a_real=X_real(n);
         a_imag=X_imag(n);
         b_real=X_real(m);
         b_imag=X_imag(m);
         c_real=cos((2*pi*r)/dft_size);
         c_imag=sin((2*pi*r)/dft_size);
         if stage<number_of_stage
            X_real(n)=a_real+b_real;
            X_imag(n)=a_imag+b_imag;
            X_real(m)=(a_real-b_real)*c_real-(a_imag-b_imag)*c_imag;
            X_imag(m)=(a_imag-b_imag)*c_real+(a_real-b_real)*c_imag;
         else
            X_real(n)=a_real+b_real;
            X_imag(n)=a_imag+b_imag;
            X_real(m)=a_real-b_real;
            X_imag(m)=a_imag-b_imag;
         end
      end
   end
end
number_of_bit=log2(dft_size);
for k=1:dft_size,
   index=dec2bin((k-1),number_of_bit);
   for position_of_bit=1:floor(number_of_bit/2),
      bit=index(position_of_bit);
      index(position_of_bit)=index(number_of_bit-position_of_bit+1);
      index(number_of_bit-position_of_bit+1)=bit;
   end
   x_real(bin2dec(index)+1)=X_real(k)/dft_size;
   x_imag(bin2dec(index)+1)=X_imag(k)/dft_size;
end
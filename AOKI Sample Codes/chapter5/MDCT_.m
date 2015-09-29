function X=MDCT_(x,dct_size)
y=zeros(1,dct_size*2);
X=zeros(1,dct_size);
for n=1:dct_size*2,
   y(n)=x(n)*exp(-j*pi*(n-1)/(dct_size*2));
end
Y=fft(y,dct_size*2);
for k=1:dct_size,
   X(k)=real(Y(k)*exp(-j*pi*(2*(k-1)+1)*(dct_size+1)/(dct_size*4)));
end

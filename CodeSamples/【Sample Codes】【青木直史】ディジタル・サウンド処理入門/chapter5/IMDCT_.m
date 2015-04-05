function x=IMDCT_(X,dct_size)
Y=zeros(1,dct_size*2);
x=zeros(1,dct_size*2);
for k=1:dct_size,
   Y(k)=X(k)*exp(j*pi*(k-1)*(dct_size+1)/(dct_size*2));
end
y=ifft(Y,dct_size*2);
for n=1:dct_size*2,
   x(n)=4*real(y(n)*exp(j*pi*(2*(n-1)+dct_size+1)/(dct_size*4)));
end

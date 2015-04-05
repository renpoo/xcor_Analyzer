function w=SineWindow_(window_size)
w=zeros(1,window_size);
for n=1:window_size,
   w(n)=sin((pi*(2*(n-1)+1))/(window_size*2));
end

function x0=MdctDecoder_(c0,Rx,B,dct_size)
window_size=dct_size*2;
shift_size=dct_size;
length_of_c0=length(c0);
number_of_frame=floor((length_of_c0-(window_size-shift_size))/shift_size);
length_of_x0=shift_size*(number_of_frame-1)+window_size;
x0=zeros(1,length_of_x0);
x=zeros(1,window_size);
c=zeros(1,dct_size);
w=SineWindow_(window_size);
RX=dct_size/32; 
for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for k=1:dct_size,
      c(k)=c0(offset+k);
   end
   for k=1:dct_size,
      if c(k)>=0
         sign_of_c=1;
      else
         sign_of_c=-1;
      end
      abs_of_c=abs(c(k));
      X(k)=sign_of_c*RX*(power(10,abs_of_c/power(2,B-1))-1)/9;
   end
   x=IMDCT_(X,dct_size);
   offset=shift_size*(frame-1);
   for n=1:window_size,
      x0(offset+n)=x0(offset+n)+x(n)*w(n);
   end
end
for n=1:length_of_x0,   
   x0(n)=x0(n)*Rx;
end

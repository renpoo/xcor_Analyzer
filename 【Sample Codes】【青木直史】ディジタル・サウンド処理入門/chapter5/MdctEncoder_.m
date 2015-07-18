function c0=MdctEncoder_(x0,Rx,B,dct_size)
window_size=dct_size*2;
shift_size=dct_size;
length_of_x0=length(x0);
number_of_frame=floor((length_of_x0-(window_size-shift_size))/shift_size);
length_of_c0=shift_size*(number_of_frame-1)+window_size;
c0=zeros(1,length_of_c0);
for n=1:length_of_x0,   
   x0(n)=x0(n)/Rx;
end
x=zeros(1,window_size);
c=zeros(1,dct_size);
w=SineWindow_(window_size);
max_of_c=power(2,B-1)-1;
min_of_c=-power(2,B-1);
RX=dct_size/32; 
for frame=1:number_of_frame,
   offset=shift_size*(frame-1);
   for n=1:window_size,
      x(n)=x0(offset+n)*w(n);
   end
   X=MDCT_(x,dct_size);
   for k=1:dct_size,
      if X(k)>=0
         sign_of_X=1;
      else
         sign_of_X=-1;
      end
      abs_of_X=abs(X(k));
      c(k)=sign_of_X*round(power(2,B-1)*log10(9*abs_of_X/RX+1));
      if c(k)>max_of_c
         c(k)=max_of_c;
      elseif c(k)<min_of_c
         c(k)=min_of_c;
      end  
   end
   offset=shift_size*(frame-1);
   for k=1:dct_size,
      c0(offset+k)=c(k);
   end
end

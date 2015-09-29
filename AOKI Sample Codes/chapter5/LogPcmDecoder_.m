function x=LogPcmDecoder_(c,R,B)
length_of_c=length(c);
x=zeros(1,length_of_c);
for n=1:length_of_c,
   if c(n)>=0
      sign_of_c=1;
   else
      sign_of_c=-1;
   end
   abs_of_c=abs(c(n));
   x(n)=sign_of_c*round(R*(power(10,abs_of_c/power(2,B-1))-1)/9);
end

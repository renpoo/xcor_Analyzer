function x=DpcmDecoder_(c,Rx,B)
length_of_c=length(c);
x=zeros(1,length_of_c);
xp=0;
Rd=Rx/4;
for n=1:length_of_c,
   if c(n)>=0
      sign_of_c=1;
   else
      sign_of_c=-1;
   end
   abs_of_c=abs(c(n));
   dp=sign_of_c*round(Rd*(power(10,abs_of_c/power(2,B-1))-1)/9);
   xp=xp+dp;
   x(n)=xp;
end

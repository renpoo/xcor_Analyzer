function x=AdpcmDecoder_(c,Rx,B)
length_of_c=length(c);
x=zeros(1,length_of_c);
xp=0;
Rd=Rx/4;
max_of_Rd=Rx;
min_of_Rd=Rx/256;
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
   if abs_of_c<power(2,B-2)
      Rd=Rd/2;
   else
      Rd=Rd*2;
   end
   if Rd>max_of_Rd
      Rd=max_of_Rd;
   elseif Rd<min_of_Rd
      Rd=min_of_Rd;
   end
end

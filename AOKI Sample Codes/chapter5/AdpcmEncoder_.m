function c=AdpcmEncoder_(x,Rx,B)
length_of_x=length(x);
c=zeros(1,length_of_x);
max_of_c=power(2,B-1)-1;
min_of_c=-power(2,B-1);
xp=0;
Rd=Rx/4;
max_of_Rd=Rx;
min_of_Rd=Rx/256;
for n=1:length_of_x,
   d=x(n)-xp;
   if d>=0
      sign_of_d=1;
   else
      sign_of_d=-1;
   end
   abs_of_d=abs(d);
   c(n)=sign_of_d*round(power(2,B-1)*log10(9*abs_of_d/Rd+1));
   if c(n)>max_of_c
      c(n)=max_of_c;
   elseif c(n)<min_of_c
      c(n)=min_of_c;
   end
   if c(n)>=0
      sign_of_c=1;
   else
      sign_of_c=-1;
   end
   abs_of_c=abs(c(n));
   dp=sign_of_d*round(Rd*(power(10,abs_of_c/power(2,B-1))-1)/9);
   xp=xp+dp;
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

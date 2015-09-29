function c=LogPcmEncoder_(x,R,B)
length_of_x=length(x);
c=zeros(1,length_of_x);
max_of_c=power(2,B-1)-1;
min_of_c=-power(2,B-1);
for n=1:length_of_x,
   if x(n)>=0
      sign_of_x=1;
   else
      sign_of_x=-1;
   end
   abs_of_x=abs(x(n));
   c(n)=sign_of_x*round(power(2,B-1)*log10(9*abs_of_x/R+1));
   if c(n)>max_of_c
      c(n)=max_of_c;
   elseif c(n)<min_of_c
      c(n)=min_of_c;
   end  
end

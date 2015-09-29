function c=PcmEncoder_(x,R,B)
length_of_x=length(x);
c=zeros(1,length_of_x);
step_size=R*2/power(2,B);
max_of_c=power(2,B-1)-1;
min_of_c=-power(2,B-1);
for n=1:length_of_x,
   c(n)=round(x(n)/step_size);
   if c(n)>max_of_c
      c(n)=max_of_c;
   elseif c(n)<min_of_c
      c(n)=min_of_c;
   end  
end

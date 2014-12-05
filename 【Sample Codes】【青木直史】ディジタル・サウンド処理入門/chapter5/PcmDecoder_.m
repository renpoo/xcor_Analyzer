function x=PcmDecoder_(c,R,B)
length_of_c=length(c);
x=zeros(1,length_of_c);
step_size=R*2/power(2,B);
for n=1:length_of_c,
   x(n)=c(n)*step_size;
end

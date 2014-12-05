function s1=Function03_(s0,length_of_s,a,d,rs)
s1=zeros(1,length_of_s);
for n=1:length_of_s,
   for k=1:rs+2,
      if n-d(k)>0
         s1(n)=s1(n)+a(k)*s0(n-d(k));
      end
   end
end

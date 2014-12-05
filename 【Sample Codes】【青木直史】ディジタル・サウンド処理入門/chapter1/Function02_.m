function d=Function02_(dp,ds,rs)
d=zeros(1,rs+2);
d(1)=0;
d(2)=dp;
for k=1:rs,
   d(k+2)=d(k+1)+ds;
end

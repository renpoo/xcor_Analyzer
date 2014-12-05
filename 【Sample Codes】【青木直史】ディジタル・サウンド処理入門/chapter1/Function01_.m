function a=Function01_(ap,as,rs)
a=zeros(1,rs+2);
a(1)=1;
a(2)=ap;
for k=1:rs,
   a(k+2)=a(k+1)*as;
end

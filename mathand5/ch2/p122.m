[xx,yy]=meshgrid(-2:.2:2,-2:.2:2);
zz=(xx+yy).*exp(-xx.^2-yy.^2);
zzsize=size(zz);
u=zeros(zzsize(1),zzsize(2),50);
for i=1:50;u(:,:,i)=zz.*(i-50);end
%%%%%%%%%%%%%u%%%%%%%%%%%%%%%%%%
usize=size(u);
[x,y,z]=meshgrid(1:usize(2),1:usize(1),1:usize(3));
slice(x,y,z,u,usize(2),[usize(1)/2 usize(1)],[1 usize(3)/2])

load clown
[x,y]=meshgrid(-2:.2:2,-2:.2:2);z=(x+y).*exp(-x.^2-y.^2);
figure('colormap',map)
surfhandle=surf(x,y,z)
set(surfhandle,'Facecolor','texture','cdata',X)
set(surfhandle,'erasemode','background');
set(gca,'drawmode','fast')
shading flat
u1=uicontrol('style','slider','pos',[40 20 100 20],...
'max',180,'min',-180,'value',-37.5,...
'callback','AZ=get(u1,''value'');EL=get(u2,''value'');view(AZ,EL)');
u2=uicontrol('style','slider','pos',[20 40 20 100],...
'max',180,'min',-180,'value',30,...
'callback','AZ=get(u1,''value'');EL=get(u2,''value'');view(AZ,EL)');

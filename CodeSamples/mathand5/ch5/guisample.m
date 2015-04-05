close all;clear all
fig1=figure;
plt1=plot(rand,rand,'p',rand,rand,'p','markersize',50);
axis([0 1 0 1]);axis square;
btn=0;
set(fig1,'units','normal');set(gca,'units','normal');
set(gca,'drawmode','fast');
set(findobj(0,'erasemode','normal'),'erasemode','xor');
set(fig1,'windowbuttondownfcn','btn=1;guisample2(1);');
set(fig1,'windowbuttonmotionfcn','if(btn==1) guisample2(2);end');
set(fig1,'windowbuttonupfcn','btn=0;guisample2(3);');

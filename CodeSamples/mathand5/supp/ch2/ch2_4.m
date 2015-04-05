x = 10.^[(0:(10-2))/(10-1),1];
y=x;
semilogx(x,y,'-o','linewidth',5);
grid on
%別解 logspace関数を使ってもよい．　ｘ軸の間隔が等間隔になっている．
x=logspace(0,1,10);
y=x;
semilogx(x,y,'-o','linewidth',5);
grid on





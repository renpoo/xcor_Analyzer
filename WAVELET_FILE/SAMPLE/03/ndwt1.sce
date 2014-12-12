// 雑音除去
clf;
s=sin(20.*linspace(0,%pi,1000))+0.2*rand(1,1000);	//  信号
figure(1)
plot(s)			// 雑音が重畳した信号
xgrid(1);
//
figure(2);
[cA,cD]=dwt(s,'haar');	// 離散ウェーブレット変換
xsetech([0,0.5,1,0.45]);
plot(cA);			// 近似係数
xgrid(1);
xsetech([0,0,1,0.45]);
plot(cD);			// 詳細係数
xgrid(1);

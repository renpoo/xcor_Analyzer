//　dwt変換によるフィルターの影響の調査
clc;			// コンソールをクリアーする。
stacksize('max');
xset('window',0);clf(0);
waven=input('使用するウェーブレットは？：','s');
//
noise = wnoise(5,9);		// 雑音の作成
//
nsample = 0.1*noise;		// 雑音
plot2d(nsample);
xgrid(1);
title('源信号の波形');
xset('window',1);clf(1);
// dwt変換
[cA,cD]=dwt(nsample,waven);
xsetech([0,0.5,1,0.45]);
plot(cA);			// 近似係数
xgrid(1);
title('近似係数');
xsetech([0,0,1,0.45]);
plot(cD);			// 詳細係数
xgrid(1);
TITLES='ウェーブレット関数 '+waven+' の詳細係数';
title(TITLES);
//

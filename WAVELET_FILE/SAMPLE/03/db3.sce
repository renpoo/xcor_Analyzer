//　cwt変換によるフィルターの影響の調査
clc;
stacksize('max');
xset('window',0);clf(0);
waven=input('使用するウェーブレットは？：','s');
noise = wnoise(5,9);			// 雑音の作成
//
nsample = 0.1*noise;			// 雑音
plot2d(nsample);
xgrid(1);
title('源信号の波形');
xset('window',1);clf(1);
// dwt変換
coef=cwt(nsample,1:128,waven);		// cwt変換、ウェーブレット係数
surf(coef);				//
xgrid(1);
TITLES='ウェーブレット関数 '+waven+' の cwt';
title(TITLES);
//

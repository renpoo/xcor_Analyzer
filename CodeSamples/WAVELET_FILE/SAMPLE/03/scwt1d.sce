//
stacksize('max');
s=[1:800];						// サンプル数
//
freqbrk = sin(2*%pi*s/100)+sin(3*%pi*s/100); 		//基本の正弦波を作成
scalef=1:1:128;		// スケールファクター
waven='gaus5';		// ウェーブレット関数名
//
xset('window',0);clf(0);
c=cwt(freqbrk,scalef,waven);				// 連続ウェーブレット変換
surf(c);						// 変換結果の3D表示
xgrid(1);
title('連続ウェーブレット');
//
xset('window',1);clf(1);
cwtplot(c,scalef);		// ウェーブレット係数
set(gca(),'grid',[1 1]*color('gray'));
xgrid(1);
title("Wavelet Analys")
xlabel('Time')
ylabel('Scale Factor')
//

//　cwt変換による分析プログラム
clc;					// コンソールをクリアーする。
clf;					// 画像クリアー
stacksize('max');			// スタックを確保
// 擬似信号　正弦波＋ランダムノイズ
signal=5*sin(20.*linspace(0,%pi,1000))+rand(1,1000);	// 1000ポイント
//
disp('データサイズ=',length(signal));
waven=input('使用するウェーブレットは？：','s');
//
numb=input('スケール？：');				// 分解レベルの数を入力する。
start=input('最初のサンプルポイント？：');		// 最初のサンプルポイント。
last=input('最後のサンプルポイント？：');		// 最後のサンプルポイント。
bitt=input('間引き数？：');				// 間引きサンプルポイント。
//
scale=1:numb;				//　スケールの設定
// continous wavelet transform
coef=cwt(signal(start:bitt:last),scale,waven);		// cwt変換
surf(coef);						// 3D表示
xgrid(1);
title('cwt変換の3D表現 ― 雑音を含んだ正弦波');
//
cwtplot(coef,scale);					//係数の表示
title('cwt変換の係数 ― 雑音を含んだ正弦波');
//
title('使用したウェーブレットは '+waven);
//

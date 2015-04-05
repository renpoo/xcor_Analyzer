//　N レイヤー dwt変換による分析プログラム
clc;					// コンソールをクリアーする。
clf;					// 画像クリアー
stacksize('max');			// スタックを確保
// 以下の部分を書き換えることで信号を変更して処理を観測できます。
//s=[1:2048];                		// サンプル数　
//signal = sin(2*%pi*s/100)+sin(10*%pi*s/100);     //　基本の正弦波を作成します
signal=5*sin(20.*linspace(0,%pi,1000))+rand(1,1000);    // 1000ポイント
//
disp('データサイズ=',length(signal));
waven=input('使用するウェーブレットは？：','s');
//
N=input('分解レベル？：');				// 分解レベルの数を入力する。
start=input('最初のサンプルポイント？：');		// 最初のサンプルポイント。
last=input('最後のサンプルポイント？：');		// 最後のサンプルポイント。
[C,L]=wavedec(signal,N,waven);
// 信号のプロット 
subplot(311), plot(signal); 
a=gca();a.data_bounds=[1 length(signal) -10 10];
xgrid(1);
title('元の信号'); 
// Nレベルの近似係数、分解レベルN
A=appcoef(C,L,waven,N);
subplot(312), plot(A), a=gca();a.data_bounds=[start last -10 10];        // 画面の構成
title('近似係数');
xgrid(1);
// Nレベルの詳細係数、分解レベルN
D = wrcoef('d',C,L,waven,N);
subplot(313), plot(D), a=gca();a.data_bounds=[start last -1.0 1.0]; 
title('詳細係数');
xgrid(1);
//

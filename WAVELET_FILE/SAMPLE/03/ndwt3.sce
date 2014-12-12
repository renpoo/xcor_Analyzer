// 雑音除去
clf;
signal=sin(20.*linspace(0,%pi,1000))+0.2*rand(1,1000);    // 1000ポイント
//
waven=input('使用するウェーブレットは？：','s')
N=input('分解レベル？：');	// 分解レベルの数を入力する。
[C,L]=wavedec(signal,N,waven);
plot(signal),title('Original');
xgrid(1);
figure(1);
//
// 1次元の近似係数、分解レベルN
A=appcoef(C,L,waven,N);
plot(A);
title('使用したウェーブレットは '+waven);
xgrid(1);
//

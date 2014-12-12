// 1 次元ウェーブレット変換
clf;
//　まず単純な波形を作成します。
x = 0:4;
 y = zeros(1,5);
  y(3) = 2; 
  t = linspace(0,4,2^9);
sample = interp1(x,y,t);
xset('window',0);
plot2d(sample);				// 作成した波形の表示
title('オリジナルの波形');
xgrid(1);
// 雑音を作成し調教します。
noise = wnoise(5,9);				// 雑音の作成
nsample = sample+0.1*noise;			// 雑音を重ねます。
xset('window',1);				// 二つ目のグラフ
plot(nsample)					// 雑音を含んだ信号の波形
xgrid(1);」
xset('window',2);
// cwt変換を行い、結果を表示します。
c = cwt(sample,1:32,'DOG');		// スケールファクターは [1:32] としています。
surf(c);				// cwt表示
title('cwt波形 3D表示');
xgrid(2);
xset('window',3);
// dwt変換を行います。
[cA1,cD1]=dwt(nsample,'db3');
ls=length(nsample);
A1=upcoef('a',cA1,'db3',1,ls);
D1=upcoef('d',cD1,'db3',1,ls);
// dwt 逆変換
A0=idwt(cA1,cD1,'db2',ls);
xsetech([0,0,1,0.45]);
plot(A0);				// 近似係数
xgrid(1);
xsetech([0,0.5,1,0.45]);
plot(D1);				// 詳細係数
xgrid(1);
title('figure2');
// 多レベルのウェーブレット変換（３レベル）を行います
[C,L]=wavedec(nsample,3,'db3');		// 3レベルのウェーブレット変換
cA3=appcoef(C,L,'db3',3);
cD3=detcoef(C,L,3); cD2=detcoef(C,L,2); cD1=detcoef(C,L,1);
//
A3=wrcoef('a',C,L,'db3',3);
D1=wrcoef('d',C,L,'db3',1);
D2=wrcoef('d',C,L,'db3',2);
D3=wrcoef('d',C,L,'db3',3);
xset('window',4);
// 出来上がった詳細係数などの表示を行います。MATLABの場合は xsetetch を　subplot で記述します。
xsetech([0,0,1,0.2]);
plot(A3); xgrid(1);
xsetech([0,0.25,1,0.2]);
plot(D1); xgrid(1);
xsetech([0,0.5,1,0.2]);
plot(D2); xgrid(1);
xsetech([0,0.75,1,0.2]);
plot(D3); xgrid(1);
title('figure3');
//

// 
clf;
s=[1:100];				// データ領域の確保。サンプル数。
a = sin(2*%pi*s/100)+sin(3*%pi*s/100);	// 基本の正弦波を作成
// ウェーブレット変換を行います。3レベルに指定。
[C,L] = wavedec(a,3,'haar');
// 3つのレベルにCから近似係数を求める。
cA3 = appcoef(C,L,'haar',3);
// C からレベル3, 2,と1 の詳細係数を求める
cD3 = detcoef(C,L,3);
cD2 = detcoef(C,L,2);
cD1 = detcoef(C,L,1);
// 上記の３行は以下の様にまとめることができます。
//  [cD1,cD2,cD3] = detcoef(C,L,[1,2,3]);
//  C からレベル３の近似係数を求める
A3 = wrcoef('a',C,L,'haar',3);
// Cからレベル123のdetails を求める
D1 = wrcoef('d',C,L,'haar',1);
D2 = wrcoef('d',C,L,'haar',2);
D3 = wrcoef('d',C,L,'haar',3);
// 出来上がった係数などの表示を行います。一つのグラフに４つ表示します。
xsetech([0,0,1,0.2]);
plot(A3);
xgrid(1);
xsetech([0,0.25,1,0.2]);
plot(D1);
xgrid(1);
xsetech([0,0.5,1,0.2]);
plot(D2);
xgrid(1);
xsetech([0,0.75,1,0.2]);
plot(D3);
xgrid(1);

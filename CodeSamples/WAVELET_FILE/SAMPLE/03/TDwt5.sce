//　逆変換の実施
clf;
s=[1:100];				// サンプル数　⇒　100個
a = sin(2*%pi*s/100)+sin(3*%pi*s/100);	//　基本の正弦波を作成します
// 次にウェーブレット変換を行います
[C,L] = wavedec(a,3,'haar');
// level 3 approximation coecients from C,:
cA3 = appcoef(C,L,'haar',3);
//  levels 3, 2, and 1 detail coecients from C
cD3 = detcoef(C,L,3);
cD2 = detcoef(C,L,2);
cD1 = detcoef(C,L,1);
// 上記の３行は以下の様にまとめることができます。
// [cD1,cD2,cD3] = detcoef(C,L,[1,2,3]);
// 詳細係数の再構成
D1 = wrcoef('d',C,L,'haar',1);
D2 = wrcoef('d',C,L,'haar',2);
D3 = wrcoef('d',C,L,'haar',3);
// もとの信号にもどすために逆ウェーブレット変換を行います。
A = waverec(C,L,'haar');
// もとの信号を表示します。
plot(A)

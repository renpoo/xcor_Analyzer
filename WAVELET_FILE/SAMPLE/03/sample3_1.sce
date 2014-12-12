// 
clf;
 x=linspace(-%pi,%pi,10000);	// 信号の範囲とサンプルポイント
 s=sin(x);			// 与えられた信号。正弦波
 [ca1,cd1] = dwt(s,'haar');		// ウェーブレット変換。ウェーブレット関数名はhaarを使用。 
// .
xsetech([0,0.5,1,0.45]);
plot(cd1);			// 詳細係数の表示
xgrid(1);
xsetech([0,0,1,0.45]);
plot(ca1);			// 近似係数の表示
xgrid(1);

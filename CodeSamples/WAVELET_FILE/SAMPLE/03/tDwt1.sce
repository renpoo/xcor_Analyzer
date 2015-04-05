clf;
 x=linspace(-%pi,%pi,10000);	// サンプルデータ 10000ポイント
 s=sin(x); 			// 正弦波の信号データを作成します。
 [ca1,cd1] = dwt(s,'db2');	// ウェーブレット関数名db2を使用
xsetech([0,0.5,1,0.45]) 
plot(cd1);
xgrid(1);				// 目盛り
xsetech([0,0,1,0.45]);
plot(ca1);
xgrid(1);

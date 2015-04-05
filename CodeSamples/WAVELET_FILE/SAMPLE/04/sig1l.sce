// お寺の読経
// 太鼓の音、読経の声、騒音の処理
clf;
stacksize('max');		// メモリー領域の確保
y=loadwave("kane1.wav");	// wav形式のデータをロードする。
figure();
subplot(2,1,1)
plot(y(1:8192*8))		// 元の信号の表示
xgrid(1);
title(" Original Signal");
Y=fft(y);			// フーリエ変換により周波数領域に変換
Pyy=Y.*conj(Y)/512;		// スペクトル密度conj－複素共役
f=1000*(0:511)/512;
subplot(2,1,2)
plot(f,Pyy(1:512));		// スペクトラムの表示
title(" spectrum")
xlabel("(Hz)")
xgrid(1);
figure(1);
//----------------------- dwt 変換 ------------------------------------------
// ウェーブレット関数
wname='db2';
[ca1 cd1] = dwt(y(1:2048),wname);
// ウェーブレット変換の結果の表示
subplot(2,1,2)
plot(cd1);
xgrid(1);
subplot(2,1,1)
plot(ca1);
xgrid(1);
title('離散ウェーブレット変換　近似係数　詳細係数');

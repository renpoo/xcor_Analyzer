// お寺の読経
// 太鼓の音、読経の声、騒音の処理
clf;
y=loadwave("kane1.wav");    // wav形式のデータをロードする。
figure();
subplot(2,1,1)
plot(y(1:8192*8))    // 元の信号
xgrid(1);
title(" Original Signal");

Y=fft(y); 			// フーリエ変換により周波数領域に変換
Pyy=Y.*conj(Y)/512;		// スペクトル密度
f=1000*(0:511)/512;

subplot(2,1,2)
plot(f,Pyy(1:512))
title(" spectrum")
xlabel("(Hz)")
xgrid(1);

// ２つの信号のスペクトラム表示
// この例では 50Hzの信号が変化します。
clf;
clear
stacksize('max');
t=0:0.001:0.512;				// サンプリング周期　0.001
ts=1:0.003:2.536;				// 揺らぎの信号
y=sin(2*%pi*50*t.*ts)+0.2*sin(2*%pi*400*t); 	// 50Hzの信号,400Hzの信号の合成
figure(1);
subplot(2,1,1)
plot(y(1:512))					// 元の信号
xgrid(1);
title(" Original Signal");
Y=fft(y); 					// 512フーリエ変換により周波数領域に変換
Pyy=Y.*conj(Y)/512;				// スペクトル
f=1000*(0:511)/512;
subplot(2,1,2)
plot(f,Pyy(1:512));				// スペクトルの表示
title(" spectrum")
xlabel("(Hz)")
xgrid(1);
figure(2);
// cwt 変換 ------------------------------------------
scale=[1:128]				// scale factor
coef=cwt(y,scale,'gaus5');		//  cwt変換
surf(coef);				//  surf   3D表示を行います。
xgrid(1);
xtitle('cwt変換の3D表現');
//
cwtplot(coef,scale);			// cwtの結果の 2D 表示
xtitle('cwt変換の係数');

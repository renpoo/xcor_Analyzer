// サンプル信号のスペクトラム表示と離散ウェーブレット変換の結果
clf;
t=0:0.001:0.512; // サンプリング周波数1000Hz
y=sin(2*%pi*50*t)+0.5*sin(2*%pi*400*t);		// 50Hzと,400Hzの信号
figure(1);
subplot(2,1,1)
plot(y(1:512))					// 信号の表示
xgrid(1)
title(" Original Signal");
// 
// FFT表示
Y=fft(y);					// 512フーリエ変換により周波数領域に変換
Pyy=Y.*conj(Y)/512;				// スペクトル
f=1000*(0:511)/512;
subplot(2,1,2)
plot(f,Pyy(1:512))
title(" spectrum   f1=50Hz, noise=400Hz")
xlabel("(Hz)")
xgrid(1)
//------------------------------------------
// ウェーブレット関数の値
p = [0.482962913145 0.836516303738 0.224143868042 -0.129409522551];
sup=length(p); // 数列の長さ
q = - ( (-1).^(1:sup) ).*p(sup:-1:1);
//
g = p;
h = q;
ss=y(1:512);					// Origial signalの配列から一部コピー
[ca1,cd1]  = dwt(ss, g, h);			// 離散ウェーブレット変換を実行
figure(2);
subplot(2,1,2)
plot(cd1);					// 近似係数の表示
xgrid(1)
subplot(2,1,1)
plot(ca1);					// 詳細係数の表示
xgrid(1)
title('離散ウェーブレット変換　近似係数と詳細係数');

% サンプル信号とそのスペクトラムの表示
t=0:0.001:0.512;				% サンプリング周期0.001
y=sin(2*pi*50*t)+0.5*sin(2*pi*400*t); 	% 50Hzの信号,400Hzの信号

figure(1);
subplot(2,1,1)
plot(y(1:512))				// 
axis([0, 512, -1.5,  1.5]);
title(" Original Signal");
xlabel("samples NO.")
%% FFTの結果の表示
Y=fft(y,512);			%% 512フーリエ変換により周波数領域に変換
Pyy=Y.*conj(Y)/512;		%% スペクトル密度
f=1000*(0:511)/512;
subplot(2,1,2)
plot(f,Pyy(1:512))
title(" spectrum   f1=50Hz, noise=400Hz")
xlabel("(Hz)")
%%

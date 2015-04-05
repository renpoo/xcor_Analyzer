% ２つの信号のスペクトラムの表示
% この例では 50Hzの信号が変化します。
clear
t=0:0.001:0.512;					%% サンプリング周期　0.001
ts=1:0.003:2.536;
y=sin(2*pi*50*t.*ts)+0.2*sin(2*pi*400*t);		% 50Hzの信号,400Hzの信号
figure(1);
subplot(2,1,1)
plot(y(1:512))					%% 元の信号
axis([0, 512, -1.5,  1.5]);
title(" Original Signal");
Y=fft(y,512); % 512フーリエ変換により周波数領域に変換
Pyy=Y.*conj(Y)/512;				%% Pyyのスペクトル
f=1000*(0:511)/512;
subplot(2,1,2)
plot(f,Pyy(1:512))
title(" spectrum")
xlabel("(Hz)")
figure(2);
%------------------------------------------
% ウェーブレット関数
p = [0.482962913145 0.836516303738 0.224143868042 -0.129409522551];
sup=length(p);
q = - ( (-1).^(1:sup) ).*p(sup:-1:1);
g = p;
h = q;
[ca1 cd1] = dwt(y, g, h);
%% ウェーブレット変換の結果の表示
subplot(2,1,2)
plot(cd1);
subplot(2,1,1)
plot(ca1);
title('After dwt .cA and cD');

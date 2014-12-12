// 総持寺の太鼓の音
// ウェーブレット変換と再構成
clf;
stacksize('max');
y=loadwave("kane1.wav");    // wav形式のデータをロードする。
//
subplot(2,1,1)
plot(y(1:8192*8))    // 元の信号
xgrid(1);
title(" 元の信号");
subplot(2,1,2)
title('逆変換の結果');
//------------------------------------------
// dwt 変換 --------------------- ウェーブレット関数
wname='db2';
[ca1 cd1] = dwt(y(1:8192),wname);
// 逆変換を行います。
ss = idwt(ca1,cd1,wname);    // 逆ウェーブレット変化を行います。
//
subplot(2,1,2)
plot(ss);			// 逆変換された信号を表示します。
title('逆変換の結果');
xgrid(1);
// 音を再生してみます。
playsnd(ss);

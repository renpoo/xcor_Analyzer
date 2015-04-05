// 総持寺の太鼓の音
// ウェーブレット変換でノイズ削除
clf;
stacksize('max');
y=loadwave("kane1.wav");		// wav形式のデータをロードする。
//
subplot(211)
plot(y(1:8192*4))			// 元の信号
xgrid(1);
title(" 元の信号");
//
level=6;		// ＜注意＞スレッシュホールドレベルが6を超えると波形にひずみが増える
xd = wden(y(1:8192*4),'rigrsure','s','one',level,'db2');
// ２つのスペクトラムの表示
subplot(212)
plot(xd);				//雑音除去後の信号を表示します。
xgrid(1);
figure(1);
subplot(121)				// 左に表示
analyze(y(1:8192*4),10,500);
title('変換前のスペクトラム');
xlabel('周波数 Hz');
xgrid(1);
//
subplot(122)				// 左に表示
analyze(xd(1:8192*4),10,500);
xlabel('周波数 Hz');
title('逆変換後のスペクトラム');
xgrid(1);
//

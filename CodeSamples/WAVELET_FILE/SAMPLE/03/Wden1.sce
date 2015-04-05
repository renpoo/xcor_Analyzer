// wden の雑音除去
clf;
mode(-1);
lines(0);
// ランダム雑音の初期値
snr = 3; init = 31456615866;
// 雑音の作成 .xrefは作成された信号、xはノイズを含んだ信号
[xref,x] = wnoise(4,12,snr,init);
//  雑音除去のスレッシュホールド
level = 4;
// ノイズ除去作業
xd = wden(x,'heursure','s','one',level,'sym8');
// 信号のプロット 
subplot(311), plot(xref); 
a=gca();a.data_bounds=[1 2048 -10 10];
title('元の信号'); 
subplot(312), plot(x), a=gca();a.data_bounds=[1 2048 -10 10];		// 画面の構成
title(['ノイズ ratio = ',... 
string(fix(snr))]); 
subplot(313), plot(xd), a=gca();a.data_bounds=[1 2048 -10 10];
title('雑音除去後'); 
// 雑音削除　ソフト、スレッシュホールドレベル = level
xd = wden(x,'heursure','s','one',level,'sym8');

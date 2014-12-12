//wavedec と雑音除去
clf;
mode(-1);
// ランダムの初期値
snr =3; init = 31456615866;
// 雑音の作成 
[xref,x] = wnoise(4,12,snr,init);
//  雑音除去のスレッシュホールド。ソフトスレッシュホールド指定
level =6;
xd = wden(x,'heursure','s','one',level,'sym8');
//
subplot(311), plot(x), a=gca();a.data_bounds=[1 2048 -10 10];
title(['ノイズ ratio = ',... string(fix(snr))]); 
subplot(312), plot(xd), a=gca();a.data_bounds=[1 2048 -10 10];
TITLES={'スレッシュホールドレベル',..string(fix(level))};
title(TITLES);
// 雑音削除　ソフト、スレッシュホールドレベル = level 2
level =2;
xd = wden(x,'heursure','s','one',level,'sym8');
//
subplot(313), plot(xd), a=gca();a.data_bounds=[1 2048 -10 10];
TITLES={'スレッシュホールドレベル',..string(fix(level))};
title(TITLES);
//

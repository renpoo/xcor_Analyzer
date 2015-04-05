// 雑音の作成 
[xref,x] = wnoise(5,12,snr,init);

//  雑音除去のスレッシュホールド
level =2;
xd = wden(x,'minimaxi','s','one',level,'sym8');

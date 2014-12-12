// 正弦波とランダムノイズ
scf();
clf
// ランダムの初期値
snr =3; init = 31456615866;
// 雑音の作成 
[xref,x] = wnoise(4,12,snr,init);
//
thr=35;
// 圧縮　スレッシュホールド値を使用（上記） レベル４、ハードスレッシュホールドにします
[xcomp,cxd,lxd,perf0,perfl2] = wdencmp('gbl',x,'db3',4,thr,'h',1);
// グローバル値のスレッシュホールドは
// thr  =  15.62813
[thr,sorh,keepapp] = ddencmp('den','wv',x);
// 上記のスレッシュホールド値によるノイズ除去。ソフトスレッシュホールド
xd = wdencmp('gbl',x,'db3',4,thr,sorh,keepapp);
//
plot(x);
plot(xcomp,'r');	// 圧縮データ
//plot(xd,'r')		// 雑音除去を見る時はコメントをはずす
plot(xref,'g');		// 元の信号
legend(["noisy signal","compressed signal","original ref,signal"],1);
xgrid(1);            
 title('雑音付き信号の圧縮');

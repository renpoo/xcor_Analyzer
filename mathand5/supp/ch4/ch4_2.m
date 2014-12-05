% ステップ応答のシミュレーション
[numd,dend]=c2dm(1,[2,1],0.01);%時定数２のローパスフィルタをサンプル時間0.01秒でc2dm関数を使い離散値化
tffunc=tf(1,[2,1]);%時定数２のローパスフィルタ
t=0:0.01:10; %10秒間のシミュレーション
yd=filter(numd,dend,ones(size(t)));
yc=lsim(tffunc,ones(size(t)),t);
subplot(2,1,1);plot(t,yd,t,yc,[2,2],[0,1]);
xlabel('Time[sec]');legend('Discrete','Continuous');
subplot(2,1,2);plot(t,yd(:)-yc(:));
ylabel('Error');xlabel('Time[sec]');

%連続系と離散系でのシミュレーション、差がほとんどないため、誤差を表示している。10の－15乗程度であるため実用上は問題ないことが確認できる。

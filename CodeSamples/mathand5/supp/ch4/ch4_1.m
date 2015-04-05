% ステップ応答のシミュレーション
tffunc=tf(1,[2,1]);%時定数２のローパスフィルタ
t=0:0.01:10; %10秒間のシミュレーション
y=lsim(tffunc,ones(size(t)),t);
subplot(2,1,1);plot(t,y,[2,2],[0,1]);xlabel('Time[sec]');
subplot(2,1,2);plot(t,step(tffunc,t),[2,2],[0,1]);xlabel('Time[sec]');

%2秒のとき、63%の立ち上がりになるはず。step関数による応答も、lsim関数による応答も同じ。
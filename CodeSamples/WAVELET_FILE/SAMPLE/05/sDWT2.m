% サンプル信号
% 正弦波にランダムノイズを重ねます。1000ポイントのデータです。
y=sin(20.*linspace(0,pi,1000))+0.2*rand(1,1000);	%%  雑音を含んだ信号の作成
figure(1);
plot(y)
title(" Original Signal");
%%------------------------------------------
p = [0.707106781 0.707106781];
sup=length(p); % 数列の長さ
 q = - ( (-1).^(1:sup) ).*p(sup:-1:1); % 
%%
[ca1,cd1]  = dwt(y, p, q);				%% 離散ウェーブレット変換　1回目
figure(2);
subplot(2,1,2)
plot(cd1);
subplot(2,1,1)
plot(ca1);
title('After dwt .cA and cD, 1st stage, 1st stage');

[ca2,cd2]  = dwt(ca1, p, q);			%% 離散ウェーブレット変換　2回目
figure(3);
grid on;
subplot(2,1,2)
plot(cd2);
subplot(2,1,1)
plot(ca2);					%% 近似係数の表示
title('After dwt .cA and cD 2nd stage');

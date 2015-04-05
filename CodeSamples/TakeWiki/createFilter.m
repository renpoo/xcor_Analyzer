Ft = 22050;   % サンプリング周波数(Hz)
T = 1/Ft;   % サンプリング周期(sec)
Fn = Ft/2;  % ナイキスト周波数(Hz)
Fs1 = 2792.4; Ws1 = 2*pi*Fs1;
Fs2 = 2892.4; Ws2 = 2*pi*Fs2;
Fs3 = 8477.1; Ws3 = 2*pi*Fs3;
Fs4 = 8577.1; Ws4 = 2*pi*Fs4;
% プリワーピイング
Ws1p = 2/T*tan(Ws1*T/2);
Ws2p = 2/T*tan(Ws2*T/2);
Ws3p = 2/T*tan(Ws3*T/2);
Ws4p = 2/T*tan(Ws4*T/2);
% ５次のアナログ基準LPFを作成する
n = 5;
[z, p, g] = butter(n,1,'s');
% 基準LPFからバンドパスフィルタへの変換
[Z, P, G] = sftrans(z,p,g,[Ws1p Ws2p],true);
#sys1 = zp2sys(Z, P, G, T);
sys1 = zpk(Z, P, G, T);
[Z, P, G] = sftrans(z,p,g,[Ws3p Ws4p],true);
#sys2 = zp2sys(Z, P, G, T);
sys2 = zpk(Z, P, G, T);

[b, a] = sys2tf(sysmult1(sys1, sys2));
[Zb, Za] = bilinear(b, a, 1/Ft);
MyFreqz(Zb, Za, Ft);    % プロット

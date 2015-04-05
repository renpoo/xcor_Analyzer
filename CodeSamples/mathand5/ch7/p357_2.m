Fs = 11025;
r = audiorecorder(Fs, 16, 1);
recordblocking (r,3); % マイクに向かって話す..
y = getaudiodata(r, 'int16'); % データをint16 配列として取得
t=((1:length(y))-1)/Fs;
p=audioplayer(y,Fs)
play(p);
plot(t,y);

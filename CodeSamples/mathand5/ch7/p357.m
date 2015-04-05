Fs = 11025;
r = audiorecorder(Fs, 16, 1);
recordblocking (r,3); % マイクに向かって話す..
y = getaudiodata(r, 'int16'); % データを int16 配列として取得
p=audioplayer(y,Fs)
play(p);

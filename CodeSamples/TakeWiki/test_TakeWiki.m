pkg load io;
pkg load signal;
pkg load audio;
pkg load control;
pkg load miscellaneous;


% WAVファイルをロードして時間軸応答を表示します。
[noised_sig,Fs] = wavread('voice_howling.wav');
#sound(noised_sig,Fs);


% 時間軸応答の表示
[noised_sig,Fs] = wavread('voice_howling.wav');
t = (0:length(noised_sig)-1)/Fs;
figure
plot(t,noised_sig),grid on
xlim([0 t(end)]),ylim([-1 1])
title('voice+howling noize time domain response'),xlabel('Time(sec)'),ylabel('Magnitude')


% ノイズ信号の周波数応答の表示
figure
subplot(2,1,1)
[s1, f1] = periodogram(noised_sig, hamming(length(noised_sig)), length(noised_sig), Fs);
plot(f1, 20*log10(s1),'m-.'),grid
xlim([0 f1(end)])
title('Periodogram'),xlabel('Frequency(Hz)'),ylabel('Power/Frequency（dB/Hz）')
subplot(2,1,2)
specgram(noised_sig, 512, Fs, hamming(512), 256)
title('Spectrogram'),xlabel('Frequency(Hz)'),ylabel('Time(sec)')


script = "createFilter.m"
source(script)
saveAndShowPlot('BRF.png')

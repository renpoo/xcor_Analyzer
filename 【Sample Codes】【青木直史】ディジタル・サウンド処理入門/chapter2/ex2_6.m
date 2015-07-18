clear;
fs=8000;
window_size=256;
shift_size=64;
s=wavread('guitar.wav');
[S,time,frequency]=Spectrogram_(s,fs,window_size,shift_size);
imagesc(time,frequency,S);
axis xy;

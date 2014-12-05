% sample program esound.m
clear;figure(1);
load gong;% This is MATLAB DEMO sample sound
sound(y,Fs);
%S = spectrogram(X,WINDOW,NOVERLAP,NFFT,Fs)
T=1/Fs;spectrogram(y,256,100,256,1/T);colorbar

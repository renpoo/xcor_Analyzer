# test_tachiAC_whiteNoise256.m
clear;
N = 512;
x = randn(N, 1);
fs = 1/N;
#[x,fs,bits] = wavread(wavFileName);
sound(x,fs);
#N = length(x);
#nonScaleFlag = 0;
nonScaleFlag = 1;


tic();
[rxx0, rxx1, rxx2, rxx3, m] = test_tachiAC_driver(x, N, nonScaleFlag);
toc();

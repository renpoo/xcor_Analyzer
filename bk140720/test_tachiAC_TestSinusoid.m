# test_tachiAC_TestSinusoid.m
clear;
wavFileName = "Sounds/TestSinusoid.wav";
[x,fs,bits] = wavread(wavFileName);
sound(x,fs);
#N = length(x);
N = 512;
#nonScaleFlag = 0;
nonScaleFlag = 1;

tic();
[rxx0, rxx1, rxx2, rxx3, m] = test_tachiAC_driver(x, N, nonScaleFlag);
toc();

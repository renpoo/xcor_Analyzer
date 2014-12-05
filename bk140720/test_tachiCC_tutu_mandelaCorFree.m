# test_tachiCC_tutu_mandelaCorFree.m
clear;
#N = 256;
#x = randn(N, 1);
#fs = 1/N;
wavFileName = "Sounds/tutu_mandelaCorFree.wav";
[x,fs,bits] = wavread(wavFileName);
sound(x,fs);
#N = length(x);
N = 512;
#nonScaleFlag = 0;
nonScaleFlag = 1;


tic();
[rxy0, rxy1, rxy2, rxy3, m] = test_tachiCC_driver(x, N, nonScaleFlag);
toc();

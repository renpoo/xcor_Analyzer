# test_Compare_tachiAC_tachiCC_TestSinusoid.m
clear;
wavFileName = "Sounds/TestSinusoid.wav";
[x,fs,bits] = wavread(wavFileName);
sound(x,fs);
#N = length(x);
N = 512;
#nonScaleFlag = 0;
maxlag = N-1;
scale = 3;


tic();
#nonScaleFlag = 1;
#[rxx0, rxx1, rxx2, rxx3, m] = test_tachiAC_driver(x, N, nonScaleFlag);
#[rxy0, rxy1, rxy2, rxy3, m] = test_tachiCC_driver(x, N, nonScaleFlag);
#rxx = rxx3;
#rxy = rxy3;


[rxx,m] = tachi_AutoCorrelation(x, maxlag, scale)
[rxy,m] = tachi_CrossCorrelation(x, maxlag, scale)


diff_AC_CC = rxx .- rxy;


#plot(m, diff_AC_CC, 'b', m, rxx, 'g', m, rxy, 'r');
plot(m, diff_AC_CC, 'b', m, rxy, 'g');


xlabel('Time (ms)'); ylabel('Auto/Cross Correlation Func ()');
toc();

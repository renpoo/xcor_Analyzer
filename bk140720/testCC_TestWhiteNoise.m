clear;
x = "Sounds/TestWhiteNoise.wav";
#s = GenerateSinusoid_(400, 44100, 1, x);
[s,fs,bits]=wavread(x);
sound(s,fs);


tic();
cc1=testCC_org_coreFunc(x, 512, 256);
toc();


tic();
cc2=testCC_coreFunc(x, 512, 256);
toc();


tic();
cc3=testCC_xcorr_coreFunc(x, 512, 256);
toc();

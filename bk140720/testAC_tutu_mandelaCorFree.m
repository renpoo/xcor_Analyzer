clear;
x = "Sounds/tutu_mandelaCorFree.wav";
[s,fs,bits]=wavread(x);
sound(s,fs);


tic();
ac1=testAC_org_coreFunc(x, 512, 256);
toc();


tic();
ac2=testAC_coreFunc(x, 512, 256);
toc();


tic();
ac3=testAC_xcorr_coreFunc(x, 512, 256);
toc();

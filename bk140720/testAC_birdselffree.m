clear;
x = "Sounds/birdselffree.wav";
[s,fs,bits]=wavread(x);
sound(s,fs);


windowsize = 512 * 4;
stepsize = 256;

tic();
ac1=testAC_org_coreFunc(x, windowsize, stepsize);
toc();


tic();
ac2=testAC_coreFunc(x, windowsize, stepsize);
toc();


tic();
ac3=testAC_xcorr_coreFunc(x, windowsize, stepsize);
toc();


time=zeros(1,windowsize);
for m=1:windowsize,
   time(m)=(m-1)*1000/fs;
end
plot(time, ac1, 'b', time, ac2, 'g', time, ac3, 'r');
xlabel('Time (ms)'); ylabel('Auto Correlation Func ()');

# testAC_coreFunc.m
# Base Writer: R.O. Tachibana (July 7, 2014)
# Modified by: Renpoo, TAISO (July 12, 2014)

function ac=testAC_xcorr_coreFunc(x, windowsize, step)


pkg load signal;


[orig,fs,bit] = wavread(x);

#ac = xcorr(orig, orig, windowsize);
ac = xcorr(orig, orig);
[y, h] = resample (ac, windowsize, length(ac)); 
ac = y';
disp(length(ac));

time=zeros(1,windowsize);
for m=1:windowsize,
   time(m)=(m-1)*1000/fs;
end
plot(time, ac);
xlabel('Time (ms)'); ylabel('Auto Correlation Func ()');

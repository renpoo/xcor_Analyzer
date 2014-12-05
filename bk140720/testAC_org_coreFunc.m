# testAC_coreFunc.m
# Base Writer: R.O. Tachibana (July 7, 2014)
# Modified by: Renpoo, TAISO (July 12, 2014)

function ac=testAC_org_coreFunc(x, windowsize, step)
[orig,fs,bit] = wavread(x);

ac = zeros(1,windowsize);
ac = AutoCorrelation_org_(orig, windowsize);
time=zeros(1,windowsize);
for m=1:windowsize,
   time(m)=(m-1)*1000/fs;
end
plot(time, ac);
xlabel('Time (ms)'); ylabel('Auto Correlation Func ()');

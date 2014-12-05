# testCC_coreFunc.m
# Base Writer: R.O. Tachibana (July 7, 2014)
# Modified by: Renpoo, TAISO (July 12, 2014)

function cc=testCC_org_coreFunc(x, windowsize, step)
[orig,fs,bit] = wavread(x);

cc = zeros(windowsize);
cc = CrossCorrelation_org_(orig, windowsize);
time=zeros(1,windowsize);
for m=1:windowsize,
   time(m)=(m-1)*1000/fs;
end
plot(time,cc);

xlabel('Time (ms)'); ylabel('Cross Correlation Func ()');

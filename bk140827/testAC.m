% script file
%  testAC.m
% R.O. Tachibana
% July 7, 2014

[orig,fs,bit] = wavread("Sounds/guitar.wav");
windowsize = 512;
step = 256;
len = length(orig);
nstep = floor((len-windowsize+1)/step);

ACmat = zeros(windowsize,nstep);
for n=1:nstep,
    wav = orig((n-1)*step+(1:windowsize));
    ACmat(:,n) = AutoCorrelation_(wav,windowsize);
end
timevec = ((0:nstep-1)*step+windowsize/2)/fs;
tauvec = (1:windowsize)/fs;
imagesc(timevec,tauvec*1000,ACmat); axis xy;
colorbar; caxis([-1 1]); 
xlabel('Time (s)'); ylabel('Delay (ms)');

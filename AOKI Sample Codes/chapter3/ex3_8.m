clear;
fs=8000;
window_size=128;
x=wavread('guitar_a3.wav');
p=CrossCorrelation_(x,window_size);
time=zeros(1,window_size);
for m=1:window_size,
   time(m)=(m-1)*1000/fs;
end
plot(time,p);
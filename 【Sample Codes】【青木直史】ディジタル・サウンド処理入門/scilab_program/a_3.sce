clear;
window_size=1024;
[s0,fs,bits]=wavread('guitar_2048.wav');
s1=zeros(1,window_size);
for n=1:window_size,
   s1(n)=s0(n);
end
s1=s1.';
wavwrite(s1,fs,bits,'guitar_1024.wav');

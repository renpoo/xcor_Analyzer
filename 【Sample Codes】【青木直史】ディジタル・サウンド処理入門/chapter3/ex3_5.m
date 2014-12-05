clear;
fs=44100;
delta=2000;
fe=fs/4-delta/2;
[b,filter_size]=FirLpf_(fs,fe,delta);
a(1)=1;
x=wavread('guitar_44100.wav');
length_of_x=length(x);
y=filter(b,a,x);
length_of_yd=floor(length_of_x/2);
yd=zeros(1,length_of_yd);
for n=1:length_of_yd,
   yd(n)=y(n*2-1);
end
sound(x,fs);
pause(2);
sound(yd,fs/2);

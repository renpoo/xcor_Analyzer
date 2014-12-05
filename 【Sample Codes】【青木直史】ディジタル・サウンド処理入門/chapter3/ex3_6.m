clear;
fs=44100;
delta=2000;
fe=fs/4-delta/2;
[b,filter_size]=FirLpf_(fs,fe,delta);
a(1)=1;
x=wavread('guitar_22050.wav');
length_of_x=length(x);
length_of_xu=length_of_x*2;
xu=zeros(1,length_of_xu);
for n=1:length_of_x,
   xu(n*2-1)=x(n);
end
y=filter(b,a,xu)*2;
sound(x,fs/2);
pause(2);
sound(y,fs);

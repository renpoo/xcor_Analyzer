clear;
fs=44100;
fe=1000;
delta=2000;
[b,filter_size]=FirLpf_(fs,fe,delta);
x=wavread('guitar.wav');
length_of_x=length(x);
y=zeros(1,length_of_x);
for n=filter_size:length_of_x,
   for k=1:filter_size,
      y(n)=y(n)+b(k)*x(n-k+1);
   end
end
sound(x,fs);
pause(2);
sound(y,fs);

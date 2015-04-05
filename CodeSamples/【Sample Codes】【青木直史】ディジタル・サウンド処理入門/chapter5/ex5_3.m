clear;
fs=8000;
s0=wavread('hajimemashite.wav');
length_of_s0=length(s0);
x0=zeros(1,length_of_s0);
for n=1:length_of_s0,   
   x0(n)=s0(n)*32768;
end
c0=DpcmEncoder_(x0,32768,6);
x1=DpcmDecoder_(c0,32768,6);
s1=zeros(1,length_of_s0);
for n=1:length_of_s0,   
   s1(n)=x1(n)/32768;
end
sound(s0,fs);
pause(2);
sound(s1,fs);

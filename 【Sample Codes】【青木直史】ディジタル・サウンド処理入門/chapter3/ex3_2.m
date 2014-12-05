close all; 
clear;
fs=11025;
fc=2000;
[b,a]=IirLpf_(fs,fc);
x=wavread('../../Sounds/Akan00.wav');
length_of_x=length(x);
y=zeros(1,length_of_x);
y(1)=b(1)*x(1);
y(2)=-a(2)*y(1)+b(1)*x(2)+b(2)*x(1);
for n=3:length_of_x,
   y(n)=-a(2)*y(n-1)-a(3)*y(n-2)+b(1)*x(n)+b(2)*x(n-1)+b(3)*x(n-2);
end
sound(x,fs);
pause(2);
sound(y,fs);

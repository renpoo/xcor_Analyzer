close all; 
clear;

fs = 32000;
t = (1:fs)'/fs;
s1 = zeros(length(t),1);
s2 = zeros(length(t),1);
for n=1:8,
   s1 = s1 + sin(2*pi*200*n*t)/8;
   s2 = s2 + sin(2*pi*(200+(n-1)*8)*n*t+rand(1)*2*pi)/8;
end

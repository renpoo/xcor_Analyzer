function [b,a]=IirLpf_(fs,fc)
fc=tan(pi*fc/fs)/(2*pi);
a(1)=1+2*sqrt(2)*pi*fc+4*pi*pi*fc*fc;
a(2)=(8*pi*pi*fc*fc-2)/a(1);
a(3)=(1-2*sqrt(2)*pi*fc+4*pi*pi*fc*fc)/a(1);
b(1)=4*pi*pi*fc*fc/a(1);
b(2)=8*pi*pi*fc*fc/a(1);
b(3)=4*pi*pi*fc*fc/a(1);
a(1)=1;

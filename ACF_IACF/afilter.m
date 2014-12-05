function y = afilter(x,Fs)
%    AFILTER  Design of a A-weighting filter.
%    y = afilter(x,Fs) designs a digital A-weighting filter for 
%    sampling frequency Fs. 
%    Warning: Fs should normally be higher than 20 kHz. For example, 
%    Fs = 48000 yields a class 1-compliant filter.
%
%    Requires the Signal Processing Toolbox. 

% Definition of analog A-weighting filter according to IEC/CD 1672.
f1 = 20.598997; 
f2 = 107.65265;
f3 = 737.86223;
f4 = 12194.217;
A1000 = 1.9997;
pi = 3.14159265358979;
NUMs = [ (2*pi*f4)^2*(10^(A1000/20)) 0 0 0 0 ];
DENs = conv([1 +4*pi*f4 (2*pi*f4)^2],[1 +4*pi*f1 (2*pi*f1)^2]); 
DENs = conv(conv(DENs,[1 2*pi*f3]),[1 2*pi*f2]);

% Use the bilinear transformation to get the digital filter. 
[B,A] = bilinear(NUMs,DENs,Fs); 

% Definition of analog A-weighting filter according to IEC/CD 1672.
y = filter(B,A,x);
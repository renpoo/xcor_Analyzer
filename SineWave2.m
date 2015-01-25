close all; 
clear;

Fs = 44100;               % Sampling rate
T = 1/Fs;                 % Sample time
%Len = 256;               % Window size for fft
sec = 0.5;                % Unit time of Sinnal
Tspan = 20;               % Number of Unit time
Hzmax = 880;              % Maximum Frequency of Signal
%Hzmin = floor(Fs/Len)+1; % Minimum Frequency of Signal for fft
%Hzran = Hzmax-(Hzmin);   % Frequency Range for fft
%hlz = floor(Hzran/Tspan);% Unit Frequency range for fft
hlz  = 10;                % Changing Frequency range
hlzs = 20;                % Changing Frequency step

clear tT sS;
clear stemp;

k=0;
tT = 0;
stemp=0;
sS=0;
k=1;
t = ((Fs*sec*(k-1))+1:Fs*sec*k)*T; % Time vector
tT = horzcat(tT, t);
s = sin(2*pi*(Hzmax-hlz*(k-1))*t); % Sine wave vector
sS = horzcat(sS, s);


for k=2:Tspan+1
    t = ((Fs*sec*(k-1))+1:Fs*sec*k)*T; % Time vector
    tT = horzcat(tT, t);
    for l=1:hlzs:hlz
%       s = sin(2*pi*(Hzmax-hlz*(k-2)-(l-1))*t; % Sine wave vector
       s = sin(2*pi*(Hzmax-hlz*(k-2)-(l-1))*t+2*pi*rand); % Uniformly distributed-Random shifted phase-Sine wave vector 
%       s = sin(2*pi*(Hzmax-hlz*(k-2)-(l-1))*t+2*pi*randn); % Normaly distributed-Random shifted phase-Sine wave vector 
       stemp = stemp+s;
    end;
    stemp = stemp/(hlz/hlzs+1);
    sS = horzcat(sS, stemp);
end;

sound( sS, Fs );
% Plot shape of wave
plot(tT,sS);
%axis([0,0.1,-1.5,1.5]);
%axis([1.95,2.05,-1,1]);
%title('SineWave');
%xlabel('time (seconds)');


return;


% Simple FFT
%fftsS = fft(sS)/Len;
%fftsS = fft(sS,Len);
%f = Fs/2*linspace(0,1,length(sS)/2+1);
% Plot single-sided amplitude spectrum.
%plot(f,2*abs(fftsS(1:length(sS)/2+1))) 
%axis([170,185,0,100])
%title('Single-Sided Amplitude Spectrum of y(t)')
%xlabel('Frequency (Hz)')
%ylabel('|ffty(f)|')

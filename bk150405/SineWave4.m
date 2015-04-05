close all; 
clear;

Fs = 44100;              % Sampling rate
T = 1/Fs;                % Sample time
%Len = 256;               % Window size for fft
sec = 0.5;                 % Unit time of Signal
Tspan = 30;               % Number of Unit time
Hzmax = 4000;             % Maximum Frequency of Signal
%Hzmin = floor(Fs/Len)+1; % Minimum Frequency of Signal for fft
%Hzran = Hzmax-(Hzmin);   % Frequency Range for fft
%hlz = floor(Hzran/Tspan);% Unit Frequency range for fft
hlz = 400;                % Changing Frequency range
hlzs = 4;                % Changing Frequency step

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

for k=1:Tspan
    t = ((Fs*sec*k)+1:Fs*sec*(k+1))*T; % Time vector
    tT = horzcat(tT, t);
    
% Random change
    for l=1:hlzs:hlz
        hlzrand = hlz*rand; % Uniformly distributed-Random
%        hlzrand = hlz*randn; % Normaly distributed-Random
%       s = sin(2*pi*(Hzmax-hlz*(k-1)-hlzrand)*t; % Sine wave vector
       s = sin(2*pi*(Hzmax-hlz*(k-1)-hlzrand)*t+2*pi*rand); % Uniformly distributed-Random shifted phase-Sine wave vector 
%       s = sin(2*pi*(Hzmax-hlz*(k-1)-hlzrand)*t+2*pi*randn); % Normaly distributed-Random shifted phase-Sine wave vector     

% Uniformly change
%    for l=1:hlzs:hlz
%       s = sin(2*pi*(Hzmax-hlz*(k-1)-(l-1))*t; % Sine wave vector
%       s = sin(2*pi*(Hzmax-hlz*(k-1)-(l-1))*t+2*pi*rand); % Uniformly distributed-Random shifted phase-Sine wave vector 
%       s = sin(2*pi*(Hzmax-hlz*(k-1)-(l-1))*t+2*pi*randn); % Normaly distributed-Random shifted phase-Sine wave vector 

       stemp = stemp+s;
    end;
    stemp = stemp/(hlz/hlzs);
    sS = horzcat(sS, stemp);
    
    hlzs=hlzs*1.3;
    
end;


sound( sS, Fs );
% Plot shape of wave
plot(tT,sS);
%axis([0,0.1,-1.5,1.5]);
%axis([4.99,5,-1,1]);
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

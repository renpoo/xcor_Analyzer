close all; 
clear;


pkg load signal;
pkg load io;
pkg load audio;


% --- Read Definition File ---

[ fname, pname ] = uigetfile( '*.csv', 'SELECT CSV DEFINITION FILE' );
defFileName = strcat( pname, '/', fname );
fileID = fopen(defFileName);
ch = textscan(fileID, '%s %s','delimiter',',');

graphTitle = ch{1}{1};         % Graph Title
tS0 = str2num( ch{1}{2} );     % Start time (second)
tE0 = str2num( ch{2}{2} );     % End time (second)
audiofilename = ch{2}{5};      % Audiofile with file-path



% --- Read Audiofile ---

samples = [tS0,tE0];
#[~,Fs] = audioread(audiofilename,samples); % Get audiofile's sampling rate
[~,Fs] = wavread(audiofilename,samples); % Get audiofile's sampling rate
tS0 = tS0*Fs; % Convert to frame from sec
tE0 = tE0*Fs; % Convert to frame from sec
clear y Fs samples
samples = [tS0,tE0];
#[y,Fs] = audioread(audiofilename,samples); % Read audiofile within 'samples' range
[y,Fs] = wavread(audiofilename,samples); % Read audiofile within 'samples' range

T = 1/Fs;      % Sample time
L = tE0-tS0;   % Length of signal
t = (0:L)*T;   % Time vector

yA = y(1:length(t),1); % R channel?
yB = y(1:length(t),2); % L channel?

% Plot shape of wave
%sound(yA,Fs); % Raw sound
%plot(t,yA)
%axis([0.1,0.2,-1,1])
%title(graphTitle)
%xlabel('time (seconds)')


% --- FFT ---

% Optimized FFT
%NFFT = 2^nextpow2(L); % Next power of 2 from length of y
%fftyA = fft(yA,NFFT)/L;
%f = Fs/2*linspace(0,1,NFFT/2+1);
% Plot single-sided amplitude spectrum.
%plot(f,2*abs(fftyA(1:NFFT/2+1))) 
%axis([0,3000,0,0.1])
%title('Single-Sided Amplitude Spectrum of y(t)')
%xlabel('Frequency (Hz)')
%ylabel('|ffty(f)|')


% Simple FFT
fftyA = fft(yA)/L;
f = Fs/2*linspace(0,1,length(yA)/2+1);
% Plot single-sided amplitude spectrum.
%plot(f,2*abs(fftyA(1:length(yA)/2+1))) 
%axis([0,500,0,0.1])
%title('Single-Sided Amplitude Spectrum of y(t)')
%xlabel('Frequency (Hz)')
%ylabel('|ffty(f)|')


% Decimation-in-frequency
startIdx = 1;
endIdx = length(f);
for k = startIdx:endIdx

if (and( f(k) > 435, f(k) < 445)),
    fftyA(k) = 0;
end;
if (and( f(k) > 387, f(k) < 397)),
    fftyA(k) = 0;
end;
if (and( f(k) > 325, f(k) < 335)),
    fftyA(k) = 0;
end;

end;


% Plot single-sided amplitude spectrum.
plot(f,2*abs(fftyA(1:length(yA)/2+1))) 
axis([0,500,0,0.1])
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|ffty(f)|')



% --- IFFT ---

% Simple IFFT
invfftyA = ifft(fftyA)*L;
sound(invfftyA,Fs);
% Plot shape of wave
plot(t,invfftyA)
axis([0.1,0.2,-1,1])
title(graphTitle)
xlabel('time (seconds)')



% --- Write Audiofile ---
audiowrite('invfftaudio.wav',invfftyA,Fs)

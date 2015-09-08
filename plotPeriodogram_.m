%close all; 
clear;

% --- Audio File open and read
[ fname, pname ] = uigetfile( '*.wav', 'SELECT WAV FILE' );
audFileName = strcat( pname, '/', fname );
%samples = [ 1, inf ];
%[ s0, Fs ] = audioread( audFileName, samples );
[ s0, Fs ] = audioread( audFileName );

sound( s0, Fs );

% --- Original Sound Pre-set-up
s0R = s0( 1 : length(s0), 1 ); % R channel
%s0L = s0( 1 : length(s0), 2 ); % L channel
s = s0R; % Pick up 1 channel

% --- FFT and Plot
m = length( s );          % Window length
n = pow2( nextpow2( m ) );   % Transform length
y = fft( s, n );           % DFT
f = ( 0 : (n-1) ) * ( Fs / n );      % Frequency range
power = y .* conj(y) / n;    % Power of the DFT

figure(); plot( f( 1 : floor(n/2) ), power( 1 : floor(n/2) ) );
%axis([0,2500,0,2000]);
xlabel('Frequency (Hz)');
ylabel('Power');
title('{\bf Periodogram}');

return;

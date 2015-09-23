%close all; 
%clear;

% --- Audio File open and read
[ fname, pname ] = uigetfile( '*.wav', 'SELECT WAV FILE' );
audFileName = strcat( pname, '/', fname );
%samples = [ 1, inf ];
%[ s0, fs ] = audioread( audFileName, samples );
[ S, fs ] = audioread( audFileName );

sound( S, fs );

% --- Original Sound Pre-set-up
s0R = S( 1 : length(S), 1 ); % R channel
%s0L = s0( 1 : length(s0), 2 ); % L channel
s = s0R; % Pick up 1 channel

% --- FFT and Plot
m = length( s );          % Window length
n = pow2( nextpow2( m ) );   % Transform length
y = fft( s, n );           % DFT
fAxis = ( 0 : (n-1) ) * ( fs / n );      % Frequency range
power = y .* conj(y) / n;    % Power of the DFT

figure(); plot( fAxis( 1 : floor(n/2) ), power( 1 : floor(n/2) ) );
%axis([0,2500,0,2000]);
xlabel('Frequency (Hz)');
ylabel('Power (dB)');
title( strcat( '{\bf Periodogram} ', fname , '' ));


saveas( 1, strcat( pname, '/', fname, '.fig' ) );
saveas( 1, strcat( pname, '/', fname, '.jpg' ) );


return;

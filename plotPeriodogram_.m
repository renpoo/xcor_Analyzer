%function plotPeriodogram_( S, fs )

%close all;
%clear;

% --- Audio File open and read
[ fname, pname ] = uigetfile( '*.wav', 'SELECT WAV FILE' );
audFileName = strcat( pname, '/', fname );
samples = [ 1, inf ];
%[ s0, fs ] = audioread( audFileName, samples );
[ S, fs ] = audioread( audFileName );

%sound( S, fs );

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

lw = 1;
ms = 2;
figure();
plot( fAxis( 1 : floor(n/2) ), power( 1 : floor(n/2) ) );

grid on;
hold on;
lc = 'ok';
plot( fAxis( 1 : floor(n/2) ), power( 1 : floor(n/2) ), lc, 'LineWidth', lw, 'MarkerSize', ms );

%axis([ min(fAxis), max(fAxis)+10, 0, max(power)*1.1 ]);
xlabel('Frequency (Hz)');
ylabel('Power (dB)');
%title( strcat( '{\bf Periodogram} ', fname , '' ));
title( strcat( '{\bf Periodogram}' ));


%saveas( 1, strcat( pname, '/', fname, '.fig' ) );
%saveas( 1, strcat( pname, '/', fname, '.jpg' ) );


return;

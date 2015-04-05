%pkg load io;
%pkg load signal;

close all;
clear;

[ s0, fs, bits ] = wavread('Sounds/Akan00.wav');
%[ s0, fs, bits ] = wavread('Sounds/140823TiturelAmfortas.WAV');

sound( s0, fs );
pause;


length_of_s0 = length( s0 );
duration = length_of_s0 / fs;  %duration (of input signal)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section: Smoothing (simply making the average value for a frame)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

window_size = 256;
avgLen = 16; % This param defines smoothing length (for avg value) in the window for frame k

avg = 0.0;

number_of_frame = floor( ( length_of_s0 - ( window_size - avgLen ) ) / avgLen ) - 1;

for frame = 1 : number_of_frame,
    offset = avgLen * ( frame - 1 );
    for i = 1 : avgLen : window_size,
        subS0 = s0( offset+i : offset+avgLen+i-1 );
        avg = mean( subS0 );
        x( offset+i : offset+avgLen+i-1 ) = avg;
        avg = 0.0;
    end;
end;


sound( x, fs );
pause;

%return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section: FFT to calcurate picking-up peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

shift_size = 16; % this param defines smoothing length (for avg value) in the window for frame k
dft_size = 256; % FFT size (Discrete)

TopRanks = 1; % Number to picking-up peaks from the Spectrum of the certain window (MIRRORED)

shift_size = 256; % Shifting Size for a window for FFT
number_of_frame = floor( ( length_of_s0 - ( window_size - shift_size ) ) / shift_size ) - 1;


% Initilize vectors for resulting data
resultS = zeros( 1, dft_size );
resultXpickedUp = zeros( 1, dft_size );


for frame = 1 : number_of_frame,
    offset = shift_size * ( frame - 1 );
    X = fft( x( offset+1 : offset+window_size ), dft_size );
    
    if ( 0 ),
        %for k = 1 : dft_size/2+1,
        %    A( k ) = -20 * log10( abs( X( k ) ) );
        %end;

        A = -20 * log10( abs( X ) );
    else
        A = abs( X );
    end;
    
    
    [ sortedA, sortedIdx ] = sort( A, 'descend' ); % "sortedIdx" is index array for sorted A
    %[ sortedA, sortedIdx ] = sort( A, 'ascend' ); % "sortedIdx" is index array for sorted A
    
    ApickedUp = zeros( 1, dft_size/2+1 ); % Picked-Up Amplitudes (RESULTS)
    XpickedUp = zeros( 1, dft_size );     % Picked-Up Frequencies (RESULTS)
    
    for k = 1 : dft_size/2+1,
        for j = 1 : TopRanks,
            if ( k == sortedIdx( j ) ),
                disp( strcat( '###', num2str( k ) ) );
                
                ApickedUp( k ) = A( k );
                
                XpickedUp( k ) = X( k );
                XpickedUp( dft_size - k ) = X( k );
            end;
        end;
    end;
    
    
    if( 0 ),
        clf ();
        figure(1);
        %plot( real( XpickedUp ) );
        plot( real( ApickedUp ) );
        %plot( real( A ) );
        %plot( real( X ) );
        %plot( real( sortedA ) );
        pname = strcat( 'Output Images', '/', 'Sinusoid_Test_01' );
        mkdir( pname );
        saveImageName = strcat( 'pickedUpFreqs-', num2str( frame ) );
        fname = strcat( saveImageName, '.jpg');
        outputDataFileName = strcat( pname, '/', fname );
        saveas( 1, strcat( outputDataFileName ) );
    end;
    
    resultXpickedUp = horzcat( resultXpickedUp, XpickedUp );
    resultS = horzcat( resultS, real( ifft( XpickedUp, dft_size ) ) );
    
end;


if ( 0 ),
    magicScale = 10000;
    for k = 1 : length( resultS ),
        resultS( k ) = ( 1 / 10^( resultS( k ) / 20 ) - 1 ) * magicScale;
    end;
end;


sound( resultS, fs );
pause;

return;

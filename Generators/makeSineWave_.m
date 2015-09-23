function S = makeSineWave_( p, f, theta, fs, d, interval )

S = generateSinWave_( p, f, fs, d, theta );
audiowrite( strcat( './_Sounds/sine', num2str(f), 'Hz_', num2str(theta), 'deg.wav'), S, fs);
%sound( S, fs );
%pause( d + interval );

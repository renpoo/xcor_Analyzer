A = 1;
duration = 3.0;
fs = 44100;
f01 = 400;
f02 = 440;
interval = 0.1;

s4096Hz_0deg   = generateSinWave_( A, 4096, fs, duration,    0, '../_Sounds/SineWave_4096Hz_0deg.wav' );    pause( duration + interval );
s4196Hz_0deg   = generateSinWave_( A, 4196, fs, duration,    0, '../_Sounds/SineWave_4196Hz_0deg.wav' );    pause( duration + interval );
%s4224Hz_0deg   = generateSinWave_( A, 4224, fs, duration,    0, '../_Sounds/SineWave_4224Hz_0deg.wav' );    pause( duration + interval );
sound(s4096Hz_0deg .* s4196Hz_0deg, fs);
audiowrite( 'tmp5.wav', s4096Hz_0deg .* s4196Hz_0deg, fs );


%{
s2048Hz_0deg   = generateSinWave_( A, 2048, fs, duration,    0, '../_Sounds/SineWave_400Hz_0deg.wav' );    pause( duration + interval );
pause();
s2176Hz_0deg   = generateSinWave_( A, 2176, fs, duration,    0, '../_Sounds/SineWave_400Hz_0deg.wav' );    pause( duration + interval );
pause();
sound(s2048Hz_0deg .* s2176Hz_0deg, fs);
audiowrite( 'tmp1.wav', s2048Hz_0deg .* s2176Hz_0deg, fs );
pause();
sound(s2048Hz_0deg + s2176Hz_0deg, fs);
audiowrite( 'tmp2.wav', s2048Hz_0deg + s2176Hz_0deg, fs );
%}

return;
s400Hz_0deg   = generateSinWave_( A, f01, fs, duration,    0, '../_Sounds/SineWave_400Hz_0deg.wav' );    pause( duration + interval );
s400Hz_15deg  = generateSinWave_( A, f01, fs, duration, pi/6, '../_Sounds/SineWave_400Hz_15deg.wav' );   pause( duration + interval );
s400Hz_45deg  = generateSinWave_( A, f01, fs, duration, pi/4, '../_Sounds/SineWave_400Hz_45deg.wav' );   pause( duration + interval );
s400Hz_60deg  = generateSinWave_( A, f01, fs, duration, pi/3, '../_Sounds/SineWave_400Hz_60deg.wav' );   pause( duration + interval );
s400Hz_90deg  = generateSinWave_( A, f01, fs, duration, pi/2, '../_Sounds/SineWave_400Hz_90deg.wav' );   pause( duration + interval );
s400Hz_180deg = generateSinWave_( A, f01, fs, duration, pi*1, '../_Sounds/SineWave_400Hz_180deg.wav' );  pause( duration + interval );
s400Hz_360deg = generateSinWave_( A, f01, fs, duration, pi*2, '../_Sounds/SineWave_400Hz_360deg.wav' );  pause( duration + interval );


s440Hz_0deg   = generateSinWave_( A, f02, fs, duration,    0, '../_Sounds/SineWave_440Hz_0deg.wav' );    pause( duration + interval );
s440Hz_15deg  = generateSinWave_( A, f02, fs, duration, pi/6, '../_Sounds/SineWave_440Hz_15deg.wav' );   pause( duration + interval );
s440Hz_30deg  = generateSinWave_( A, f02, fs, duration, pi/4, '../_Sounds/SineWave_440Hz_45deg.wav' );   pause( duration + interval );
s440Hz_60deg  = generateSinWave_( A, f02, fs, duration, pi/3, '../_Sounds/SineWave_440Hz_60deg.wav' );   pause( duration + interval );
s440Hz_90deg  = generateSinWave_( A, f02, fs, duration, pi/2, '../_Sounds/SineWave_440Hz_90deg.wav' );   pause( duration + interval );
s440Hz_180deg = generateSinWave_( A, f02, fs, duration, pi*1, '../_Sounds/SineWave_440Hz_180deg.wav' );  pause( duration + interval );
s440Hz_360deg = generateSinWave_( A, f02, fs, duration, pi*2, '../_Sounds/SineWave_440Hz_360deg.wav' );  pause( duration + interval );



A = 1;
duration = 3.0;
fs = 44100;
f01 = 400;
f02 = 440;
interval = 0.1;

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



A = 1;
duration = 3.0;
fs = 44100;
interval = 0.1;


sine400Hz_0deg   = generateSinWave_( A, 400, fs, duration,    0 ); audiowrite( './_Sounds/sine400Hz_0deg.wav'   , sine400Hz_0deg,   fs);  sound( sine400Hz_0deg,   fs ); pause( duration + interval );
sine400Hz_15deg  = generateSinWave_( A, 400, fs, duration, pi/12); audiowrite( './_Sounds/sine400Hz_15deg.wav'  , sine400Hz_15deg,  fs);  sound( sine400Hz_15deg,  fs ); pause( duration + interval );
sine400Hz_30deg  = generateSinWave_( A, 400, fs, duration, pi/6 ); audiowrite( './_Sounds/sine400Hz_30deg.wav'  , sine400Hz_30deg,  fs);  sound( sine400Hz_30deg,  fs ); pause( duration + interval );
sine400Hz_45deg  = generateSinWave_( A, 400, fs, duration, pi/4 ); audiowrite( './_Sounds/sine400Hz_45deg.wav'  , sine400Hz_45deg,  fs);  sound( sine400Hz_45deg,  fs ); pause( duration + interval );
sine400Hz_60deg  = generateSinWave_( A, 400, fs, duration, pi/3 ); audiowrite( './_Sounds/sine400Hz_60deg.wav'  , sine400Hz_60deg,  fs);  sound( sine400Hz_60deg,  fs ); pause( duration + interval );
sine400Hz_90deg  = generateSinWave_( A, 400, fs, duration, pi/2 ); audiowrite( './_Sounds/sine400Hz_90deg.wav'  , sine400Hz_90deg,  fs);  sound( sine400Hz_90deg,  fs ); pause( duration + interval );
sine400Hz_180deg = generateSinWave_( A, 400, fs, duration, pi*1 ); audiowrite( './_Sounds/sine400Hz_180deg.wav' , sine400Hz_180deg, fs);  sound( sine400Hz_180deg, fs ); pause( duration + interval );
sine400Hz_360deg = generateSinWave_( A, 400, fs, duration, pi*2 ); audiowrite( './_Sounds/sine400Hz_360deg.wav' , sine400Hz_360deg, fs);  sound( sine400Hz_360deg, fs ); pause( duration + interval );


sine440Hz_0deg   = generateSinWave_( A, 440, fs, duration,    0 ); audiowrite( './_Sounds/sine440Hz_0deg.wav'   , sine440Hz_0deg,   fs);  sound( sine440Hz_0deg,   fs ); pause( duration + interval );
sine440Hz_15deg  = generateSinWave_( A, 440, fs, duration, pi/12); audiowrite( './_Sounds/sine440Hz_15deg.wav'  , sine440Hz_15deg,  fs);  sound( sine440Hz_15deg,  fs ); pause( duration + interval );
sine440Hz_30deg  = generateSinWave_( A, 440, fs, duration, pi/6 ); audiowrite( './_Sounds/sine440Hz_30deg.wav'  , sine440Hz_30deg,  fs);  sound( sine440Hz_30deg,  fs ); pause( duration + interval );
sine440Hz_45deg  = generateSinWave_( A, 440, fs, duration, pi/4 ); audiowrite( './_Sounds/sine440Hz_45deg.wav'  , sine440Hz_45deg,  fs);  sound( sine440Hz_45deg,  fs ); pause( duration + interval );
sine440Hz_60deg  = generateSinWave_( A, 440, fs, duration, pi/3 ); audiowrite( './_Sounds/sine440Hz_60deg.wav'  , sine440Hz_60deg,  fs);  sound( sine440Hz_60deg,  fs ); pause( duration + interval );
sine440Hz_90deg  = generateSinWave_( A, 440, fs, duration, pi/2 ); audiowrite( './_Sounds/sine440Hz_90deg.wav'  , sine440Hz_90deg,  fs);  sound( sine440Hz_90deg,  fs ); pause( duration + interval );
sine440Hz_180deg = generateSinWave_( A, 440, fs, duration, pi*1 ); audiowrite( './_Sounds/sine440Hz_180deg.wav' , sine440Hz_180deg, fs);  sound( sine440Hz_180deg, fs ); pause( duration + interval );
sine440Hz_360deg = generateSinWave_( A, 440, fs, duration, pi*2 ); audiowrite( './_Sounds/sine440Hz_360deg.wav' , sine440Hz_360deg, fs);  sound( sine440Hz_360deg, fs ); pause( duration + interval );


sine1024Hz_0deg  = generateSinWave_( A,1024, fs, duration,    0 ); audiowrite( './_Sounds/sine1024Hz_0deg.wav'  , sine1024Hz_0deg,  fs);  sound( sine1024Hz_0deg,  fs ); pause( duration + interval );
sine1152Hz_0deg  = generateSinWave_( A,1152, fs, duration,    0 ); audiowrite( './_Sounds/sine1152Hz_0deg.wav'  , sine1152Hz_0deg,  fs);  sound( sine1152Hz_0deg,  fs ); pause( duration + interval );

sine2048Hz_0deg  = generateSinWave_( A,2048, fs, duration,    0 ); audiowrite( './_Sounds/sine2048Hz_0deg.wav'  , sine2048Hz_0deg,  fs);  sound( sine2048Hz_0deg,  fs ); pause( duration + interval );
sine2176Hz_0deg  = generateSinWave_( A,2176, fs, duration,    0 ); audiowrite( './_Sounds/sine2176Hz_0deg.wav'  , sine2176Hz_0deg,  fs);  sound( sine2176Hz_0deg,  fs ); pause( duration + interval );

sine4096Hz_0deg  = generateSinWave_( A,4096, fs, duration,    0 ); audiowrite( './_Sounds/sine4096Hz_0deg.wav'  , sine4096Hz_0deg,  fs);  sound( sine4096Hz_0deg,  fs ); pause( duration + interval );
sine4196Hz_0deg  = generateSinWave_( A,4196, fs, duration,    0 ); audiowrite( './_Sounds/sine4196Hz_0deg.wav'  , sine4196Hz_0deg,  fs);  sound( sine4196Hz_0deg,  fs ); pause( duration + interval );
sine4224Hz_0deg  = generateSinWave_( A,4224, fs, duration,    0 ); audiowrite( './_Sounds/sine4224Hz_0deg.wav'  , sine4224Hz_0deg,  fs);  sound( sine4224Hz_0deg,  fs ); pause( duration + interval );

sine8192Hz_0deg  = generateSinWave_( A,8192, fs, duration,    0 ); audiowrite( './_Sounds/sine8192Hz_0deg.wav'  , sine8192Hz_0deg,  fs);  sound( sine8192Hz_0deg,  fs ); pause( duration + interval );
sine8292Hz_0deg  = generateSinWave_( A,8292, fs, duration,    0 ); audiowrite( './_Sounds/sine8292Hz_0deg.wav'  , sine8292Hz_0deg,  fs);  sound( sine8292Hz_0deg,  fs ); pause( duration + interval );
sine8320Hz_0deg  = generateSinWave_( A,8320, fs, duration,    0 ); audiowrite( './_Sounds/sine8320Hz_0deg.wav'  , sine8320Hz_0deg,  fs);  sound( sine8320Hz_0deg,  fs ); pause( duration + interval );

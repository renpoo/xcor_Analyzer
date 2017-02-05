A = 1;
duration = 3.0;
fs = 44100;
interval = 0.1;

%{
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
%}

%{
sine512Hz_0deg   = generateSinWave_( A, 512, fs, duration,    0 ); audiowrite( './_Sounds/sine512Hz_0deg.wav'   , sine512Hz_0deg,   fs);  sound( sine512Hz_0deg,   fs ); pause( duration + interval );
sine576Hz_0deg   = generateSinWave_( A, 576, fs, duration,    0 ); audiowrite( './_Sounds/sine576Hz_0deg.wav'   , sine576Hz_0deg,   fs);  sound( sine576Hz_0deg,   fs ); pause( duration + interval );
sine640Hz_0deg   = generateSinWave_( A, 640, fs, duration,    0 ); audiowrite( './_Sounds/sine640Hz_0deg.wav'   , sine640Hz_0deg,   fs);  sound( sine640Hz_0deg,   fs ); pause( duration + interval );
sine682_6Hz_0deg = generateSinWave_( A, 682.6, fs, duration,  0 ); audiowrite( './_Sounds/sine682.6Hz_0deg.wav' , sine682_6Hz_0deg, fs);  sound( sine682_6Hz_0deg, fs ); pause( duration + interval );
sine768Hz_0deg   = generateSinWave_( A, 768, fs, duration,    0 ); audiowrite( './_Sounds/sine768Hz_0deg.wav'   , sine768Hz_0deg,   fs);  sound( sine768Hz_0deg,   fs ); pause( duration + interval );
sine864Hz_0deg   = generateSinWave_( A, 864, fs, duration,    0 ); audiowrite( './_Sounds/sine864Hz_0deg.wav'   , sine864Hz_0deg,   fs);  sound( sine864Hz_0deg,   fs ); pause( duration + interval );
sine960Hz_0deg   = generateSinWave_( A, 960, fs, duration,    0 ); audiowrite( './_Sounds/sine960Hz_0deg.wav'   , sine960Hz_0deg,   fs);  sound( sine960Hz_0deg,   fs ); pause( duration + interval );
sine1023Hz_0deg  = generateSinWave_( A, 1023, fs, duration,   0 ); audiowrite( './_Sounds/sine1023Hz_0deg.wav'  , sine1023Hz_0deg,  fs);  sound( sine1023Hz_0deg,  fs ); pause( duration + interval );
%}

%sine1000Hz_0deg  = generateSinWave_( A, 1000, fs, duration,   0 ); audiowrite( './_Sounds/sine1000Hz_0deg.wav'  , sine1000Hz_0deg,  fs);  sound( sine1000Hz_0deg,  fs ); pause( duration + interval );
%sine998Hz_0deg  = generateSinWave_( A, 998, fs, duration,   0 ); audiowrite( './_Sounds/sine998Hz_0deg.wav'  , sine998Hz_0deg,  fs);  sound( sine998Hz_0deg,  fs ); pause( duration + interval );
%sine996Hz_0deg  = generateSinWave_( A, 996, fs, duration,   0 ); audiowrite( './_Sounds/sine996Hz_0deg.wav'  , sine996Hz_0deg,  fs);  sound( sine996Hz_0deg,  fs ); pause( duration + interval );
%sine994Hz_0deg  = generateSinWave_( A, 994, fs, duration,   0 ); audiowrite( './_Sounds/sine994Hz_0deg.wav'  , sine994Hz_0deg,  fs);  sound( sine994Hz_0deg,  fs ); pause( duration + interval );
%sine992Hz_0deg  = generateSinWave_( A, 992, fs, duration,   0 ); audiowrite( './_Sounds/sine992Hz_0deg.wav'  , sine992Hz_0deg,  fs);  sound( sine992Hz_0deg,  fs ); pause( duration + interval );
%sine990Hz_0deg  = generateSinWave_( A, 990, fs, duration,   0 ); audiowrite( './_Sounds/sine990Hz_0deg.wav'  , sine990Hz_0deg,  fs);  sound( sine990Hz_0deg,  fs ); pause( duration + interval );
%sine988Hz_0deg  = generateSinWave_( A, 988, fs, duration,   0 ); audiowrite( './_Sounds/sine988Hz_0deg.wav'  , sine988Hz_0deg,  fs);  sound( sine988Hz_0deg,  fs ); pause( duration + interval );
%sine986Hz_0deg  = generateSinWave_( A, 986, fs, duration,   0 ); audiowrite( './_Sounds/sine986Hz_0deg.wav'  , sine986Hz_0deg,  fs);  sound( sine986Hz_0deg,  fs ); pause( duration + interval );
%sine984Hz_0deg  = generateSinWave_( A, 984, fs, duration,   0 ); audiowrite( './_Sounds/sine984Hz_0deg.wav'  , sine984Hz_0deg,  fs);  sound( sine984Hz_0deg,  fs ); pause( duration + interval );
%sine982Hz_0deg  = generateSinWave_( A, 982, fs, duration,   0 ); audiowrite( './_Sounds/sine982Hz_0deg.wav'  , sine982Hz_0deg,  fs);  sound( sine982Hz_0deg,  fs ); pause( duration + interval );
%sine980Hz_0deg  = generateSinWave_( A, 980, fs, duration,   0 ); audiowrite( './_Sounds/sine980Hz_0deg.wav'  , sine980Hz_0deg,  fs);  sound( sine980Hz_0deg,  fs ); pause( duration + interval );
%sine978Hz_0deg  = generateSinWave_( A, 978, fs, duration,   0 ); audiowrite( './_Sounds/sine978Hz_0deg.wav'  , sine978Hz_0deg,  fs);  sound( sine978Hz_0deg,  fs ); pause( duration + interval );
%sine976Hz_0deg  = generateSinWave_( A, 976, fs, duration,   0 ); audiowrite( './_Sounds/sine976Hz_0deg.wav'  , sine976Hz_0deg,  fs);  sound( sine976Hz_0deg,  fs ); pause( duration + interval );
%sine974Hz_0deg  = generateSinWave_( A, 974, fs, duration,   0 ); audiowrite( './_Sounds/sine974Hz_0deg.wav'  , sine974Hz_0deg,  fs);  sound( sine974Hz_0deg,  fs ); pause( duration + interval );

%sine10000Hz_0deg  = generateSinWave_( A, 10000, fs, duration,   0 ); audiowrite( './_Sounds/sine10000Hz_0deg.wav'  , sine10000Hz_0deg,  fs);  sound( sine10000Hz_0deg,  fs ); pause( duration + interval );
%sine9950Hz_0deg  = generateSinWave_( A, 9950, fs, duration,   0 ); audiowrite( './_Sounds/sine9950Hz_0deg.wav'  , sine9950Hz_0deg,  fs);  sound( sine9950Hz_0deg,  fs ); pause( duration + interval );
%sine20000Hz_0deg  = generateSinWave_( A, 20000, fs, duration,   0 ); audiowrite( './_Sounds/sine20000Hz_0deg.wav'  , sine20000Hz_0deg,  fs);  sound( sine20000Hz_0deg,  fs ); pause( duration + interval );
%sine19950Hz_0deg  = generateSinWave_( A, 19950, fs, duration,   0 ); audiowrite( './_Sounds/sine19950Hz_0deg.wav'  , sine19950Hz_0deg,  fs);  sound( sine19950Hz_0deg,  fs ); pause( duration + interval );
%sine19945Hz_0deg  = generateSinWave_( A, 19945, fs, duration,   0 ); audiowrite( './_Sounds/sine19945Hz_0deg.wav'  , sine19945Hz_0deg,  fs);  sound( sine19945Hz_0deg,  fs ); pause( duration + interval );
%sine19890Hz_0deg  = generateSinWave_( A, 19890, fs, duration,   0 ); audiowrite( './_Sounds/sine19890Hz_0deg.wav'  , sine19890Hz_0deg,  fs);  sound( sine19890Hz_0deg,  fs ); pause( duration + interval );
%sine19780Hz_0deg  = generateSinWave_( A, 19780, fs, duration,   0 ); audiowrite( './_Sounds/sine19780Hz_0deg.wav'  , sine19780Hz_0deg,  fs);  sound( sine19780Hz_0deg,  fs ); pause( duration + interval );
%sine19560Hz_0deg  = generateSinWave_( A, 19560, fs, duration,   0 ); audiowrite( './_Sounds/sine19560Hz_0deg.wav'  , sine19560Hz_0deg,  fs);  sound( sine19560Hz_0deg,  fs ); pause( duration + interval );
%sine19340Hz_0deg  = generateSinWave_( A, 19340, fs, duration,   0 ); audiowrite( './_Sounds/sine19340Hz_0deg.wav'  , sine19340Hz_0deg,  fs);  sound( sine19340Hz_0deg,  fs ); pause( duration + interval );

%sine19414Hz_0deg  = generateSinWave_( A, 19414, fs, duration,   0 ); audiowrite( './_Sounds/sine19414Hz_0deg.wav'  , sine19414Hz_0deg,  fs);  sound( sine19414Hz_0deg,  fs ); pause( duration + interval );
%sine19505Hz_0deg  = generateSinWave_( A, 19505, fs, duration,   0 ); audiowrite( './_Sounds/sine19505Hz_0deg.wav'  , sine19505Hz_0deg,  fs);  sound( sine19505Hz_0deg,  fs ); pause( duration + interval );
%sine19450Hz_0deg  = generateSinWave_( A, 19450, fs, duration,   0 ); audiowrite( './_Sounds/sine19450Hz_0deg.wav'  , sine19450Hz_0deg,  fs);  sound( sine19450Hz_0deg,  fs ); pause( duration + interval );
%sine19257_5Hz_0deg  = generateSinWave_( A, 19257.5, fs, duration,   0 ); audiowrite( './_Sounds/sine19257_5Hz_0deg.wav'  , sine19257_5Hz_0deg,  fs);  sound( sine19257_5Hz_0deg,  fs ); pause( duration + interval );
%sine19175Hz_0deg  = generateSinWave_( A, 19175, fs, duration,   0 ); audiowrite( './_Sounds/sine19175Hz_0deg.wav'  , sine19175Hz_0deg,  fs);  sound( sine19175Hz_0deg,  fs ); pause( duration + interval );
sine19120Hz_0deg  = generateSinWave_( A, 19120, fs, duration,   0 ); audiowrite( './_Sounds/sine19120Hz_0deg.wav'  , sine19120Hz_0deg,  fs);  sound( sine19120Hz_0deg,  fs ); pause( duration + interval );

%sine55Hz_0deg  = generateSinWave_( A, 55, fs, duration,   0 ); audiowrite( './_Sounds/sine55Hz_0deg.wav'  , sine55Hz_0deg,  fs);  sound( sine55Hz_0deg,  fs ); pause( duration + interval );
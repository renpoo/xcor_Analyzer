clear;


if (0),
  wavFileName_X = "Sounds/TestSinusoid_400Hz.wav";
  #wavFileName_X = "Sounds/birdselffree.wav";
  #wavFileName_Y = "Sounds/TestSinusoid_by_Cosine_400Hz.wav";
  #wavFileName = "Sounds/edisonselfcorfree.wav";
  wavFileName_Y = wavFileName_X;

  f = 400;   # frequency (Hz)
  T = 1 / f; # period (s)
  start = T;
  stop  = T * 2;
  window_size = T;

  
  [x,fsX,bitsX] = wavread(wavFileName_X);
  sound(x,fsX);
  [y,fsY,bitsY] = wavread(wavFileName_Y);
  sound(y,fsY);
endif;

if (0),
  wavFileName_X = "Sounds/birdselffree.wav";
  wavFileName_Y = wavFileName_X;

  start = 1.000;
  stop  = 1.005;
  window_size = 0.002;


  [x,fsX,bitsX] = wavread(wavFileName_X);
  sound(x,fsX);
  [y,fsY,bitsY] = wavread(wavFileName_Y);
  sound(y,fsY);
endif;


if (1),
  wavFileName_X = "Sounds/birdsong-fr-YouTube_VeCRF7ht-kw.wav";
  wavFileName_Y = wavFileName_X;

  start = 0.500;
  stop  = 0.505;
  window_size = 0.001;


  [s,fs,bits] = wavread(wavFileName_X);
  sound(s,fs);

  x = s( 1:end, 1 );
  y = s( 1:end, 2 );
  fsX = fs; 
endif;



lenX = length(x);
lenY = length(y);


d = round( lenX/fsX ); #duration (of input signal)


#start = T * 1000 * d; # start time (s)
#stop  = 2 * T * 1000 * d; #  stop time (s)
span  = stop - start; # time span from start to stop


tic();
[Cfunc, timeAxis] = CrossCorrelationFunc_Renpoo_( x, y, window_size, start, stop, d );
toc();


#timeAxis = (start * 1000 : stop * 1000); # Time Axis from start (ms) to stop (ms)
#timeAxis = (-span/2 : span/2);

#centerAxisX = 0;
#tmpAxis = linspace(-1, 1, 100);
#centerAxisY = tmpAxis;
#plot( timeAxis, Cfunc, 'b', centerAxisX, centerAxisY );
plot( timeAxis, Cfunc, 'b');
grid on;
axis on;
line([0 0],[-1 1]);
#line([-0.0006 0],[0 0]);
#line([0 0],[0.0006 0]);
xlabel('Time (s)'); ylabel('Cross Correlation Func ()');


if (1),
  pkg load io;
  outputDataFileName = "Output\ Data/test_Cfunc_by_renpooCC_for_TestSinusoid.csv";
  [fid, msg] = fopen(outputDataFileName, "wt");
  if ( fid == -1 ) disp( msg ); endif;

  fprintf( fid, "%s", "Cfunc, " );
  fprintf( fid, "%f, ", Cfunc );
  fprintf( fid, "%s", "\n" );
  fprintf( fid, "%s", "testAxis, " );
  fprintf( fid, "%f, ", Cfunc );
  fprintf( fid, "%s", "\n" );

  fclose( fid );
endif;

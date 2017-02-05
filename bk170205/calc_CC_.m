function calc_CC_(x, y, fs, bits, tS, tE, xLabel, yLabel, saveImageName, dumpFlag, debugFlag, plotFlag, ccfFlag, nacfFlag, nacfAndoFlag, iacfFlag, phiFlag, fileDlgFlag, castSignalFlag)

pkg load signal;
pkg load io;

tauEnd = 1.0 / 1000; # [s] : End of calcuration interval for nACF

if (castSignalFlag),
  x = x - mean(x);
  y = y - mean(y);
endif;

lenX = length(x);
#lenY = length(y);


duration = lenX / fs;  %duration (of input signal)


resultData = [];
params = [];

tic();
if (ccfFlag),
  funcStr = "nCCF";
  tStart  = 0.0;
  tStop   = 100.0 / 1000;
  limitSize = convTime2Index_( (tStop - tStart), x, fs );
  rxy = nCCF_( x( 1:limitSize ), y( 1:limitSize ) );
  resultData = rxy; # nCCF
  timeAxis = create_timeAxis_( tStart, tStop, length(resultData), duration );
endif;
toc();


if (plotFlag),
  plot_graph_( resultData, timeAxis, saveImageName, funcStr, strTitle, xLabel, yLabel, params );
endif;


if (dumpFlag),
  dump_outputData_( outputData, funcStr );
endif;


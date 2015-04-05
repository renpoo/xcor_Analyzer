# function test_nACF_and_IACF()
# work for : Calculate nACF and IACF by two-ways each
# author   : TAISO, Renpoo
# date     : 2014/09/06

close all; 
clear;


tauEnd = 1.0 / 1000; # [s] : End of calcuration interval for nACF


dumpFlag       = 0;
debugFlag      = 0;
plotFlag       = 1;
ccfFlag        = 0;
nacfFlag       = 1;
nacfAndoFlag   = 0;
iacfFlag       = 0;
phiFlag        = 0;
fileDlgFlag    = 1;
castSignalFlag = 0;


pkg load signal;
pkg load io;

if (1),
  % Read Sound Data
  if (fileDlgFlag),
    [ fname, pname ] = uigetfile( '*.wav', 'WAVE DATA' );
    wavFileName = strcat( pname, "/", fname );
  else 
    #wavFileName  = "Sounds/Comp_Stereo_Sinusoid_400Hz_16bit_w_0deg_shift.wav";
    #wavFileName  = "Sounds/Comp_Stereo_Sinusoid_400Hz_16bit_w_45deg_shift.wav";
    #wavFileName  = "Sounds/Comp_Stereo_Sinusoid_400Hz_16bit_w_90deg_shift.wav";
    #wavFileName  = "Sounds/Comp_Stereo_Sinusoid_400Hz_16bit_w_180deg_shift.wav";
    #wavFileName  = "Sounds/20140831Bach2f-b_.wav";
    #wavFileName  = "Sounds/20140831Bach4_up-down.wav";
    wavFileName  = "Sounds/RI_own/RI_own_PM_A.wav";
  endif;

  [ s, fs, bits ] = wavread( wavFileName );

  if (debugFlag) sound( s, fs ); endif;

  % Separate stereo channels to 2 different vectors
  x = s( 1:end, 1 );
  #y = s( 1:end, 2 );
endif;


if (0),
  [ fname, pname ] = uigetfile( '*.csv', 'CSV DIFINITION FILE' );
  defFileName = strcat( pname, "/", fname );
  [ch, csvFileNames]=textread(defFileName, '%s %s','delimiter',',');

  [ x0, fsX, bitsX ] = wavread( csvFileNames{1} );
  [ y0, fsY, bitsY ] = wavread( csvFileNames{2} );

  fs = fsX;
  bits = bitsX;

  tS = 1.606;
  tE = 3.047;
  tS_Idx = convTime2Index_( tS, x0, fs );
  tE_Idx = convTime2Index_( tE, x0, fs );

  x = x0( tS_Idx : tE_Idx );
  y = y0( tS_Idx : tE_Idx );
endif;


if (castSignalFlag),
  x = x - mean(x);
  #y = y - mean(y);
endif;
  
lenX = length(x);
#lenY = length(y);


duration = lenX / fs;  %duration (of input signal)


resultData = [];


tic();
if (ccfFlag),
  funcStr = "nCCF";
  tStart  = 0.0;
  tStop   = 100.0 / 1000;
  limitSize = floor((tStop - tStart)/duration*lenX);
  rxy = nCCF_( x( 1:limitSize ), y( 1:limitSize ) );
  resultData = rxy; # nCCF
  timeAxis = create_timeAxis_( tStart, tStop, length(resultData), duration );
endif;


if (nacfFlag),
  funcStr = "nACF";
  tauEnd = 100.0 / 1000; # [s] : OVERRIDE
  tStart  = 0.0;
  tStop   = +tauEnd;
  #tStop   = +5.0 / 1000;
  limitSize = floor((tStop/20 - tStart)/duration*lenX);
  if (nacfAndoFlag),
    phi_p = nACF_ANDO_( (tStop - tStart), duration, x, x );
  else 
    phi_p = nACF_( x( 1:limitSize ) );
  endif;
  #resultData = phi_p(1:220); # nACF
  resultData = phi_p; # nACF
  timeAxis = create_timeAxis_( tStart, tStop, length(resultData), duration );
  #timeAxis = timeAxis(1:220);
endif;


IACC = 0.0;
pointIACC = 0.0;
tauIACC = 0.0;
tauAlpha = 0.0;
tauBeta = 0.0;
Alpha = 0.0;
Beta = 0.0;
resultData2 = [];
Wiacc = 0.0;

if (iacfFlag),
  funcStr = "IACF";
  tauEnd = 1.0 / 1000; # [s] : OVERRIDE
  tStart  = -tauEnd;
  tStop   = +tauEnd;
  if (phiFlag),
    PHI_ll_0 = PHI_xy_( 0, duration, x, x );
    PHI_rr_0 = PHI_xy_( 0, duration, y, y );
    PHI_lr   = PHI_xy_( tauEnd, duration, x, y );
    phi_lr   = PHI_lr / sqrt( PHI_ll_0 * PHI_rr_0 );
  else 
    phi_lr   = IACF_( tauEnd, duration, x, y );
  endif;
  resultData = phi_lr; # IACF
  timeAxis = create_timeAxis_( tStart, tStop, length(resultData), duration );

  [IACC, pointIACC] = max( resultData(:) );
  tauIACC = timeAxis( pointIACC );
  
  resultData2 = abs( resultData(:) - 0.9*IACC );
  
  [tauAlphaIdx, Alpha] = min( resultData2( 1:pointIACC ) );
  [tauBetaIdx,  Beta ] = min( resultData2( pointIACC:length(resultData2) ) );
  Beta = Beta + pointIACC - 1;
  tauAlpha = timeAxis( Alpha );
  tauBeta  = timeAxis( Beta  );

  WiaccIdx = Beta - Alpha;
  #Wiacc = duration * WiaccIdx / lenX;
  Wiacc = tauBeta - tauAlpha;
endif;
toc();


if (plotFlag),
  clf ();
  figure(1);
  plot( timeAxis, resultData, 'b');
  xlabel('tau [ms]'); ylabel(funcStr);
  line( [0 0], [-1 1] );
  line( [tStart*1000 tStop*1000/2], [0 0] );
  if iacfFlag == 1,
    IACC_line = line( [tauIACC tauIACC], [0 IACC] );
    set(IACC_line,'color',[1 0 0]);
    Wiacc_line = line( [tauAlpha tauBeta], [0.9*IACC 0.9*IACC] );
    set(Wiacc_line,'color',[1 0.6 0]);
    strTitle = [ 'IACC= ', num2str(IACC), ', tauIACC= ', num2str(tauIACC), ', Wiacc= ', num2str(Wiacc) ];
    title( strTitle );
  endif;
  grid on;
  axis on;
  saveas (1, "figure1.jpg");
endif;


if (dumpFlag),
  [temp dateTime] = system("date +%y%m%d%H%M%S");
  dateTime = dateTime( 1 : length(dateTime)-1 );
  dumpFileName = strcat( "dump_calc_", funcStr, ".", dateTime, ".csv" );
  dump_data_( x, resultData, dumpFileName );
endif;


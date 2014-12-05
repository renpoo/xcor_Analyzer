function [rxx, timeVec, m, lag] = test_Compare_eachAC_CC_for_Waveform(wavFileName, window_size, ACorCCflag, whichFuncFlag, scale)
% Usage: [rxx, timeVec, m, lag] = test_Compare_eachAC_CC_for_Waveform(wavFileName, window_size, ACorCCflag, whichFuncFlag, scale)
%	rxx       Auto/Cross Correlation Fucntion
%	timeVec		Generated time vector
%	m         Time lag from tachi funcs
%	lag		    Time lag from Sys xcorr()
%	wavFileName   Filename of input waveform (string)
%	window_size   Size of window function
%	scale     scaling flag (default: 0)
%		0: none
%		1: biased		... rxx_scaled = rxx/N
%		2: unbiased		... rxx_scaled = rxx./(N-abs(m))
%		3: coeff		... rxx_scaled = rxx/(x'*x)
%
% Base Author:      R.O. Tachibana  (20140716)
% Revising Author:  TAISO, Renpoo   (20140718)


pkg load signal;


[x,fs,bits] = wavread(wavFileName);
sound(x,fs); # Sound test before computation
maxlag = window_size - 1;


#wavFileName2 = "Sounds/TestWhiteNoise.wav";
#[y,fs2,bits2] = wavread(wavFileName2);
#sound(y,fs2); # Sound test before computation


tic();

timeVec = zeros(1, window_size);
m = zeros(1, window_size);
lag = zeros(1, window_size);

if (strcmp(ACorCCflag, "AC")),
  if (strcmp(whichFuncFlag, "Org")),
    rxx = AutoCorrelation_org_(x, window_size);
  elseif (strcmp(whichFuncFlag, "Custom")),
    rxx = AutoCorrelation_(x, window_size);
  elseif (strcmp(whichFuncFlag, "Tachi")),
    [rxxTmp, m] = tachi_AutoCorrelation(x, maxlag, scale);
    rxx = rxxTmp';
  elseif (strcmp(whichFuncFlag, "Sys_xcorr")),
    #[rxxTmp, lagTmp] = xcorr ( x, maxlag, "coeff");
    #rxx = rxxTmp(floor(length(rxxTmp)/2 + 1):length(rxxTmp))';
    #lag = lagTmp(floor(length(lagTmp)/2 + 1):length(lagTmp))';
    [rxx, lag] = xcorr ( x, 4096, "coeff" );
    else
    error("ERROR: Please assign the string to use WHICH FUNCTIONS.");
  endif;
elseif (strcmp(ACorCCflag, "CC")),
  if (strcmp(whichFuncFlag, "Org")),
    rxx = CrossCorrelation_org_(x, window_size);
  elseif (strcmp(whichFuncFlag, "Custom")),
    rxx = CrossCorrelation_(x, window_size);
  elseif (strcmp(whichFuncFlag, "Tachi")),
    [rxxTmp, m] = tachi_CrossCorrelation(x, maxlag, scale);
    rxx = rxxTmp';
  elseif (strcmp(whichFuncFlag, "Sys_xcorr")),
    #[rxxTmp, lagTmp] = xcorr ( x, x, maxlag, "coeff" );
    #rxx = rxxTmp(floor(length(rxxTmp)/2 + 1):length(rxxTmp))';
    #lag = lagTmp(floor(length(lagTmp)/2 + 1):length(lagTmp))';
    [rxx, lag] = xcorr ( x, x, 4096, "coeff" );
  else
    error("ERROR: Please assign the string to use WHICH FUNCTIONS.");
  endif;
else
  error("ERROR: Please assign the string to use AC or CC.");
endif;


for k=1:window_size,
  timeVec(k) = (k-1) * 1000 / fs;
endfor;


toc();

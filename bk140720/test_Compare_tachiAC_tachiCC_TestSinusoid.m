# test_Compare_tachiAC_tachiCC_TestSinusoid.m
clear;

wavFileName = "Sounds/TestSinusoid.wav";
[x,fs,bits] = wavread(wavFileName);
sound(x,fs);
#N = length(x);
N = 512;
#nonScaleFlag = 0;
maxlag = N-1;


tic();
if (0),
  nonScaleFlag = 1;
  [rxx0, rxx1, rxx2, rxx3, m] = test_tachiAC_driver(x, N, nonScaleFlag);
  [rxy0, rxy1, rxy2, rxy3, m] = test_tachiCC_driver(x, N, nonScaleFlag);
  rxx = rxx3;
  rxy = rxy3;
endif;


if (1),
  scale = 3;
  [rxxTachi,m] = tachi_AutoCorrelation(x, maxlag, scale);
  [rxyTachi,m] = tachi_CrossCorrelation(x, maxlag, scale);
  #time = m;
endif;


if (1),
  window_size = N;
  if (1),
    rxxOrg = AutoCorrelation_org_(x, window_size);
    rxyOrg = CrossCorrelation_org_(x, window_size);
  endif;
  if (1),
    rxxCustom = AutoCorrelation_(x, window_size);
    rxyCustom = CrossCorrelation_(x, window_size);
  endif;
  time = zeros(1, window_size);
  for m=1:window_size,
     time(m) = (m-1)*1000 / fs;
  endfor;
endif;


diff_AC_Custom_Org = rxxCustom .- rxxOrg;
diff_CC_Custom_Org = rxyCustom .- rxyOrg;

#disp(diff_AC_Custom_Org);
#disp(diff_CC_Custom_Org);
disp(norm(diff_AC_Custom_Org));
disp(norm(diff_CC_Custom_Org));


diff_AC_Tachi_Org = rxxTachi' .- rxxOrg;
diff_CC_Tachi_Org = rxyTachi' .- rxyOrg;
#disp(diff_AC_Tachi_Org);
#disp(diff_CC_Tachi_Org);
disp(norm(diff_AC_Tachi_Org));
disp(norm(diff_CC_Tachi_Org));


#diff_AC_CC = rxx .- rxy;
#diff_AC_CC = zeros(maxlag+1, 1);


#plot(time, diff_AC_CC, 'b', time, rxx, 'g', time, rxy, 'r');
#plot(time, diff_AC_CC, 'b', time, rxx, 'g');
#timeVec = (1:window_size);
for k=1:window_size,
  timeVec(k) = (k-1) * 1000 / fs;
endfor;

if (0), # Tachi timeVec
  step = 256;
  len = length(x);
  nstep = floor((len-window_size+1)/step);
  timeVec = ((0:nstep-1)*step+window_size/2)/fs;
endif;


#plot(timeVec, diff_AC_CC, 'b', timeVec, rxy, 'r');
#plot(time, diff_AC_CC, 'k', time, rxx, 'b', time, rxy, 'r');
#plot(time, rxxOrg, 'b', time, rxyOrg, 'r');
#plot(time, rxxCustom, 'b', time, rxyCustom, 'r');
#plot(time, rxxOrg, 'b', time, rxyOrg, 'r', time, rxxCustom, 'k', time, rxyCustom, 'g');
plot(time, rxxOrg, 'b', time, rxyOrg, 'r', time, rxxTachi, 'k', time, rxyTachi, 'g');


xlabel('Time (ms)'); ylabel('Auto/Cross Correlation Func ()');
toc();

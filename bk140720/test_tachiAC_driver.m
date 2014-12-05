function [rxx0, rxx1, rxx2, rxx3, m] = test_tachiAC_driver(x, N, nonScaleFlag)
maxlag = N-1;


if (nonScaleFlag == 0)
  [rxx0, m] = tachi_AutoCorrelation(x,maxlag,0);
else
  rxx0 = zeros(N,1);
end
[rxx1, m] = tachi_AutoCorrelation(x,maxlag,1);
[rxx2, m] = tachi_AutoCorrelation(x,maxlag,2);
[rxx3, m] = tachi_AutoCorrelation(x,maxlag,3);


plot(m, rxx0, 'b', m, rxx1, 'g', m, rxx2, 'r', m, rxx3, 'c');
xlabel('Time (ms)'); ylabel('Auto Correlation Func ()');

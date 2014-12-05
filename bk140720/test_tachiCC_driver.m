function [rxy0, rxy1, rxy2, rxy3, m] = test_tachiCC_driver(x, N, nonScaleFlag)
maxlag = N-1;


if (nonScaleFlag == 0)
  [rxy0, m] = tachi_CrossCorrelation(x,maxlag,0);
else
  rxy0 = zeros(N,1);
end
[rxy1, m] = tachi_CrossCorrelation(x,maxlag,1);
[rxy2, m] = tachi_CrossCorrelation(x,maxlag,2);
[rxy3, m] = tachi_CrossCorrelation(x,maxlag,3);


plot(m, rxy0, 'b', m, rxy1, 'g', m, rxy2, 'r', m, rxy3, 'c');
xlabel('Time (ms)'); ylabel('Cross Correlation Func ()');

function [ xSubS, xSubE, ySubS, ySubE ] = getIntegralPeriod_at_k_( k, T_Idx )

if (k < 0),
  xSubS = 1;
  xSubE = T_Idx+k;
  xSubSize = xSubE - xSubS;
  ySubS = -k+1;
  ySubE = T_Idx;
  ySubSize = ySubE - ySubS;
else % when (0 <= k)
  xSubS = k+1;
  xSubE = T_Idx;
  xSubSize = xSubE - xSubS;
  ySubS = 1;
  ySubE = T_Idx-k;
  ySubSize = ySubE - ySubS;
end;

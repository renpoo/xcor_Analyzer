function PHI = PHI_xy_( tauEnd, duration, x, y )
% PHI_xy = Auto Correlation Function at tau
% tauEnd    : variable of time lag [s] can be e.g. +0.001;
% x  : input vector of signal can be e.g. L channel;
% y  : input vector of signal can be e.g. R channel;


[ T_Idx, tauIdx, startIdx, stopIdx ] = convTime2Index_for_Start_End_( tauEnd, duration, x );


%xE = vertcat( zeros( +T_Idx, 1 ), x, x ); % Expanded vector of x
%yE = vertcat( y, y, zeros( +T_Idx, 1 ) ); % Expanded vector of y
%xE = vertcat( zeros( +T_Idx, 1 ), x, zeros( +T_Idx, 1 ) ); % Expanded vector of x
%yE = vertcat( zeros( +T_Idx, 1 ), y, zeros( +T_Idx, 1 ) ); % Expanded vector of y


%PHI = zeros( tauIdx*2+1, 1 ); % vector to contain the calcurated result


%BaseIdx = +T_Idx;
%BaseIdx = +tauIdx;

PHI = [];
%PHI = 0.0;

for k = startIdx : stopIdx,
  [ xSubS, xSubE, ySubS, ySubE ] = calcIntegralPeriod_at_k_( k, T_Idx );
  xSub = x( xSubS:xSubE );
  ySub = y( ySubS:ySubE );
  
  PHI(length(PHI)+1) = CC_( xSub, ySub );
  %PHI = PHI + CC_( xSub, ySub );

  if (tauIdx == 0), break; end;
end;

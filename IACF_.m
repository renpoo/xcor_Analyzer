function Phi_lr = IACF_( tauEnd, duration, x, y )
% Phi_lr = Interaural Correlation Function at tau
% tauEnd    : variable of time lag [s] can be e.g. +0.001;
% duration  : variable of time duration [s] can be e.g. +3.0234;
% x  : input vector of signal can be e.g. L channel;
% y  : input vector of signal can be e.g. R channel;


[ T_Idx, tauIdx, startIdx, stopIdx ] = convTime2Index_for_Start_End_( tauEnd, duration, x );


#xE = vertcat( zeros( +T_Idx, 1 ), x, zeros( +T_Idx, 1 ) ); # Expanded vector of x
#yE = vertcat( zeros( +T_Idx, 1 ), y, zeros( +T_Idx, 1 ) ); # Expanded vector of y


Phi_lr = zeros( tauIdx, 1 ); # vector to contain the calcurated result


#BaseIdx = +T_Idx;


for k = startIdx : stopIdx,
  [ xSubS, xSubE, ySubS, ySubE ] = calcIntegralPeriod_at_k_( k, T_Idx );
  xSub = x( xSubS:xSubE );
  ySub = y( ySubS:ySubE );
  
  #Phi_lr( k+1 ) = nCC_( xE( 1+BaseIdx : (T_Idx-k+BaseIdx) ), yE( (k+1+BaseIdx) : T_Idx+BaseIdx ) );
  Phi_lr( k+1+tauIdx ) = nCC_( xSub, ySub );
  
  if (tauIdx == 0), break; endif;
endfor;

function R = CCF_( x, y )
% CCF = Cross Correlation Function
% x  : input vector of signal can be e.g. L channel;
% y  : input vector of signal can be e.g. R channel;

lenX = length(x);

for k = 1 : lenX,
  R( k ) = CC_( x( k:lenX ), y( 1:(lenX-k+1) ) );
endfor;

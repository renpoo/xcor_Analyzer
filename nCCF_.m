function Rxy = nCCF_( x, y )
% CCF = Cross Correlation Function
% x  : input vector of signal can be e.g. L channel;
% y  : input vector of signal can be e.g. R channel;

lenX = length(x);

normX = sqrt( x' * x );
normY = sqrt( y' * y );
detXY = normX * normY;

#Rxy = CCF_( x, y ) / detXY;
Rxy = cyclicCCF_( x, y ) / detXY;

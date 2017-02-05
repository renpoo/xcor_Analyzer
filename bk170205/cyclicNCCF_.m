function R = cyclicNCCF_( x, y )
% CCF = Cross Correlation Function
% x  : input vector of signal can be e.g. L channel;
% y  : input vector of signal can be e.g. R channel;

lenX = length(x);
indexVec = ( 1:lenX ); % Form index vector to get sub vectors

normX = sqrt( x' * x );
normY = sqrt( y' * y );
detXY = normX * normY;

for k = 1 : lenX,
  R( k ) = CC_( x( indexVec ), y( 1:lenX ) );
  tmpVec = indexVec(2 : lenX);
  tmpVec(lenX) = indexVec(1);
  indexVec = tmpVec;
end;

R = R /detXY;

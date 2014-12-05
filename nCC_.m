function nC = nCC_( x, y )
% nCC_( x, y ) : normalized Cross Correlation

nC = ( x' * y ) / ( sqrt(x' * x) * sqrt(y' * y) );

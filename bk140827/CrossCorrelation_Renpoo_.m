function C = CrossCorrelation_Renpoo_( x, y )

#normX = sqrt(x' * x); # Length of Vector X
#normY = sqrt(y' * y); # Length of Vector Y

#dotProdXY = x' * y;   # Dot Product of Vector X & Y

#C = dotProdXY / (normX * normY);

C = ( x' * y ) / ( sqrt(x' * x) * sqrt(y' * y) );
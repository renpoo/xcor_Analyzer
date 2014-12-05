function [Cfunc, timeAxis] = CrossCorrelationFunc_Renpoo_( x, y, window_size, start, stop, d )

# Length check for input Vectors X & Y
if (length(x) != length(y)) error("ERROR: CrossCorrelationFunc_Renpoo_(): Different length of input vectors."); endif;


lenX = length(x);


startIdx = round(start / d * lenX);
stopIdx  = round(stop  / d * lenX);
window_size_Idx = round(window_size / d * lenX);
half_window_size_Idx = round(window_size_Idx/2);


# Boundary check for the index related with window_size
if ( startIdx < half_window_size_Idx ) error("ERROR: CrossCorrelationDriver_Renpoo_(): Out of bound for specified start position to calcurate."); endif;
if ( lenX - stopIdx < half_window_size_Idx ) error("ERROR: CrossCorrelationDriver_Renpoo_(): Out of bound for specified stop position to calcurate."); endif;


spanIdx = stopIdx - startIdx;


Cfunc = zeros(spanIdx, 1);


timeAxis = ( 0 : spanIdx );
timeAxis = timeAxis - round(spanIdx/2);
timeAxis = timeAxis * window_size / spanIdx;


k = startIdx + round(spanIdx/2) ;
indexVec = ( k - half_window_size_Idx : k + half_window_size_Idx ); # Form index vector to get sub vectors


xSub = x(indexVec); # Initial cut from signal X
#ySub = y(indexVec); # Initial cut from signal Y


for k = startIdx : stopIdx,
  indexVec = ( k - half_window_size_Idx : k + half_window_size_Idx );
  ySub = y(indexVec); # Temporary cut from signal Y

  Cfunc( k - startIdx + 1 ) = CrossCorrelation_Renpoo_( xSub, ySub );
endfor;

function [Cfunc, timeAxis] = CrossCorrelationFunc_Renpoo_( x, y, window_size, start, stop, d )

# Length check for input Vectors X & Y
if (length(x) != length(y)) error("ERROR: CrossCorrelationFunc_Renpoo_(): Different length of input vectors."); endif;


lenX = length(x);


startIdx = round(start / d * lenX);
stopIdx  = round(stop  / d * lenX);
window_size_Idx = round(window_size / d * lenX);
half_window_size_Idx = round(window_size_Idx/2);


# Boundary check for the index related with window_size
#if ( startIdx < half_window_size_Idx ) error("ERROR: CrossCorrelationFunc_Renpoo_(): Out of bound for specified start position to calcurate."); endif;
if ( lenX - stopIdx < half_window_size_Idx ) error("ERROR: CrossCorrelationFunc_Renpoo_(): Out of bound for specified stop position to calcurate."); endif;


spanIdx = round(stopIdx - startIdx);


Cfunc = zeros(spanIdx, 1);


half_spanIdx = round(spanIdx/2);
timeAxis = ( 0 : spanIdx );
timeAxis = timeAxis - half_spanIdx;
timeAxis = timeAxis * window_size / spanIdx * 1000;


# Initial Expand from signal X & Y
xExpand = vertcat( zeros(half_window_size_Idx, 1), x, zeros(half_window_size_Idx, 1) );
yExpand = vertcat( zeros(half_window_size_Idx, 1), y, zeros(half_window_size_Idx, 1) );

# Initial Cut from signal X
k = startIdx + half_window_size_Idx*2;  # Center of cut vector (Tricky since this is after Expansion)
indexVec = ( k - half_window_size_Idx + 1 : k + half_window_size_Idx + 1 ); # Form index vector to get sub vectors
xSub = xExpand(indexVec);


counterStart = startIdx + half_window_size_Idx; # Tricky Value since the Vector X has already expanded
counterStop  = stopIdx  + half_window_size_Idx; # Tricky Value since the Vector X has already expanded
counterSpan  = counterStop - counterStart;
for k = counterStart : counterStop,
  indexVec = ( k - half_window_size_Idx + 1 : k + half_window_size_Idx + 1 );
  # Temporary cut from signal Y
  ySub = yExpand(indexVec);

  Cfunc( k - counterStart + 1) = CrossCorrelation_Renpoo_( xSub, ySub );
endfor;



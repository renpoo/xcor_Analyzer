function t = convIndex2Time_( tIdx, s, fs )

%t = ( tIdx - 1 ) * length(s) / fs ;
t = ( tIdx - 1 ) / fs ;

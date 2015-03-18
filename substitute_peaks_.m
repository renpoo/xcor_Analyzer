function [ minValVec, tauE_Vec, tauEidx_Vec ] = substitute_peaks_( val, inputDataMat, s, fs )

m = size( inputDataMat, 1 );
n = size( inputDataMat, 2 );

%tmpInputDataMat = ( inputDataMat*10^4 - fractionalPart_( inputDataMat*10^4 ) ) / 10^4;
tmpInputDataMat = inputDataMat;
tmpInputDataMat = tmpInputDataMat - val;
tmpInputDataMat = abs( tmpInputDataMat );

for i = 1 : m,
    [ minVal, minIdx ] = min( tmpInputDataMat( i, : ) );
    minValVec( i ) = minVal;
    tauEidx_Vec( i ) = minIdx;
    tauE_Vec( i ) = convIndex2Time_( tauEidx_Vec( i ), s, fs ) * 10^3;   % CAUTION!!
end;


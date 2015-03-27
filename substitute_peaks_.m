function [ minValVec, tauE_Vec, tauEidx_Vec ] = substitute_peaks_( val, inputDataMat, s, fs )

m = size( inputDataMat, 1 );
n = size( inputDataMat, 2 );

%eps = 10^(-5);
%eps = 6.0 * 10^(-6);
eps = 5.0 * 10^(-6);
%eps = 2.0 * 10^(-6);

minVal = 0.0;
minIdx = 0;

%tmpInputDataMat = ( inputDataMat*10^4 - fractionalPart_( inputDataMat*10^4 ) ) / 10^4;
tmpInputDataMat = inputDataMat;
tmpInputDataMat = tmpInputDataMat - val;
tmpInputDataMat = abs( tmpInputDataMat );

for i = 1 : m,
    for j = n : -1 : 1,
        %[ minVal, minIdx ] = min( tmpInputDataMat( i, : ) );
        if ( tmpInputDataMat( i, j ) < eps ),
            minVal = tmpInputDataMat( i, j );
            minIdx = j;
            break;
        end;
    end;
    
    minValVec( i ) = minVal;
    tauEidx_Vec( i ) = minIdx;
    tauE_Vec( i ) = convIndex2Time_( tauEidx_Vec( i ), s, fs ) * 10^3;   % CAUTION!!
end;


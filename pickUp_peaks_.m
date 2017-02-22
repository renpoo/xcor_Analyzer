%function [ maxValVec, envVec, envVecIdx ] = pickUp_peaks_( dataMat, eps, fs, unitScale )
%function [ maxValVec, envVecIdx ] = pickUp_peaks_( dataMat, targetVal, eps )
function [ maxValVec, envVecIdx ] = pickUp_peaks_( dataMat, eps )

m = size( dataMat, 1 );
n = size( dataMat, 2 );

maxVal = 0.0;
maxIdx = 0;

maxValVec = zeros( 1, m );
envVecIdx = zeros( 1, m );
envVec = zeros( 1, m );


for i = 1 : m
    %for j = n : -1 : 1
    for j = 1 : +1 : n
        if ( 0 )
            [ maxVal, maxIdx ] = max( dataMat( i, : ) );
        else
            if ( dataMat( i, j ) < eps )
                maxVal = dataMat( i, j );
                maxIdx = j;
                %break;
                continue;
            end
        end
    end
    
    maxValVec( i ) = maxVal;
    envVecIdx( i ) = maxIdx;
%    envVec( i ) = convIndex2Time_( envVecIdx( i ), fs ) * unitScale;
end

end

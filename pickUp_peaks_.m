function [ minValVec, envVec, envVecIdx ] = pickUp_peaks_( dataMat, eps, fs )

m = size( dataMat, 1 );
n = size( dataMat, 2 );

minVal = 0.0;
minIdx = 0;

minValVec = zeros( 1, m );
envVecIdx = zeros( 1, m );
envVec = zeros( 1, m );


for i = 1 : m
    for j = n : -1 : 1
        if ( 0 )
            [ minVal, minIdx ] = min( dataMat( i, : ) );
        else
            if ( dataMat( i, j ) > eps )
                minVal = dataMat( i, j );
                minIdx = j;
                break;
            end
        end
    end
    
    minValVec( i ) = minVal;
    envVecIdx( i ) = minIdx;
    envVec( i ) = convIndex2Time_( envVecIdx( i ), fs );
end

end

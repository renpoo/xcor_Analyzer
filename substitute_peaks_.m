function [ maxValVec, tauE_Vec, tauEidx_Vec, tmpEpsVec ] = substitute_peaks_( val, eps, inputDataMat, s, fs )

m = size( inputDataMat, 1 );
n = size( inputDataMat, 2 );

disp('%%%%%');
%disp(m);
%disp(n);

tmpInputDataMat = ( inputDataMat*10^4 - fractionalPart_( inputDataMat*10^4 ) ) / 10^4;
tmpEps = eps;


for i = 1 : m,
    for j = 1 : n,
        if ( abs( tmpInputDataMat( i , j ) - val ) < tmpEps ),
            maxValVec( i ) = tmpInputDataMat( i , j );
            tauEidx_Vec( i ) = j;
            tauE_Vec( i ) = abs( convIndex2Time_( tauEidx_Vec( i ), s, fs ) ) * 10^3;
            %if ( j == n ) break; end;
            tmpEps = abs( tmpInputDataMat( i , j ) - val );
        end;
        tmpEpsVec( i, j )  = tmpEps;    
    end;
    tmpEps = eps;
end;


function [ maxValVec, tauE_Vec ] = substitute_peaks_( val, eps, inputDataMat, s, fs )

m = size( inputDataMat, 1 );
n = size( inputDataMat, 2 );

%disp(m);
%disp(n);

tmpInputDataMat = inputDataMat - val;
tmpEps = eps;

for i = 1 : m,
    for j = 1 : n,
        if ( abs( tmpInputDataMat( i , j ) ) < tmpEps ),
            %disp('###');
            %disp( strcat( num2str( inputDataMat( i , j ) ), ' (', num2str( i ), ', ',  num2str( j ), ')' ) );
            %disp('###');
            maxValVec( i ) = inputDataMat( i , j );
            tauEidx_Vec( i ) = j;
            tauE_Vec( i ) = convIndex2Time_( tauEidx_Vec( i ), s, fs ) * 10^3;
            tmpEps = abs( tmpInputDataMat( i , j ) );
        end;
    end;
    tmpEps = eps;
end;

function A = fiboNumberGeneral( n )

A = 0;

m = sqrt( 5 );
alpha = ( 1 - m ) / 2;
beta  = ( 1 + m ) / 2;

a0 = 1;
a1 = 1;

if ( 0 ),
    if ( n == 0 ), A = 0;    
    elseif ( n < 3 ), A = a1; 
    else
        for ( i = 3 : n ),
            tmp = a0;
            a0 = a1;
            a1 = tmp + a0;
        end;
        A = a1;
    end;
elseif ( 0 ),
    for k = 0 : n-1,
        if ( n-k-1 < k ) break; end;
        A = A + nchoosek( n-k-1, k );
    end;
elseif ( 0 ),
    for k = 0 : n-1,
        %if ( n-k-1 < k ) break; end;
        A = A + power(beta,n-k-1) * power(alpha,k);
        %A = A / beta;
    end;
elseif ( 0 ),
    A = ( a1 * (power(beta,(n-1))-power(alpha,(n-1))) + a0 * (power(beta,(n-2))-power(alpha,(n-2))) ) / ( beta - alpha );
else
    A = ( power(beta,n)-power(alpha,n) ) / ( beta - alpha );
end;

function Un = lucas_Un( P, Q, n )

Un = 0;

D = power( P, 2 ) - 4 * Q;
alpha = ( P + sqrt(D) ) / 2;
beta  = ( P - sqrt(D) ) / 2;

Un = ( power( alpha, n ) - power( beta, n ) ) / ( alpha - beta );

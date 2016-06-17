function Vn = lucas_Vn( P, Q, n )

Vn = 0;

D = power( P, 2 ) - 4 * Q;
alpha = ( P + sqrt(D) ) / 2;
beta  = ( P - sqrt(D) ) / 2;

Vn = ( power( alpha, n ) + power( beta, n ) );

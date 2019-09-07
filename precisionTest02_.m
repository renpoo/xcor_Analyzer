function precisionTest02_( a, b, c )

D = b^2 - 4 * a * c;
sqrtD = sqrt(D);

x1 = ( -b + sqrtD ) / 2 * a
x2_a = ( -b - sqrtD ) / 2 * a

x2_b = c / ( a * x1 )

end

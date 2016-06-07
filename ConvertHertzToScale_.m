function Answer = ConvertHertzToScale_( hertz )

if (hertz == 0) Answer = 0.0;
else Answer = ( 12.0 * log( hertz / 110.0 ) / log( 2.0 ) );
end;


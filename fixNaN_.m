function v = fixNaN_( val )

if ( isnan(val) ),
    v = 0.0;
else,
    v = val;
end;

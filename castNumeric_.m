function returnNum = castNumeric_( value )

if ( isnumeric( value ) ),
    returnNum = value;
else,
    returnNum = str2num( value );
end;

end


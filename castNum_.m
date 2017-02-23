function retNum = castNum_( value )

if ( isnumeric( value ) ),
    retNum = value;
else
    retNum = str2double( value );
end;

end

function retStr = castStr_( value )

if ( isnumeric( value ) ),
    retStr = num2str( value );
else
    retStr = value;
end;

end

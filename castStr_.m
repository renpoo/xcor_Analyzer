function retNum = castStr_( value )

if ( isnumeric( value ) ),
    retNum = double2str( value );
else
    retNum = value;
end;

end

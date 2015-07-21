function retNum = castStr_( value )

if ( isstring( value ) ),
    retNum = value;
else
    retNum = double2str( value );
end;

end

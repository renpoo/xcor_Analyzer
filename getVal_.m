function retNum = getVal_( value )

len = size( value );

if ( len > 1 ),
    retNum = value{ 1 };
else
    retNum = value;
end;

end

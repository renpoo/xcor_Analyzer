function retNum = getVal_( value )

if ( length( value ) > 1 ),
    retNum = value{ 1 };
else
    retNum = value;
end;

end

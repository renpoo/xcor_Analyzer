function detX = init_PHI_( x )

detX = sqrt( x * x' );

if (detX == 0.0)
    detX = NaN;
    return;
end

end

function phi = timeDependent_phi_xy_( x, y, initDetXY )

T_Idx = length(x);

N2 = 2 * T_Idx - 1;

phi = zeros(1, N2);


%for k = startIdx : stopIdx
for k = 0 : T_Idx-1
    
    xSubS = k+1;
    xSubE = T_Idx;
    
    ySubS = 1;
    ySubE = T_Idx-k;
    
    xSub = x( xSubS : xSubE );
    ySub = y( ySubS : ySubE );
    
    
    tmp = PHI_xy_( xSub, ySub ) / initDetXY;
    %tmp = xcorr( xSub, ySub ) / initDetXY;

    
    figure; plot(vectorReshape_(tmp, N2));

    
    phi( k+1, : ) = vectorReshape_(tmp, N2);
    
end


figure; surf(phi);


end

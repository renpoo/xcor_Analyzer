function phi = timeDependent_phi_xy_( x, y )

fs = 1;
duration = length(x) / fs;
timeT = 0.01;

T_Idx = length(x);
very_startIdx = -T_Idx;
very_stopIdx  = +T_Idx;
very_spanIdx  = round(very_stopIdx - very_startIdx);


tauIdx = floor(timeT / duration * very_spanIdx / 2);
startIdx = -tauIdx;
stopIdx  = +tauIdx;


%phi = [];
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
    
    
    %tmp = PHI_xy_( xSub, ySub );
    tmp = xcorr( xSub, ySub );
    
    figure; plot(vectorReshape_(tmp, N2));
    
    phi( k+1, : ) = vectorReshape_(tmp, N2);

end;

function plotOVERRIDE_tauE_Vec_( data, results )

hold on;

clipValVec = ones( 1, length( results.timeAxis ) ) * data.clipVal;

lw = 2;
ms = 3;
lc = '-ow';

if ( data.LRCflag == 'R' || data.LRCflag == 'C' )
    lc = '-w';
    plot3(  results.tauE_Vec_R * data.xUnitScale, results.timeAxis, clipValVec, lc, 'LineWidth', lw, 'MarkerSize', ms );
    
    lc = '-r';
    plot3(  results.env_tauE_Vec_R * data.xUnitScale, results.timeAxis, clipValVec + 0.1, lc, 'LineWidth', lw, 'MarkerSize', ms );
end

if ( data.LRCflag == 'L' || data.LRCflag == 'C' )
    lc = '-w';
    plot3( -results.tauE_Vec_L * data.xUnitScale, results.timeAxis, clipValVec, lc, 'LineWidth', lw, 'MarkerSize', ms );
    
    lc = '-b';
    plot3( -results.env_tauE_Vec_L * data.xUnitScale, results.timeAxis, clipValVec + 0.1, lc, 'LineWidth', lw, 'MarkerSize', ms );
end

hold off;

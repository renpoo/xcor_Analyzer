function plotSurface_phi_lr_( results )


figure;

surf( results.tauAxis, results.timeAxis, results.phi_lrMat, 'FaceColor','interp', 'LineStyle', 'none' );
colormap 'jet';


if (results.LRCflag == 'L')
    xmax = 0;
    xmin = -max( abs( results.tauAxis ) );
elseif (results.LRCflag == 'R')
    xmax = max( abs( results.tauAxis ) );
    xmin = 0;
else
    xmax = max( abs( results.tauAxis ) );
    xmin = -xmax;
end

xlim([xmin xmax]);


grid on;


hold on;


lc = 'ow';
lw = 2;
ms = 3;


if ( results.LRCflag == 'C' )
    plot3( results.tauICCCMat', results.timeAxis, results.ICCCMat', lc, 'LineWidth', lw, 'MarkerSize', ms );
end


zLabelStr = results.zLabelStr;

if ( strcmp( zLabelStr, 'ACF' ) )
    zLabelStr = strcat( zLabelStr, ' [', results.LRCflag, '] ' );
end

xlabel( results.xLabelStr );
ylabel( results.yLabelStr );
zlabel( zLabelStr );


strTitle = strcat( '(', results.graphTitle, '),', zLabelStr, ',', 't[', num2str(results.timeS0, '%04.2f'), ' - ', num2str(results.timeE0, '%04.2f'), ']' );


title( strTitle );


hold off;

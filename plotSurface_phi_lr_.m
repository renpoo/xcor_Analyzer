function plotSurface_phi_lr_( handles )


figure;

surf( handles.results.tauAxis, handles.results.timeAxis, handles.results.phi_lrMat, 'FaceColor','interp', 'LineStyle', 'none' );
colormap 'jet';


zLabelStr = handles.results.zLabelStr;


if (handles.data.LRCflag == 'L')
    xmax = 0;
    xmin = -max( abs( handles.results.tauAxis ) );
    tmpLabelStr = strcat( zLabelStr, ' [', handles.data.lWavChLabel, '] ' );
elseif (handles.data.LRCflag == 'R')
    xmax = max( abs( handles.results.tauAxis ) );
    xmin = 0;
    tmpLabelStr = strcat( zLabelStr, ' [', handles.data.rWavChLabel, '] ' );
else
    xmax = max( abs( handles.results.tauAxis ) );
    xmin = -xmax;
    tmpLabelStr = strcat( zLabelStr, ' [', handles.data.lWavChLabel, ' <-> ', handles.data.rWavChLabel, '] ' );
end

xlim( [xmin xmax] );


grid on;


hold on;


lc = 'ow';
lw = 2;
ms = 3;


if ( handles.data.LRCflag == 'C' )
    plot3( handles.results.tauICCCMat', handles.results.timeAxis, handles.results.ICCCMat', lc, 'LineWidth', lw, 'MarkerSize', ms );
end


xlabel( handles.results.xLabelStr );
ylabel( handles.results.yLabelStr );
zlabel( zLabelStr );


strTitle = strcat( '(', handles.results.graphTitle, '), travel- ', tmpLabelStr, ', t[', num2str(handles.results.timeS0, '%04.2f'), ' - ', num2str(handles.results.timeE0, '%04.2f'), ']', ',', ' tau[', num2str(handles.data.timeT, '%04.3f'), ']'  );


title( strTitle );


hold off;


function plot_graph_everyMoment_( handles, i )

plotData   = handles.results.phi_lrMat( i, : );
tauAxis    = handles.results.tauAxis;
graphTitle = handles.data.graphTitle;
dateTime   = handles.results.dateTime;
xLabelStr  = handles.data.xLabelStr;
yLabelStr  = handles.data.yLabelStr;
timeS0     = handles.data.timeS0;
timeE0     = handles.data.timeE0;
tau        = handles.data.timeT;
t          = handles.results.timeAxis( i );
params     = handles.results.paramsMat{ i };


tauStart = tauAxis( 1 );
tauStop  = tauAxis( length( tauAxis ) );

figure( 1 );

plot( tauAxis, plotData, 'b');
xlabel( xLabelStr );
ylabel( yLabelStr );


hold on;


Xline = line( [ tauStart tauStop ], [0 0] );
set(Xline, 'color', [ 0.6 0.6 0.6 ]);

Yline = line( [0 0], [-1 1] );
set(Yline, 'color', [ 0.6 0.6 0.6 ]);

grid on;

axis( [ tauStart, tauStop, -1.0, 1.0 ], 'square' );


lastI = floor( numel( params ) / length( params ) );
if (lastI >= 1)
    for ( i = 1 : lastI )
        xS = params( i, 1 );
        xE = params( i, 2 );
        yS = params( i, 3 );
        yE = params( i, 4 );
        colR = params( i, 5 );
        colG = params( i, 6 );
        colB = params( i, 7 );
        
        paramLine = line( [ xS xE ], [ yS yE ] );
        set(paramLine, 'color', [colR colG colB]);
    end
end


graphTitle = strcat( '(', graphTitle, '),', yLabelStr , ',' );


title( strcat( graphTitle, 't[', num2str(t, '%04.2f'), ' - ', num2str(t + tau, '%04.2f'), ']' ) );


hold off;





pnameImg = strcat( '_Output Images', '/', graphTitle, dateTime, ',', 'timeS0,', num2str(timeS0, '%04.2f'), ',', 'timeE0,', num2str(timeE0, '%04.2f'), ',', 'tau,', num2str(tau, '%04.3f') );
if ( exist( pnameImg, 'dir' ) == 0 )
    mkdir( pnameImg );
end

saveImageName = strcat( graphTitle, 'timeS0,', num2str(timeS0, '%04.2f'), ',', 'timeE0,', num2str(timeE0, '%04.2f'), ',', 't,', num2str(t, '%04.3f') );

fname = strcat( saveImageName, '.jpg');
outputDataFileName = strcat( pnameImg, '/', fname );
saveas( 1, strcat( outputDataFileName ) );


end


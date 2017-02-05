function plot_graph_( plotData, timeAxis, saveImageName, funcStr, strTitle, xLabel, yLabel, params, graphTitle, dateTime, timeS0, timeE0, tS, tE, timeT )

tStart = timeAxis( 1 );
tStop  = timeAxis( length(timeAxis) );

clf ();
figure(1);

plot( timeAxis, plotData, 'b');
%xlabel('tau [ms]');
%ylabel(funcStr);
xlabel( xLabel );
ylabel( funcStr );

Xline = line( [ tStart tStop ], [0 0] );
set(Xline, 'color', [ 0.6 0.6 0.6 ]);

Yline = line( [0 0], [-1 1] );
set(Yline, 'color', [ 0.6 0.6 0.6 ]);

grid on;
%axis( [ tStart, tStop, -maxValue, maxValue ], 'square' );
axis( [ tStart, tStop, -1.0, 1.0 ], 'square' );


lastI = floor(numel(params)/length(params));
if (lastI >= 1),
    for ( i = 1 : lastI ),
        xS = params( i, 1 );
        xE = params( i, 2 );
        yS = params( i, 3 );
        yE = params( i, 4 );
        colR = params( i, 5 );
        colG = params( i, 6 );
        colB = params( i, 7 );

        paramLine = line( [ xS xE ], [ yS yE ] );
        set(paramLine, 'color', [colR colG colB]);
    end;
end;

title( strTitle );


pnameImg = strcat( '_Output Images', '/', graphTitle, '_', funcStr , '_', dateTime, '_', 'timeS0,', num2str(timeS0, '%04.3f'), ',', 'timeE0,', num2str(timeE0, '%04.3f'), ',', 'T,', num2str(timeT, '%04.3f') );
%pname = strcat( '_Output Images', '/', graphTitle, '_', funcStr , '_', dateTime, '_', 'tS0,', num2str(tS0, '%04.3f'), ',', 'tE0,', num2str(tE0, '%04.3f'), ',', 'T,', num2str(tStop/1000.0, '%04.3f') );
if ( exist( pnameImg, 'dir' ) == 0 ),
  mkdir( pnameImg );
end;
fname = strcat( saveImageName, '.jpg');
outputDataFileName = strcat( pnameImg, '/', fname );
saveas( 1, strcat( outputDataFileName ) );

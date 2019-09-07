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

tauWidth = (tauStop - tauStart);


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
        
        
        if (handles.data.LRCflag == 'L')
            text( 0.7 * tauWidth, -0.5 - i * 0.1, strcat( 'Max(', castStr_( i ), '): ', castStr_( params( i, 4 ) ) ), 'Color', [colR colG colB]);
        elseif (handles.data.LRCflag == 'R')
            text( 0.7 * tauWidth, -0.5 - i * 0.1, strcat( 'Max(', castStr_( i ), '): ', castStr_( params( i, 4 ) ) ), 'Color', [colR colG colB]);
        else
            switch i
                case 1
                    text( -0.4 * tauWidth, -0.8, strcat( 'ICCC: ',     castStr_( params( 1, 4 ) ) ), 'Color', [colR colG colB]);
                case 2
                    text(  0.2 * tauWidth, -0.8, strcat( 'Wiccc: ',    castStr_( params( 2, 4 ) ) ), 'Color', [colR colG colB]);
                case 3
                    text( -0.4 * tauWidth, -0.9, strcat( 'tauAlpha: ', castStr_( params( 3, 1 ) ) ), 'Color', [colR colG colB]);
                case 4
                    text(  0.2 * tauWidth, -0.9, strcat( 'tauBeta: ',  castStr_( params( 4, 1 ) ) ), 'Color', [colR colG colB]);
                otherwise
                    % do nothing
            end
        end
    end    
end


zLabelStr = handles.results.zLabelStr;



if (handles.data.LRCflag == 'L')
    tmpLabelStr = handles.data.lWavChLabel;
elseif (handles.data.LRCflag == 'R')
    tmpLabelStr = handles.data.rWavChLabel;
else
    tmpLabelStr = strcat( handles.data.lWavChLabel, ' <-> ', handles.data.rWavChLabel );
end

zLabelStr = strcat( zLabelStr, ' [', tmpLabelStr, '] ' );


graphTitle = strcat( '(', graphTitle, '),', zLabelStr , ',' );


title( strcat( graphTitle, 't[', num2str(t, '%04.2f'), ' - ', num2str(t + tau, '%04.2f'), ']' ) );


hold off;



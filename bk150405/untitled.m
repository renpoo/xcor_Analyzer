                timeVec = (0:nStepIdx) * (tE0 - tS0) / nStepIdx + tS0;
                %XYZ = surf( timeAxisMat( 1,: ), timeVec, resultDataMat, 'FaceColor','interp','FaceLighting','phong', 'LineWidth', 0.01, 'EdgeAlpha', 0.3 );
                XYZ = surf( timeAxisMat( 1, 1:5000 ), timeVec( 1, 1:5000 ), resultDataMat( 1:5000, : ), 'FaceColor','interp', 'LineWidth', 0.01, 'EdgeAlpha', 0.2 );
                grid on;
                hold on;
                
                if ( flags.iccfFlag ),
                    lw = 3;
                    ms = 4;
                    %lc = '-ow';
                    lc = 'ow';
                    plot3( tauICCCMat, timeVec( 1, 1:5000 ), ICCCMat( 1:5000 ), lc, 'LineWidth', lw, 'MarkerSize', ms );
                end;
                
                xlabel( xLabelStr );
                ylabel( yLabelStr );
                zlabel( zLabelStr );
                
                strTitle = strcat( '[', yLabel, ' <-> ', xLabel, ']', ' (' ,  num2str(tS0, '%04.2f'), '-', num2str(tE0, '%04.2f'), '), ', graphTitle);
                title( strTitle );
                
                hold off;
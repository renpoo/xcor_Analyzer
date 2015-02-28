for ( i = 1 : nStepIdx+1 ),
    idxVec = ( 1 : zeroIdxsMat( i, 1 ) );
    disp( 'idxVec' );
    disp( idxVec );
    subResultVec = resultDataMat( i, idxVec );
    disp( 'subResultVec' );
    disp( subResultVec );
    CAI( i ) = sum( subResultVec );
    disp( strcat( 'CAI( ', i, ' )' ) );
    disp( CAI( i ) );
end;


plot( CAI, 'b' );
xlabel('number of index [frame]'); ylabel('CAI');

grid on;

title( strTitle );
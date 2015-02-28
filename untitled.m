for ( i = 1 : nStepIdx+1 ),
    tmp( i ) = sum( resultDataMat( 1:zeroIdxsMat( i, 1 )));
    disp( tmp( i ) );
end;

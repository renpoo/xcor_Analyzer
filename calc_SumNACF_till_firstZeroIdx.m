bufSizeTmp = 100;
partVec = zeros( nStepIdx+1, bufSizeTmp );

for ( i = 1 : nStepIdx+1 ),
    disp( ( 1 : zeroIdxsMat( i, 1 ) ) );
    partVec = resultDataMat( i, (1 : zeroIdxsMat( i, 1 ) ) );
    disp( partVec );
    sumNACF_till_firstZeroIdx( i ) = sum( partVec );
    disp(  sumNACF_till_firstZeroIdx( i ) );
end;

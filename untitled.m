x = [0,2,4,2,0,-2,-4,-2,0];
y = [0,-2,-4,-2,0,2,4,2,0];


actSolution = PHI_xy_( x, y, 'C' );
figure; plot( actSolution );

actSolution = actSolution / init_PHI_( x ) / init_PHI_( y );
figure; plot( actSolution );


figure; plot( x );
figure; plot( y );

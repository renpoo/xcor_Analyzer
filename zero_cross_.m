function [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_( x, wholeFlag, skipFlag )

zeroIdxs = find( abs( diff( sign(x) ) ) == 2 );

maxValues = zeros( 1, 1 );
maxIdxs   = zeros( 1, 1 );


[ maxV, maxI ]  = max( x );
small = 1;
big   = length(x);


if length( zeroIdxs ) > 1
    
    maxValues = zeros( floor( length(zeroIdxs)/2 ), 1 );
    maxIdxs   = zeros( floor( length(zeroIdxs)/2 ), 1 );
    
    for i = 1 : 1 : length(zeroIdxs) - 1
        [ maxVal, maxIdx ]  = max( x( zeroIdxs( i ) : zeroIdxs( i+1 ) ) );
        
        if ( mod( i, 2 ) == 1 && skipFlag ), continue; end;
        
        maxValues( floor(i/2) + 1 ) = maxVal;
        maxIdxs(   floor(i/2) + 1 ) = maxIdx + zeroIdxs( i ) - 1 ;
        
        if ( maxV <= maxValues( floor(i/2)+1 ) )
            maxV  = maxValues( floor(i/2)+1 );
            maxI  = maxIdxs( floor(i/2)+1 );
            small = zeroIdxs( i ) ;
            big   = zeroIdxs( i+1 ) ;
        end
        
    end
end


if (wholeFlag)
    maxValues = [];
    maxIdxs   = [];
    zeroIdxs  = [];
    maxValues(1) = maxV;
    maxIdxs(1)   = maxI;
    zeroIdxs = [ small, big ];
end

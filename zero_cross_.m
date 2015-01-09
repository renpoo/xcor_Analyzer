function [ maxValues, maxIdxs, zeroIdxs ] = zero_cross_( x, wholeFlag, skipFlag )

zeroIdxs = find( abs( diff( sign(x) ) ) == 2 )';

[ maxV, maxI ]  = max( x );
small = 1;
big   = length(x);


if (0),
disp("zeroIdxs");
disp(zeroIdxs);
disp("length(zeroIdxs)");
disp(length(zeroIdxs));
endif;


if length( zeroIdxs ) > 1,
  maxValues = zeros( floor( length(zeroIdxs)/2 ), 1 );
  maxIdxs   = zeros( floor( length(zeroIdxs)/2 ), 1 );
  for i = 1 : length(zeroIdxs)-1 ,
    [ maxVal, maxIdx ]  = max( x( zeroIdxs(i) : zeroIdxs(i+1) ) );
    if ( mod( i, 2 ) == 1 && skipFlag) continue; endif;
    maxValues(i) = maxVal;
    maxIdxs(i)   = maxIdx + zeroIdxs(i) - 1 ;
    if ( maxV <= maxValues(i) ),
      maxV  = maxValues(i);
      maxI  = maxIdxs(i);
      small = zeroIdxs(i) ;
      big   = zeroIdxs(i+1) ;
    endif;
  endfor;
endif;  


if (wholeFlag),
  maxValues = [];
  maxIdxs   = [];
  zeroIdxs  = [];
  maxValues(1) = maxV;
  maxIdxs(1)   = maxI;
  zeroIdxs = [small, big];
endif;
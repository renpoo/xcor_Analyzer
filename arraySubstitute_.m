function [ resultArray ] = arraySubstitute_( inputArray, bufSize )

resultArray = zeros(bufSize, 1);
#resultArray = {0};

if ( length(inputArray) == 0 ) return; endif;


if (length(inputArray) > bufSize),
  n = bufSize;
else
  n = length(inputArray);
endif;


for (i = 1 : n ),
  resultArray( i ) = inputArray( i );
endfor;

#resultArray = inputArray( 1 : n )';

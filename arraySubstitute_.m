function [ resultArray ] = arraySubstitute_( inputArray, bufSize )

resultArray = zeros(bufSize, 1);
%resultArray = {0};

if ( length( inputArray ) == 0 ) return; end;


if (length(inputArray) > bufSize),
  n = bufSize;
else
  n = length(inputArray);
end;


for (i = 1 : n ),
  resultArray( i ) = inputArray( i );
end;

%resultArray = inputArray( 1 : n )';

function [ resultvector ] = vectorSubstitute_( inputvector, bufSize )

resultvector = zeros(bufSize, 1);
%resultvector = {0};
len = length( inputvector );

if ( len == 0 ) return; end;


if ( len > bufSize),
  n = bufSize;
else
  n = len;
end;

%{%}
for (i = 1 : n ),
  resultvector( i ) = inputvector( i );
end;
%{%}

%resultvector = inputArray( 1 : n )';

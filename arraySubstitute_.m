function [ resultArray ] = arraySubstitute_( inputArray, bufSize )

resultArray = zeros(bufSize, 1);
%resultArray = {0};
len = length( inputArray );

if ( len == 0 ) return; end;


if ( len > bufSize),
  n = bufSize;
else
  n = len;
end;

%{%}
for (i = 1 : n ),
  resultArray( i ) = inputArray( i );
end;
%{%}

%resultArray = inputArray( 1 : n )';

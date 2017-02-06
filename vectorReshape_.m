function [ resultVector ] = vectorReshape_( inputVector, bufSize )

resultVector = zeros(bufSize, 1);
len = length( inputVector );

if ( len == 0 )
    return;
end


n = min( len, bufSize );


for i = 1 : n
  resultVector( i ) = inputVector( i );
end

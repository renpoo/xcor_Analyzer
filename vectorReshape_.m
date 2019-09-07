function [ resultVector ] = vectorReshape_( inputVector, bufSize )

resultVector = zeros( 1, bufSize );

len = length( inputVector );

if ( len == 0 )
    return;
end

if ( len >= bufSize )
    resultVector = inputVector( 1 : bufSize );
else
    resultVector = [ inputVector; zeros( bufSize - len, 1 ) ];
end


%n = min( len, bufSize );



%S = [S S2]


% for i = 1 : n
%   resultVector( i ) = inputVector( i );
% end

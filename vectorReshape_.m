function [ resultVec ] = vectorReshape_( inputVec, bufSize )

resultVec = zeros(1, bufSize);

N_half_res = ceil(bufSize / 2);
Len = length(inputVec);
N_half_inp = ceil(Len / 2);

N_base = N_half_res - N_half_inp;

for i = 1 : Len
  resultVec( i + N_base ) = inputVec( i );
end

function [ env_inputVec, env_inputVec_Idx ] = getEnvelope_( inputVec, minPeakDist )

[ ~, idx ] = findpeaks( inputVec, 'MINPEAKDISTANCE', minPeakDist );
idx = [ 1 idx length(inputVec) ];
env_inputVec_Idx = 1 : length(inputVec);

env_inputVec = interp1( idx, inputVec( idx ), env_inputVec_Idx, 'pchip', 'extrap');

end

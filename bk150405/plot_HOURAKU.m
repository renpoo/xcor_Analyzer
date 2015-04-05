[ pks, idx ] = findpeaks( tauE_Vec, 'MINPEAKDISTANCE', 2 );
idx = [ 1 idx length(tauE_Vec) ];
tmpIdx = 1 : length(tauE_Vec);
%tmpTimeVec = tmpIdx./(tE0 - tS0);
env_tauE_Vec = interp1( idx, tauE_Vec( idx ), tmpIdx, 'cubic', 'extrap');

%plot( tmpTimeVec, env_tauE_Vec );
plot( tmpIdx, env_tauE_Vec );

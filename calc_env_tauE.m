function [ env_tauE_Vec, env_tauE_Idx ] = calc_env_tauE( tauE_Vec, duration )

[ pks, idx ] = findpeaks( tauE_Vec, 'MINPEAKDISTANCE', 1 );
idx = [ 1 idx length(tauE_Vec) ];
env_tauE_Idx = 1 : length(tauE_Vec);

env_tauE_Vec = interp1( idx, tauE_Vec( idx ), env_tauE_Idx, 'cubic', 'extrap');

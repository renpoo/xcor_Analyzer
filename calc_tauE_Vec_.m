function results_new = calc_tauE_Vec_( data, results )

results_new = results;


%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
%%%%
%%%% Custom OVERRIDE Setting
%%%%

LPFflag = 1; % 1 : MATLAB default Low-Pass-Filter
cutOffFreq = 1000;
eps = 0.01;
minPeakDist = 1;

%%%%
%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%


if ( LPFflag == 1 )
    fNorm = cutOffFreq / ( data.fs / 2 );
    df = designfilt( 'lowpassfir', 'FilterOrder', 70, 'CutoffFrequency', fNorm );
    %grpdelay( df, 2048, fs );
    D = mean( grpdelay( df ) );
end


if ( data.LRCflag == 'R' || data.LRCflag == 'C' )
    rightHalf_phi_lrMat = results.phi_lrMat( : , floor ( 1 + size( results.phi_lrMat, 2 ) / 2 ) : size( results.phi_lrMat, 2 ) );
    clipped_rightHalf_phi_lrMat = abs( rightHalf_phi_lrMat - data.clipVal );
    
     m = size( clipped_rightHalf_phi_lrMat, 1 );
     n = size( clipped_rightHalf_phi_lrMat, 2 );
    
    [ results_new.maxValVec_R, results_new.tauE_Vec_R_Idx ] = pickUp_peaks_( clipped_rightHalf_phi_lrMat, eps );
    
    results_new.tauE_Vec_R = ( results_new.tauE_Vec_R_Idx - 1 ) / n * data.timeT;   
    
    if ( LPFflag == 1 )
        results_new.env_tauE_Vec_R = filter( df, [ results_new.tauE_Vec_R'; zeros(D,1) ] );
        results_new.env_tauE_Vec_R = results_new.env_tauE_Vec_R( D+1 : end );
    else
        [ results_new.env_tauE_Vec_R, results_new.env_tauE_Idx_R ] = getEnvelope_( results_new.tauE_Vec_R, minPeakDist );
    end
    
    results_new.grad_env_tauE_Vec_R = gradient( results_new.env_tauE_Vec_R );
    
end

if ( data.LRCflag == 'L' || data.LRCflag == 'C' )
    leftHalf_phi_lrMat = results.phi_lrMat( : , 1 : floor ( 1 + size( results.phi_lrMat, 2 ) / 2 ) );
    reverseIdx = ( size( leftHalf_phi_lrMat, 2 ) : -1 : 1 );
    leftHalf_phi_lrMat = leftHalf_phi_lrMat( : , reverseIdx );
    clipped_leftHalf_phi_lrMat = abs( leftHalf_phi_lrMat - data.clipVal );

    m = size( clipped_leftHalf_phi_lrMat, 1 );
    n = size( clipped_leftHalf_phi_lrMat, 2 );
    
    [ results_new.maxValVec_L, results_new.tauE_Vec_L_Idx ] = pickUp_peaks_( clipped_leftHalf_phi_lrMat, eps );
    
    results_new.tauE_Vec_L = ( results_new.tauE_Vec_L_Idx - 1 ) / n * data.timeT;
        
    if ( LPFflag == 1 )
        results_new.env_tauE_Vec_L = filter( df, [ results_new.tauE_Vec_L'; zeros(D,1) ] );
        results_new.env_tauE_Vec_L = results_new.env_tauE_Vec_L( D+1 : end );
    else
        [ results_new.env_tauE_Vec_L, results_new.env_tauE_Idx_L ] = getEnvelope_( results_new.tauE_Vec_L, minPeakDist );
    end
    
    results_new.grad_env_tauE_Vec_L = gradient( results_new.env_tauE_Vec_L );
    
end


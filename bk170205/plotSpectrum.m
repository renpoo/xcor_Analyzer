NFFT = length( S );
S_FFT = fft( S, NFFT );
F = (( 0 : 1/NFFT : 1-1/NFFT ) * fs ).';
magnitudeS_FFT = abs( S_FFT );        % Magnitude of the FFT
phaseS_FFT = unwrap( angle( S_FFT ) );  % Phase of the FFT

helperFrequencyAnalysisPlot1( F, magnitudeS_FFT, phaseS_FFT, NFFT )
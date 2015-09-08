function b = getOctavebandFilter_( fM, fLen, fs )

Wn = [ fM/sqrt(2) fM*sqrt(2) ] / ( fs/2 );
b = fir1(fLen, Wn, 'bandpass');

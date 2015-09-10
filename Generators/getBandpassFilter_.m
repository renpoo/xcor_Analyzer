function b = getBandpassFilter_( fMin, fMax, fs, fLen )

Wn = [ fMin/(fs/2) fMax/(fs/2) ];
b = fir1(fLen, Wn, 'bandpass');

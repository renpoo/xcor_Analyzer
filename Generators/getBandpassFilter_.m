function b = getBandpassFilter_( fMin, fMax, fLen )

Wn = [ fMin fMax ];
b = fir1(fLen, Wn, 'bandpass');

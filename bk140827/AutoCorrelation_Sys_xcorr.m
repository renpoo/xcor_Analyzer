function rxx = AutoCorrelation_Sys_xcorr( x, maxlag, scale )
[R, lag] = xcorr ( x, maxlag, scale );
rxx = R;

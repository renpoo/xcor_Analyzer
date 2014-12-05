function rxy = CrossCorrelation_Sys_xcorr( x, y, maxlag, scale )
[R, lag] = xcorr ( x, y, maxlag, scale );
rxy = R;

function Rxx = nACF_( x )
% ACF = Auto Correlation Function
% x  : input vector of signal can be e.g. L channel;
% y  : input vector of signal can be e.g. R channel;

Rxx = nCCF_( x, x );

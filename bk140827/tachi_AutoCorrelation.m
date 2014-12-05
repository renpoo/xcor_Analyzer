function [rxx,m] = tachi_AutoCorrelation(x, maxlag, scale)
% Usage: [rxx,m] = tachi_AutoCorrelation(x, maxlag, scale)
%	rxx		autocorrelation fucntion
%	m		time lag
%	x		input waveform (N x 1)
%	maxlag	maximum time lag (default: N-1 )
%	scale	scaling flag (default: 0)
%		0: none
%		1: biased		... rxx_scaled = rxx/N
%		2: unbiased		... rxx_scaled = rxx./(N-abs(m))
%		3: coeff		... rxx_scaled = rxx/(x'*x)
%
% R.O. Tachibana
% July 16, 2014

N = length(x);
										  
% default setting
if nargin<3,
	scale = 0;
end
if nargin<2,
	maxlag = N-1;
end

% ac calculation
rxx = zeros(maxlag+1,1);
for m = 0:maxlag,
	rxx(m+1) = x((m+1):N)' * x(1:(N-m));
end


% lag for output
m = (0:maxlag)';

% scaling
if (scale == 1),     % biased scaling
	rxx = rxx / N;
elseif (scale == 2), % unbiased scaling
	rxx = rxx ./ (N-abs(m));
elseif (scale == 3), % coeff scaling
	rxx = rxx / (x'*x);
end

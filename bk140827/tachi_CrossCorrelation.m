function [rxy,m] = tachi_CrossCorrelation(x, maxlag, scale)
% Usage: [rxy,m] = tachi_CrossCorrelation(x, maxlag, scale)
%	rxy		crosscorrelation fucntion
%	m		time lag
%	x		input waveform (N x 1)
%	maxlag	maximum time lag (default: N-1 )
%	scale	scaling flag (default: 0)
%		0: none
%		1: biased		... rxy_scaled = rxy/N
%		2: unbiased		... rxy_scaled = rxy./(N-abs(m))
%		3: coeff		... rxy_scaled = rxy/(x'*x)./norm(x(m+1:N))
%
% R.O. Tachibana
% July 16, 2014

# MODIFIED: TAISO, Renpoo: 140717


N = length(x);

                        
% default setting
if nargin<3,
	scale = 0;
end
if nargin<2,
	maxlag = N-1;
end

% cc calculation
den1 = norm(x);
den2 = zeros(maxlag+1,1);
rxy = zeros(maxlag+1,1);
for m = 0:maxlag,
	rxy(m+1) = x((m+1):N)' * x(1:(N-m));
  #x_sub = zeros((maxlag+1)*2,1);
  x_sub = x(m+1:N);
  #den(m) = x_sub' * x_sub;
  #den(m) = sqrt(norm(x_sub)^2);
  den2(m+1) = norm(x_sub);
end


% lag for output
m = (0:maxlag)';

% scaling
if (scale == 1),     % biased scaling
	rxy = rxy/N;
elseif (scale == 2), % unbiased scaling
	rxy = rxy./(N-abs(m));
elseif (scale == 3), % coeff scaling
	rxy = (rxy/den1)./den2;
end

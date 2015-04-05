function y = add2(a,b,c)
%simple function test program
% ADD(A,B,C), where A & B & C are scalar.
% programmed by Gerox(c) 1997
if(nargin == 2)
  c = 0;
else if(nargin ~= 3) error('This function only support two or three input argument.');end
end
if(nargout > 1)
  error('This function only support one output argument.');
end
[ma na] = size(a);[mb nb] = size(b);[mc nc] = size(c);
if((ma ~= 1) & (mb~=1) & (na ~= 1) & (nb ~= 1)& (nc ~= 1) & (nc ~= 1))
  error(' input must be a scalar');
end
y = a + b + c;

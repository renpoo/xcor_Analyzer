function y = add3(varargin)
%simple function test program
% ADD(A,B,C), where A & B & C are scalar.
% programmed by Gerox(c) 1997
y=0;
for i = 1:length(varargin)
  x(i) = varargin{i};
  y = y + x(i);
end

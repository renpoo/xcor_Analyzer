function [sub0,add0]=sub_add(a,b)
%simple function test program
% SUB_ADD(A,B), where A & B are scalar.
% programmed by Gerox(c) 1997
sub0 = sub(a,b);
add0 = add(a,b);
function y = add(a,b)
y=a+b;
function y = sub(a,b)
y = a - b;

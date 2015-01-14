close all; 
clear;

L = 2^15;
%L = 2^8;
A = 2^12;
%A = 2^0;
fs = 44100;

R = zeros(1,1);

%for k = 2^9:2^10,
for k = 2^0:2^10,
  z = G( L, k, A );
  S = ifft( z, L/2 );

  %plot(imag(S));
  
  T = 1;
  %R = S;

  for j = 1:T,
    R = horzcat( R, S );
  end;
  
  %sound( real(R), fs );
end;

step = 1;
subR = R(1:step:length(R));
sound( real(subR), fs );
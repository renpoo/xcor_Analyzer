close all; 
clear;

L = 2^15;
A = 2^12;
fs = 44100;

R = zeros(1,1);
zArray = zeros( 1, L );


for k = 2^0:2^4,
  z = G( L, k, A );
  S = ifft( z, L/2 );

  zArray( k, : ) = z;
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

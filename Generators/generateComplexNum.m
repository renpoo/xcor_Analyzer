function z = G(L, k, A)

%L = 256;
%k = 64;
%A = 0.1;

z = complex(0,0);
z(k) = A + 0i;
z(L-k) = A + 0i;
z(L) = 0+0i;

return;



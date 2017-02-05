clear;
ite = 10000;

x = [1,2,3,4,5,6,7,8,9,10];
y = [10,9,8,7,6,5,4,3,2,1];
y = x; % OVERRIDE

tic;
for i = 1:ite
    R1 = PHI_xy_( x, y );
end;
toc;


tic;
for i = 1:ite
    R2 = PHI_xy_inline_( x, y );
end;
toc;


tic;
for i = 1:ite
    R3 = PHI_xy_parallel_( x, y );
end;
toc;


tic;
for i = 1:ite
    R4 = xcorr( x, y, 'coeff' );
end;
toc;



figure;plot(R1)
figure;plot(R2)
figure;plot(R3)
figure;plot(R4)



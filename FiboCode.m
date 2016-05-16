clear;
close all;

A = 0.3;
duration = 3.0;
%duration = 2^19/fs;
%fs = 44100;
fs = 96000;
%interval = duration;
interval = 0.5;



% Change "n" for number of iteration on fibonatch series
n = 10;



a = 2;
b = 1;
for ( i = 2 : n ),
    tmp = a;
    a = b;
    b = tmp + b;
end;

R_a = a / (a+b);
R_b = b / (a+b);


%a = 0.618;
%b = 1.0;


%L = 0.0022725;
L = 0.00384; % = 1 / 261.6255653005986
%L = 0.00286; % = 1 / 349.2282314330039
L = L * 1;


fMin = 1 / L;
fMid = 1 / L / ( b / (a+b) );
fMax = 1 / L / ( a / (a+b) );


s1 = makeSineWave_( A, fMin, 0, fs, duration, interval );
s2 = makeSineWave_( A, fMid, 0, fs, duration, interval );
s3 = makeSineWave_( A, fMax, 0, fs, duration, interval );


S = s1 + s2 + s3;
%S = S / max(S);


sound( s1, fs );
pause( duration + interval );

sound( s2, fs );
pause( duration + interval );

sound( s3, fs );
pause( duration + interval );

sound( S, fs );


disp(fMin/fMin);
disp(fMid/fMin);
disp(fMax/fMin);


% C3 Ab3 F4
clear;
close all;

A = 1;
%fs = 44100;
fs = 96000;
%duration = 2^19/fs;
%duration = 1.0;
duration = 2.0;
%interval = duration;
interval = 0.0;


%f1 = 480;
%f1 = 960;
f1 = [ 320, 300 ];
%f2 = [ 480, 482, 484, 486, 488, 490, 495, 510, 525, 540, 558, 576, 588, 600, 620, 640, 660, 680, 700, 720, 744, 768, 784, 800, 832, 864, 882, 900, 930, 960 ];
%f2 = [ 241, 256, 270, 288, 300, 320, 337.5, 360, 384, 400, 432, 450, 480 ];
f2 = [ 455, 480 ];


Z = zeros( 1, 1 );

S = Z;



for i = 1 : length(f2),
    disp( strcat( 'index# =  ', num2str(i), '  :  ', num2str( f1(i) ), 'Hz ', '  +  ', num2str( f2(i) ), 'Hz' ) );
    s = Z;
    
    s1 = generateSinWave_( A, f1(i) * 4,    fs, duration, 0 );
    s2 = generateSinWave_( A, f2(i) * 4, fs, duration, 0 );
    
    s = (s1 + s2);
    S = vertcat( S, s );
end;

sound( S, fs );
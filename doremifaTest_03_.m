clear;
close all;

A = 1;
%fs = 44100;
fs = 96000;
duration = 2^19/fs;
duration = duration * 2.0;
%duration = 1.0;
%duration = 2.0;
%interval = duration;
interval = 0.0;


%f1 = 480;
%f1 = 960;
%f1 = [ 320, 300 ];
%f1 = [ 512, 576, 640, 682.6, 768, 864, 960, 1023 ];
%f1 = [ 1024 + 128, 2048 + 128, 4096 + 128, 8192 + 128 ];
f1 = [ 8192 + 128 ];

%f2 = [ 480, 482, 484, 486, 488, 490, 495, 510, 525, 540, 558, 576, 588, 600, 620, 640, 660, 680, 700, 720, 744, 768, 784, 800, 832, 864, 882, 900, 930, 960 ];
%f2 = [ 241, 256, 270, 288, 300, 320, 337.5, 360, 384, 400, 432, 450, 480 ];
%f2 = [ 455, 480 ];
%f2 = [ 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024 ];
%f2 = [ 1024, 1024, 1024, 1024 ];
f2 = [ 1024 ];


Z = zeros( 1, 1 );

S = Z;



for i = length(f2): -1 : 1,
    disp( strcat( 'index# =  ', num2str(i), '  :  ', num2str( f1(i) ), 'Hz ', '  +  ', num2str( f2(i) ), 'Hz' ) );
    s = Z;
    
    s1 = generateSinWave_( A, f1(i), fs, duration, 0 );
    s2 = generateSinWave_( A, f2(i), fs, duration, 0 );
    
    s = (s1 + s2);
    S = vertcat( S, s );
    
    audiowrite( strcat( './_Sounds/ADD_', num2str(f1(i)), 'Hz_', num2str(f2(i)), 'Hz.wav'), s, fs);

    sound( s, fs );
    pause( duration * 2 );
end;

%sound( S, fs );
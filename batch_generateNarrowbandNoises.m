clear;
close all;

fs = 96000;
d = 3.0;
p = 2^4;
interval = 1.0;

%{
S = generateNarrowbandNoise_(  1020, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1020Hz_1024Hz.wav', S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1000, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1000Hz_1024Hz.wav', S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   960, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_960Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   896, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_896Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   832, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_832Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   768, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_768Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   704, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_704Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   640, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_640Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   576, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_576Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(   512, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_512Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(     1, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
%}


%S = generateNarrowbandNoise_( 682.6, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_682.6Hz_1024Hz.wav',  S, fs);  sound( S, fs ); pause( d + interval );
%S = generateNarrowbandNoise_(   864, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_864Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );

%S = generateNarrowbandNoise_(  1000, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1000Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
%{
S = generateNarrowbandNoise_(  1023, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1023Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1022, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1022Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1021, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1021Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1020, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1020Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1019, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1019Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1018, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1018Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1017, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1017Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1016, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1016Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1015, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1015Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1014, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1014Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1013, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1013Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1012, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1012Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1011, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1011Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
S = generateNarrowbandNoise_(  1010, 1024, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1010Hz_1024Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
%}

%S = generateNarrowbandNoise_(  330, 880, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_330Hz_880Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
%S = generateNarrowbandNoise_(  220, 880, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_220Hz_880Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
%S = generateNarrowbandNoise_(  110, 880, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_110Hz_880Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );

%S = generateNarrowbandNoise_(  55, 880, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_55Hz_880Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
%S = generateNarrowbandNoise_(  27.5, 880, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_27_5Hz_880Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
%S = generateNarrowbandNoise_(  13.75, 880, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_13_75Hz_880Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
%S = generateNarrowbandNoise_(  6.875, 880, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_6_875Hz_880Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );
%S = generateNarrowbandNoise_(  1, 880, fs, d, p ); audiowrite( './_Sounds/narrowbandNoize_1Hz_880Hz.wav',    S, fs);  sound( S, fs ); pause( d + interval );


%{
for (i = 1024:-1:1000),
    disp( i );
    S = generateNarrowbandNoise_(  i, 1024, fs, d, p ); audiowrite( strcat('./_Sounds/narrowbandNoize_',i,'Hz_1024Hz.wav'),    S, fs);  sound( S, fs ); pause( d + interval );
end;
%}



a = [440 550 660 880];
%a = [330 550 660 880];
step = 110;
%for (i = 1:3),
for (i = 1:4),
    disp( i );
    S = generateNarrowbandNoise_( a(i)-step, a(i), fs, d, p ); audiowrite( strcat('./_Sounds/narrowbandNoize_',a(i)-step,'Hz_',a(i),'Hz.wav'),    S, fs);  sound( S, fs ); pause( d + interval );
    B(i,:) = S;
end;
%sound(B(1,:)+B(2,:)+B(3,:)+B(4,:),fs);
%audiowrite( strcat('tmp1.wav'), B(1,:)+B(2,:)+B(3,:)+B(4,:), fs);
%{
i = 4;
step = 220;
S = generateNarrowbandNoise_(  a(i)-step, a(i), fs, d, p ); audiowrite( strcat('./_Sounds/narrowbandNoize_',a(i)-step,'Hz_',a(i),'Hz.wav'),    S, fs);  sound( S, fs ); pause( d + interval );
B(i,:) = S;
sound(B(1,:)+B(2,:)+B(3,:)+B(4,:),fs);
%}


%{
a = [220 330 550 660 880];
%step = 110;
for (i = 2:5),
    disp( i );
    S = generateNarrowbandNoise_(  a(i-1), a(i), fs, d, p ); audiowrite( strcat('./_Sounds/narrowbandNoize_',a(i-1),'Hz_',a(i),'Hz.wav'),    S, fs);  sound( S, fs ); pause( d + interval );
    B(i,:) = S;
end;
sound(B(5,:)+B(2,:)+B(3,:)+B(4,:),fs);
audiowrite( strcat('tmp2.wav'), B(5,:)+B(2,:)+B(3,:)+B(4,:), fs );
%}
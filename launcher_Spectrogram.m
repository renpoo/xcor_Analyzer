clear;
fs=8000;
window_size=256;
shift_size=64;

%[s, fs] = audioread('AOKI Sample Codes/sounds/guitar.wav');
%[s, fs] = audioread('_Sounds/ADD_Sinewaves_480Hz_and_fr_480Hz_to_960Hz.wav');
%[s, fs] = audioread('_Sounds/ADD_Sinewaves_960Hz_and_fr_480Hz_to_960Hz.wav');


% --- Audio File open and read
[ fname, pname ] = uigetfile( '*.wav', 'SELECT WAV FILE' );
audFileName = strcat( pname, '/', fname );
%samples = [ 1, inf ];
%[ s0, fs ] = audioread( audFileName, samples );
[ s, fs ] = audioread( audFileName );


[S,time,frequency]=Spectrogram_(s,fs,window_size,shift_size);
%imagesc(time,frequency,S);
surf(time,frequency,S,'FaceColor','interp','FaceLighting','phong', 'LineWidth', 0.01, 'EdgeAlpha', 0.01);
colormap 'jet';
axis xy;

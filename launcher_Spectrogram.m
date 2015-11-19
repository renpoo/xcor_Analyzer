clear;

fs=8000;
window_size=256;
shift_size=64;

[ fname, pname ] = uigetfile( '*.wav', 'SELECT WAV FILE' );
audFileName = strcat( pname, '/', fname );

[S,time,frequency]=Spectrogram_(s,fs,window_size,shift_size);

figure();
surf(time,frequency,S,'FaceColor','interp','FaceLighting','phong', 'LineWidth', 0.01, 'EdgeAlpha', 0.01);
colormap 'jet';
axis xy;

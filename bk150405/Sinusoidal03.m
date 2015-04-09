%pkg load io;
%pkg load signal;

close all; 
clear;


% --- WAV???????
[ fname, pname ] = uigetfile( '*.wav', 'SELECT WAV FILE' );
audFileName = strcat( pname, '/', fname );

% --- WAV?????
[s0,Fs] = audioread(audFileName);

% --- WAV????????samples???????????????inf?????
%samples = [1,1*Fs];
%[s0,Fs] = audioread(audFileName,samples);

% --- ????
t0 = (1:length(s0))/Fs; % Time vector
s0R = s0(1:length(s0),1); % R channel
%s0L = s0(1:length(s0),2); % L channel
s = s0R; % s?1???????

%sound( s0, Fs ); Original audio


% --- Matlab??Low-Pass Filter??
if( 0 ),
    %cutf = 2000; % Cut-off frequency
    cutf = 1000; % Cut-off frequency
    cutfnorm = cutf/(Fs/2); % Normalized frequency
    df = designfilt('lowpassfir','FilterOrder',1000,'CutoffFrequency',cutfnorm);
    % --- Filter????????
    %grpdelay(df,2048,Fs); % Group delay??????????????????
    D = mean(grpdelay(df)); % Average delay
    % --- Filter + ??????
    slength = length(s);
    %s = filter(df, s); % ???????Filter??
    s = filter(df, [s;zeros(D,1)]); % s????D??????
    s = s(D+1:slength+D); % s?D??????
    %sound(s, Fs);
    plot(t0, s0R, t0, s);
    %axis([0.3,0.35,-0.2,0.2]);
end;

if( 0 ),
    % x :  signal
    % fs : sampling rate
    B = fir1(1024, 100/(Fs/2)); % cutoff=100Hz?????????
    
    % AM ????
    env1 = filtfilt(B,1, s .* (s>0) );
    
    % ????????????????????????fast?slow????????
    env2 = sqrt( filtfilt( B,1, s.^2 ) );
    
    plot(t0, s0R, t0, env2 );
    
    s = env2;
end;


if ( 1 ),
    length_of_s0 = length( s0 );
    duration = length_of_s0 / Fs;  %duration (of input signal)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Section: Smoothing (simply making the average value for a frame)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    window_size = 256;
    avgLen = 16; % This param defines smoothing length (for avg value) in the window for frame k
    avg = 0.0;
    number_of_frame = floor( ( length_of_s0 - ( window_size - avgLen ) ) / avgLen ) - 1;
    
    for frame = 1 : number_of_frame,
        offset = avgLen * ( frame - 1 );
        for i = 1 : avgLen : window_size,
            subS0 = s0( offset+i : offset+avgLen+i-1 );
            avg = mean( subS0 );
            s( offset+i : offset+avgLen+i-1 ) = avg;
            avg = 0.0;
        end;
    end;
end;



% --- Matlab??FFT??
dftsize = 1024; % fft???????????
nframe = floor(length(s0)/dftsize); % fft???????????
clear sCplx; % fft?????????
clear sFreq; % fft?????????
clear sMagn; % fft????????????
clear sPhas; % fft????????

for k=1:nframe,  % ?Frame??dftsize??????????FFT
    tmpshift=dftsize*(k-1);
    fftS=fft(s(tmpshift+1:tmpshift+dftsize),dftsize);
    if (k==1), % ????????
        sCplx=fftS;
        sMagn=abs(fftS);
        sPhas=unwrap(angle(fftS));
    else  % ???????????????
        sCplx = horzcat(sCplx, fftS);
        sMagn = horzcat(sMagn, abs(fftS));
        sPhas = horzcat(sPhas, unwrap(angle(fftS)));
    end;
    for tempk=1:dftsize,  % ??????
        sFreq(tempk,k) = (Fs/dftsize)*(tempk-1);
    end;
end;



% --- ??????????????3D Graph plot
for tempk=1:nframe,  % ???
    t3D(tempk) = (dftsize/Fs)*(tempk-1);
end;
for templ=1:dftsize/2,  % ????????????
    f3D(templ) = (Fs/dftsize)*(templ-1);
end;
for tempk=1:nframe,  % ????dB?????????????
    for templ=1:dftsize/2,
        m3D(templ,tempk) = sMagn(templ,tempk);
        db3D(templ,tempk) = 20*log10(sMagn(templ,tempk));
    end;
end;

if ( 0 ),
    surf(t3D,f3D,db3D,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
    mesh(t3D,f3D,db3D);
    xlabel('Time [sec]');
    ylabel('Frequency [Hz]');
    zlabel('Magnitude [dB]');
end;


% --- Magnitude???Sort?Select
sortTop = 8; % Select??Magnitude????
clear sScplx; % Select?????????
clear sSfreq; % Select?????????
clear sSmagn; % Select????????????
clear sSphas; % Select????????

for tempk=1:nframe,  % Frame????????????Sort???
%    [ sSmagntemp, sortIdx ] = sortrows( sMagn, -1*tempk );
    [ sSmagntemp, sortIdx ] = sortrows( m3D, -1*tempk );
    for templ=1:sortTop,  % sortTop???Select????????
        sSmagn(templ,tempk) = sSmagntemp(templ,tempk);
        sScplx(templ,tempk) = sCplx(sortIdx(templ),tempk);
        sSfreq(templ,tempk) = sFreq(sortIdx(templ),tempk);
        sSphas(templ,tempk) = sPhas(sortIdx(templ),tempk);
    end;
end;



% --- 3D Graph plot
for tempk=1:nframe,  % ???
    t3D2(tempk) = (dftsize/Fs)*(tempk-1);
    for templ=1:sortTop,  % ????
        f3D2(templ,tempk) = sSfreq(templ,tempk);
        m3D2(templ,tempk) = sSmagn(templ,tempk);
        db3D2(templ,tempk) = 20*log10(sSmagn(templ,tempk));
    end;
end;


if ( 1 ),
    %surf(t3D2,f3D2,db3D2,'FaceColor','interp','EdgeColor','black','FaceLighting','phong')
    %surf(t3D2,f3D2,db3D2);
    %mesh(t3D2,f3D2,db3D2);
    
    hold on;
    
    if ( 0 ),
        plot3(t3D2, f3D2(1,:)', db3D2(1,:),'r');
        if ( 0 ),
            plot3(t3D2, f3D2(2,:)', db3D2(2,:),'g');
            plot3(t3D2, f3D2(3,:)', db3D2(3,:),'b');
            plot3(t3D2, f3D2(4,:)', db3D2(4,:),'c');
            plot3(t3D2, f3D2(5,:)', db3D2(5,:),'m');
            plot3(t3D2, f3D2(6,:)', db3D2(6,:),'y');
            plot3(t3D2, f3D2(7,:)', db3D2(7,:),'k');
            plot3(t3D2, f3D2(8,:)', db3D2(8,:),'w');
        end;
    end;
    
    if ( 1 ),
        scatter3(t3D2, f3D2(1,:)', db3D2(1,:),50,'+');
        if ( 1 ),
            scatter3(t3D2, f3D2(2,:)', db3D2(2,:),50,'+');
            scatter3(t3D2, f3D2(3,:)', db3D2(3,:),50,'+');
            scatter3(t3D2, f3D2(4,:)', db3D2(4,:),50,'+');
            scatter3(t3D2, f3D2(5,:)', db3D2(5,:),50,'+');
            scatter3(t3D2, f3D2(6,:)', db3D2(6,:),50,'+');
            scatter3(t3D2, f3D2(7,:)', db3D2(7,:),50,'+');
            scatter3(t3D2, f3D2(8,:)', db3D2(8,:),50,'+');
        end;
    end;
    
    hold off;
    grid on;
    xlabel('Time [sec]');
    ylabel('Frequency [Hz]');
    zlabel('Magnitude [dB]');
end;

% --- 2D Graph plot
for tempk=1:nframe,  % 
    for templ=1:sortTop,  % 1???????2??????
        f2D(1,(tempk-1)*sortTop+templ) = sSfreq(templ,tempk);
        f2D(2,(tempk-1)*sortTop+templ) = t3D2(tempk);
    end;
end;

if ( 0 ),
    scatter(f2D(2,:),f2D(1,:),50,'+');
    xlabel('Time [sec]');
    label('Frequency [Hz]');
    axis([1.0,1.5,0,4000])
end;

clear sSstno; % Select?????????
clear sSstor; % Select????????????

clear sSpowr; % Select?????????










return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;
return;






 

%pkg load io; 
%pkg load signal; 


close all; 
clear; 

[ s0, fs, bits ] = wavread('Sounds/Akan00.wav'); 
%[ s0, fs, bits ] = wavread('Sounds/140823TiturelAmfortas.WAV'); 

 
sound( s0, fs ); 
pause; 

length_of_s0 = length( s0 ); 
duration = length_of_s0 / fs;  %duration (of input signal) 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Section: Smoothing (simply making the average value for a frame) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
window_size = 256; 
avgLen = 16; % This param defines smoothing length (for avg value) in the window for frame k 
avg = 0.0; 
number_of_frame = floor( ( length_of_s0 - ( window_size - avgLen ) ) / avgLen ) - 1; 

for frame = 1 : number_of_frame, 
    offset = avgLen * ( frame - 1 ); 
    for i = 1 : avgLen : window_size, 
        subS0 = s0( offset+i : offset+avgLen+i-1 ); 
        avg = mean( subS0 ); 
        x( offset+i : offset+avgLen+i-1 ) = avg; 
        avg = 0.0; 
    end; 
end; 

 
sound( x, fs ); 
pause; 

 
%return; 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Section: FFT to calcurate picking-up peaks 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

 
shift_size = 16; % this param defines smoothing length (for avg value) in the window for frame k 
dft_size = 256; % FFT size (Discrete) 

TopRanks = 1; % Number to picking-up peaks from the Spectrum of the certain window (MIRRORED) 

shift_size = 256; % Shifting Size for a window for FFT 
number_of_frame = floor( ( length_of_s0 - ( window_size - shift_size ) ) / shift_size ) - 1; 

% Initilize vectors for resulting data 
resultS = zeros( 1, dft_size ); 
resultXpickedUp = zeros( 1, dft_size ); 

for frame = 1 : number_of_frame, 
    offset = shift_size * ( frame - 1 ); 
    X = fft( x( offset+1 : offset+window_size ), dft_size ); 
    
    if ( 0 ), 
        %for k = 1 : dft_size/2+1, 
        %    A( k ) = -20 * log10( abs( X( k ) ) ); 
        %end; 
 
        A = -20 * log10( abs( X ) ); 
    else 
        A = abs( X ); 
    end; 
     
    
   [ sortedA, sortedIdx ] = sort( A, 'descend' ); % "sortedIdx" is index array for sorted A 
    %[ sortedA, sortedIdx ] = sort( A, 'ascend' ); % "sortedIdx" is index array for sorted A 
     
    ApickedUp = zeros( 1, dft_size/2+1 ); % Picked-Up Amplitudes (RESULTS) 
    XpickedUp = zeros( 1, dft_size );     % Picked-Up Frequencies (RESULTS) 
     
    for k = 1 : dft_size/2+1, 
        for j = 1 : TopRanks, 
            if ( k == sortedIdx( j ) ), 
                disp( strcat( '###', num2str( k ) ) ); 
                 
                ApickedUp( k ) = A( k ); 
                 
                XpickedUp( k ) = X( k ); 
                XpickedUp( dft_size - k ) = X( k ); 
            end; 
        end; 
    end; 
   
    
    if( 0 ), 
        clf (); 
       figure(1); 
        %plot( real( XpickedUp ) ); 
       plot( real( ApickedUp ) ); 
       %plot( real( A ) ); 
       %plot( real( X ) ); 
       %plot( real( sortedA ) ); 
       pname = strcat( 'Output Images', '/', 'Sinusoid_Test_01' ); 
       mkdir( pname ); 
       saveImageName = strcat( 'pickedUpFreqs-', num2str( frame ) ); 
       fname = strcat( saveImageName, '.jpg'); 
        outputDataFileName = strcat( pname, '/', fname ); 
        saveas( 1, strcat( outputDataFileName ) ); 
    end; 
    
    resultXpickedUp = horzcat( resultXpickedUp, XpickedUp ); 
    resultS = horzcat( resultS, real( ifft( XpickedUp, dft_size ) ) ); 
      
end; 
 
if ( 0 ), 
   magicScale = 10000; 
   for k = 1 : length( resultS ), 
       resultS( k ) = ( 1 / 10^( resultS( k ) / 20 ) - 1 ) * magicScale; 
    end; 
end; 
 
sound( resultS, fs ); 
pause; 

return; 

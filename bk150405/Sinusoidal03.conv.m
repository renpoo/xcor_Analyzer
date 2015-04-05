%pkg load io;
%pkg load signal;

close all; 
clear;


% --- WAVファイルの選択
[ fname, pname ] = uigetfile( '*.wav', 'SELECT WAV FILE' );
audFileName = strcat( pname, '/', fname );

% --- WAVの読み込み
[s0,Fs] = audioread(audFileName);

% --- WAVの部分読み込み：samplesに開始、終了秒数を入力（終了にinfで全時間）
%samples = [1,1*Fs];
%[s0,Fs] = audioread(audFileName,samples);

% --- 初期設定
t0 = (1:length(s0))/Fs; % Time vector
s0R = s0(1:length(s0),1); % R channel
%s0L = s0(1:length(s0),2); % L channel
s = s0R; % sを1チャネルで扱う

%sound( s0, Fs ); Original audio


% --- Matlab組込Low-Pass Filter処理
if(1),
    cutf = 2000; % Cut-off frequency
    cutfnorm = cutf/(Fs/2); % Normalized frequency
    df = designfilt('lowpassfir','FilterOrder',100,'CutoffFrequency',cutfnorm);
    % --- Filterによる遅延の確認
    %grpdelay(df,2048,Fs); % Group delayが一様なら単純な時間シフトにより補正
    D = mean(grpdelay(df)); % Average delay
    % --- Filter + 遅延補正処理
    slength = length(s);
    %s = filter(df, s); % 遅延処理しないFilter処理
    s = filter(df, [s;zeros(D,1)]); % sの終端にD個ゼロフィル
    s = s(D+1:slength+D); % sをD分だけシフト
    %sound(s, Fs);
    %plot(t0, s0R, t0, s);
    %axis([0.3,0.35,-0.2,0.2]);
end;



% --- Matlab組込FFT処理
dftsize = 1024; % fft後の格納配列の行に相当
nframe = floor(length(s0)/dftsize); % fft後の格納配列の列に相当
clear sCplx; % fft後の複素数格納配列
clear sFreq; % fft後の周波数格納配列
clear sMagn; % fft後の強度（振幅）格納配列
clear sPhas; % fft後の位相格納配列

for k=1:nframe,  % 各Frame毎にdftsize分の列ベクトル単位でFFT
    tmpshift=dftsize*(k-1);
    fftS=fft(s(tmpshift+1:tmpshift+dftsize),dftsize);
    if (k==1), % 初回のみ単純代入
        sCplx=fftS;
        sMagn=abs(fftS);
        sPhas=unwrap(angle(fftS));
    else  % 次回以降は列ベクトルを水平加算
        sCplx = horzcat(sCplx, fftS);
        sMagn = horzcat(sMagn, abs(fftS));
        sPhas = horzcat(sPhas, unwrap(angle(fftS)));
    end;
    for tempk=1:dftsize,  % 周波数は固定
        sFreq(tempk,k) = (Fs/dftsize)*(tempk-1);
    end;
end;



% --- 周波数領域の対照部分の排除と3D Graph plot
for tempk=1:nframe,  % 時間軸
    t3D(tempk) = (dftsize/Fs)*(tempk-1);
end;
for templ=1:dftsize/2,  % 周波数軸（対象性を勘案）
    f3D(templ) = (Fs/dftsize)*(templ-1);
end;
for tempk=1:nframe,  % 強度（＋dB変換）行列（対象性を勘案）
    for templ=1:dftsize/2,
        m3D(templ,tempk) = sMagn(templ,tempk);
        db3D(templ,tempk) = 20*log10(sMagn(templ,tempk));
    end;
end;

%surf(t3D,f3D,db3D,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
%mesh(t3D,f3D,db3D);
%xlabel('Time [sec]');
%ylabel('Frequency [Hz]');
%zlabel('Magnitude [dB]');



% --- MagnitudeによるSortとSelect
sortTop = 8; % SelectするMagnitudeの上位数
clear sScplx; % Select後の複素数格納配列
clear sSfreq; % Select後の周波数格納配列
clear sSmagn; % Select後の強度（振幅）格納配列
clear sSphas; % Select後の位相格納配列

for tempk=1:nframe,  % Frame分だけ各列に対して降順のSortを実施
%    [ sSmagntemp, sortIdx ] = sortrows( sMagn, -1*tempk );
    [ sSmagntemp, sortIdx ] = sortrows( m3D, -1*tempk );
    for templ=1:sortTop,  % sortTop分だけSelectして新配列に格納
        sSmagn(templ,tempk) = sSmagntemp(templ,tempk);
        sScplx(templ,tempk) = sCplx(sortIdx(templ),tempk);
        sSfreq(templ,tempk) = sFreq(sortIdx(templ),tempk);
        sSphas(templ,tempk) = sPhas(sortIdx(templ),tempk);
    end;
end;



% --- 3D Graph plot
for tempk=1:nframe,  % 時間軸
    t3D2(tempk) = (dftsize/Fs)*(tempk-1);
    for templ=1:sortTop,  % 周波数軸
        f3D2(templ,tempk) = sSfreq(templ,tempk);
        m3D2(templ,tempk) = sSmagn(templ,tempk);
        db3D2(templ,tempk) = 20*log10(sSmagn(templ,tempk));
    end;
end;

%surf(t3D2,f3D2,db3D2,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
%surf(t3D2,f3D2,db3D2);
%mesh(t3D2,f3D2,db3D2);
%xlabel('Time [sec]');
%ylabel('Frequency [Hz]');
%zlabel('Magnitude [dB]');

% --- 2D Graph plot
for tempk=1:nframe,  % 
    for templ=1:sortTop,  % 1行目は周波数、2行目は時間数
        f2D(1,(tempk-1)*sortTop+templ) = sSfreq(templ,tempk);
        f2D(2,(tempk-1)*sortTop+templ) = t3D2(tempk);
    end;
end;

%scatter(f2D(2,:),f2D(1,:),50,'+');
%xlabel('Time [sec]');
%label('Frequency [Hz]');
%axis([1.0,1.5,0,4000])


clear sSstno; % Select後の紐番号格納配列
clear sSstor; % Select後の紐内順序番号格納配列

clear sSpowr; % Select後のパワー格納配列










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


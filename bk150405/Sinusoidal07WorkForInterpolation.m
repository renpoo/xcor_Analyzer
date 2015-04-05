close all; 
clear;


% --- 各種パラメタの設定
switchLPFilter = 1;        % Low-pass Filter on = 1 / off = 0
CutOffFrequency = 6000;    % Cut-off Frequency for LP Filter
SizeOfDFT =  512;          % DFT (Window) size
NumberOfSelectedWave = 12; % Number of picked-up waves from top Magnitudes
switchInterpolation = 1;   % Third-order Interpolation on = 1 / off = 0
switchSound = 1;           % Sound treated sound on = 1 / off = 0
switchWavfile = 1;         % Write treated wavfile on = 1 / off = 0
switchPlot = 1;            % Plot treated waves on = 1 / off = 0
startSec = 0.145;          % Start time (sec) for wave plot
endSec = 0.155;            % End time (sec) for wave plot
maximumMagnitude =  0.15;  % Maximum Magnitude for wave plot
minimumMagnitude = -0.15;  % Minimum Magnitude for wave plot


% --- WAVファイルの選択
[ fname, pname ] = uigetfile( '*.wav', 'SELECT WAV FILE' );
audFileName = strcat( pname, '/', fname );
% --- WAVの読み込み
[s0,Fs] = audioread(audFileName);
% --- 初期設定
t0 = (1:length(s0))/Fs; % Time vector
s0R = s0(1:length(s0),1); % R channel
%s0L = s0(1:length(s0),2); % L channel
s = s0R; % sを1チャネルで扱う
%sound( s0, Fs ); %Original audio

% --- Matlab組込Low-Pass Filter処理
if(switchLPFilter),
    cutf = CutOffFrequency; % Cut-off frequency
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
dftsize = SizeOfDFT; % fft後の格納配列の行に相当
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
        sFreq(tempk,k) = (Fs/dftsize)*(tempk);
    end;
end;

% --- 周波数領域の対照部分の排除と3D Graph plot
for tempk=1:nframe,  % 時間軸
    t3D(tempk) = (dftsize/Fs)*(tempk);
end;
for templ=1:dftsize/2,  % 周波数軸（対象性を勘案）
    f3D(templ) = (Fs/dftsize)*(templ);
end;
for tempk=1:nframe,  % 強度（＋dB変換）行列（対象性を勘案）
    for templ=1:dftsize/2,
        m3D(templ,tempk) = sMagn(templ,tempk);
        db3D(templ,tempk) = 20*log10(sMagn(templ,tempk));
        x3D(templ,tempk) = sCplx(templ,tempk);
    end;
end;
%surf(t3D,f3D,db3D,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
%mesh(t3D,f3D,db3D);
%xlabel('Time [sec]');
%ylabel('Frequency [Hz]');
%zlabel('Magnitude [dB]');

% --- MagnitudeによるSortとSelect
sortTop = NumberOfSelectedWave; % SelectするMagnitudeの上位数
clear sScplx; % Select後の複素数格納配列
clear sSfreq; % Select後の周波数格納配列
clear sSmagn; % Select後の強度（振幅）格納配列
clear sSphas; % Select後の位相格納配列
for tempk=1:nframe,  % Frame分だけ各列に対して降順のSortを実施
    [ sSmagntemp, sortIdx ] = sortrows( m3D, -1*tempk );
    for templ=1:sortTop,  % sortTop分だけSelectして新配列に格納
        sSmagn(templ,tempk) = sSmagntemp(templ,tempk);
        sScplx(templ,tempk) = sCplx(sortIdx(templ),tempk);
        sSfreq(templ,tempk) = sFreq(sortIdx(templ),tempk);
        sSphas(templ,tempk) = sPhas(sortIdx(templ),tempk);
    end;
end;

% --- 2D Graph plot
for tempk=1:nframe,  % 
    for templ=1:sortTop,  % 1行目は周波数、2行目は時間数
        f2D(1,(tempk-1)*sortTop+templ) = sSfreq(templ,tempk);
        f2D(2,(tempk-1)*sortTop+templ) = t3D(tempk);
    end;
end;
%scatter(f2D(2,:),f2D(1,:),50,'+');
%xlabel('Time [sec]');
%ylabel('Frequency [Hz]');
%axis([1.0,1.5,0,4000]);

% --- FrequencyによるSort
clear sCcplx; % Sort後の複素数格納配列
clear sCfreq; % Sort後の周波数格納配列
clear sCmagn; % Sort後の強度（振幅）格納配列
clear sCphas; % Sort後の位相格納配列
clear sCstno; % Sort後の紐番号格納配列
clear sCstor; % Sort後の紐内順序番号格納配列
for tempk=1:nframe,  % Frame分だけ各列に対してFrequency降順のSortを実施
    [ sCfreqtemp, sortIdx ] = sortrows( sSfreq, -1*tempk );
    for templ=1:sortTop,  % 新配列に格納
        sCmagn(templ,tempk) = sSmagn(sortIdx(templ),tempk);
        sCcplx(templ,tempk) = sScplx(sortIdx(templ),tempk);
        sCfreq(templ,tempk) = sCfreqtemp(templ,tempk);
        sCphas(templ,tempk) = sSphas(sortIdx(templ),tempk);
    end;
end;
% --- 仮にSort後の全ての各行がひとつの紐であるとみなす
for tempk=1:nframe,
    for templ=1:sortTop,
        sCstno(templ,tempk) = templ;
        sCstor(templ,tempk) = tempk;
    end;
end;

% --- 紐に対してIFFT&Interpolation
for templ=1:sortTop,
    for tempk=1:nframe,
        fftCplx(templ+1) = sCcplx(templ,tempk);
        fftCplx(dftsize-templ+1) = sCcplx(templ,tempk);
        if(tempk==1),
            ifftS = real( ifft( fftCplx, dftsize )*1 ) ;
        else
            ifftS = horzcat( ifftS, real( ifft( fftCplx, dftsize )*1 ) );
if(switchInterpolation), % 接続処理
            gThree=0;
            gTwo=0;
            gOne=0;
            gZero=0;
            gTtmp1=0;
            gTtmp2=0;
            alpha1=0;
            alpha2=0;
            alphaF=0;
            beta1=0;
            beta2=0;
            betaF=0;
            for tempj =1:dftsize-1, % beta search
                originIdx = dftsize*(tempk-1)+1;
                searchIdx = originIdx-tempj;
                if ( sign(ifftS(searchIdx))*sign(ifftS(searchIdx-1)) <= 0 ),
                    if (alphaF==0),
                        alpha1=searchIdx;
                        alpha2=searchIdx-1;
                        alphaF=1;
                    else
                        if (alpha2~=searchIdx),
                            beta1=searchIdx;
                            beta2=searchIdx-1;
                            betaF=1;
                        end;
                    end;
                end;
                if (betaF == 1),
                    break;
                end;
            end;
            gZero=ifftS(originIdx);
            gOne=(ifftS(originIdx+1)-ifftS(originIdx))/(1/Fs);
            gTtmp1=ifftS(beta1);
            gTtmp2=(ifftS(beta1)-ifftS(beta2))/(1/Fs);
            gTwo=(-3/((beta1-originIdx)/Fs)^2)*(gZero-gTtmp1)+(-1/((beta1-originIdx)/Fs))*(2*gOne+gTtmp2);
            gThree=(2/((beta1-originIdx)/Fs)^3)*(gZero-gTtmp1)+(1/((beta1-originIdx)/Fs)^2)*(gOne+gTtmp2);
            % beta2からoriginIdx-1まで3次補間式で上書き
            for tempi=beta2:originIdx-1,
                ifftS(tempi) = gThree*((tempi-originIdx)/Fs)^3 + gTwo*((tempi-originIdx)/Fs)^2 + gOne*((tempi-originIdx)/Fs) + gZero;
            end;
end;
        end;
    end; % Frameごとの処理
    if(templ==1),
        sumS = ifftS;
    else
        sumS = sumS + ifftS;
    end;
end; % Stringごとの処理

if(switchSound),
    sound( sumS, Fs ); 
end;
if(switchPlot),
    tXp = (1:length(sumS))/Fs; % Time vector
    plot(tXp,sumS);
    axis([startSec,endSec,minimumMagnitude,maximumMagnitude]);
end;
if(switchWavfile),
    audiowrite('TreatedWavFile.wav',sumS,Fs); 
end;

return;

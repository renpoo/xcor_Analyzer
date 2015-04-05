% Sinusoidal Decomposition and Re-Composition with Sinewave
% Using Sinewave / Linear Interpolation
close all; 
clear;

% --- Parameter Set-up
% Cut-Off Frequency for Low-Pass Filter
    CutoffFrequency     = 7000;
% Window Size for FFT
    FFTDftSize          = 4096;
% Minimum Amplitude Threshold for Peak Pick-up
    miniMagn            = 1;
% Connected Freq Multiplier
    ConnectDelta        = 2^(1/12); 
% Minimum String Length for String Selection
    StringLength        = 9;
% Sound Volume Multiplier for Treated Sound
    SoundMultiplier     = 2;

% Low-Pass Filter      - ON:1 / OFF:0
    LPFilter            = 1;
% Hanning Window       - ON:1 / OFF:0
    HanningWindow       = 0;
% Magnitude Smoothing  - ON:1 / OFF:0
    MagnitudeSmoothing  = 1;

% Sound - ON:1 / OFF:0 *Multiple selection is not supported
    OriginalSound   = 0;
    LPFilteredSound = 0;
    TreatedSound    = 1;
% Graph - ON:1 / OFF:0 *Multiple selection is not supported
    OriginalGraph              = 0;
    LPFilteredGraph            = 0;
    TreatedGraph               = 0;
    ConnctSlctFrequency3DGraph = 0;

% WAV Write - ON:1 / OFF:0 *Filename extension ".wav" must be added at the end
    WavFileWrite  = 0;
    OutputWavName = 'OutputFile01.wav';



% --- WAV open and read
[ fname, pname ] = uigetfile( '*.wav', 'SELECT WAV FILE' );
audFileName = strcat( pname, '/', fname );
%Fs = 44100;
%samples = [0.5*Fs,1*Fs];
samples = [1,inf];
[s0,Fs] = audioread(audFileName,samples);



% --- Original Sound Pre-set-up
t0 = (1:length(s0))/Fs; % Time vector
s0R = s0(1:length(s0),1); % R channel
%s0L = s0(1:length(s0),2); % L channel
s = s0R; % 1 channel
if(OriginalSound),
    sound( s0, Fs ); %Original audio
end;
if(OriginalGraph),
    plot(t0, s0);
    %plot(t0, s0R, t0, s);
    %axis([0,3.5,-0.18,0.18]);
end;



% --- Matlab Low-Pass Filter
if(LPFilter),
    cutf = CutoffFrequency; % Cut-off frequency
    cutfnorm = cutf/(Fs/2); % Normalized frequency
    df = designfilt('lowpassfir','FilterOrder',100,'CutoffFrequency',cutfnorm);
    %grpdelay(df,2048,Fs);
    D = mean(grpdelay(df)); % Average delay
    % --- Filter
    slength = length(s);
    %s = filter(df, s); % Just filter
    s = filter(df, [s;zeros(D,1)]);
    s = s(D+1:slength+D);
    if(LPFilteredSound),
        sound(s, Fs);
    end;
    if(LPFilteredGraph),
        plot(t0, s);
        %plot(t0, s0R, t0, s);
        %axis([0,3.5,-0.18,0.18]);
    end;
end;



% --- Matlab Hanning Window Function
if(HanningWindow),
    hannWin = hann(FFTDftSize);
    nframe = floor(length(s)/FFTDftSize);
    for tempk=1:nframe,
        tmpshift = FFTDftSize*(tempk-1);
        s(tmpshift+1:tmpshift+FFTDftSize) = hannWin.*s(tmpshift+1:tmpshift+FFTDftSize);
    end;
end;



% --- Matlab FFT
dftsize = FFTDftSize;
nframe = floor(length(s0)/dftsize);
clear sCplx;
clear sFreq;
clear sMagn;
clear sPhas;
for k=1:nframe,
    tmpshift=dftsize*(k-1);
    fftS=fft(s(tmpshift+1:tmpshift+dftsize),dftsize);
    if (k==1),
        sCplx=fftS;
        sMagn=abs(fftS);
        sPhas=unwrap(angle(fftS));
    else
        sCplx = horzcat(sCplx, fftS);
        sMagn = horzcat(sMagn, abs(fftS));
        sPhas = horzcat(sPhas, unwrap(angle(fftS)));
    end;
    for tempk=1:dftsize,
        sFreq(tempk,k) = (Fs/dftsize)*(tempk);
    end;
end;



% --- Magnitude Peak Select
sortTop(1:nframe) = 0; % Peak Number
tempStop = 0; % Peak Count
clear sFcplx;
clear sFfreq;
clear sFmagn;
clear sFphas;
for tempk=1:nframe,
    tempStop = 0;
    if(sMagn(1,tempk) > miniMagn), % Magnitude Threshold
        if( sMagn(1,tempk) >= sMagn(2,tempk)),
            tempStop = tempStop + 1;
            sFmagn(tempStop,tempk) = sMagn(1,tempk);
            sFcplx(tempStop,tempk) = sCplx(1,tempk);
            sFfreq(tempStop,tempk) = sFreq(1,tempk);
            sFphas(tempStop,tempk) = sPhas(1,tempk);
            sFfreqtmp(tempStop,tempk) = sFreq(1,tempk); % For 2D Graph plot
            sFmagntmp(tempStop,tempk) = sMagn(1,tempk); % For 2D Graph plot
        end;
    end;
    for templ=2:dftsize/2-1,  % Peak Select
        if(sMagn(templ,tempk) > miniMagn), % Magnitude Threshold
            if(sMagn(templ,tempk) >= sMagn(templ-1,tempk) ) && ...
                    (sMagn(templ,tempk) >= sMagn(templ+1,tempk)),
                tempStop = tempStop + 1;
                sFmagn(tempStop,tempk) = sMagn(templ,tempk);
                sFcplx(tempStop,tempk) = sCplx(templ,tempk);
                sFfreq(tempStop,tempk) = sFreq(templ,tempk);
                sFphas(tempStop,tempk) = sPhas(templ,tempk);
                sFfreqtmp(templ,tempk) = sFreq(templ,tempk); % For 2D Graph plot
                sFmagntmp(templ,tempk) = sMagn(templ,tempk); % For 2D Graph plot
            end;
        end;
    end;
    if(sMagn(dftsize/2,tempk) > miniMagn), % Magnitude Threshold
        if( sMagn(dftsize/2,tempk) >= sMagn(dftsize/2-1,tempk)),
            tempStop = tempStop + 1;
            sFmagn(tempStop,tempk) = sMagn(dftsize/2,tempk);
            sFcplx(tempStop,tempk) = sCplx(dftsize/2,tempk);
            sFfreq(tempStop,tempk) = sFreq(dftsize/2,tempk);
            sFphas(tempStop,tempk) = sPhas(dftsize/2,tempk);
            sFfreqtmp(templ,tempk) = sFreq(dftsize/2,tempk); % For 2D Graph plot
            sFmagntmp(templ,tempk) = sMagn(dftsize/2,tempk); % For 2D Graph plot
        end;
    end;
    sortTop(tempk) = tempStop;
end;



% --- Connect Adjacent Frequency Thread
delta = ConnectDelta; % Connect count
strcnt = 0;
clear sFstno;
sFstno = zeros(max(sortTop),nframe);
clear sCcplx;
sCcplx = zeros(max(sortTop),nframe);
clear sCfreq;
sCfreq = zeros(max(sortTop),nframe);
clear sCmagn;
sCmagn = zeros(max(sortTop),nframe);
clear sCphas;
sCphas = zeros(max(sortTop),nframe);
for tempk=1:nframe-1,  % Connect
    for templ=1:sortTop(tempk),
        for tempm=1:sortTop(tempk+1),
            if (sFfreq(templ,tempk) ~= 0) && (sFfreq(tempm,tempk+1) ~= 0) && ...
                    (sFfreq(templ,tempk) == sFfreq(tempm,tempk+1)),
                if(sFstno(templ,tempk)==0), % New string
                    strcnt=strcnt+1;
                    sFstno(templ,tempk)=strcnt;
                    sFstno(tempm,tempk+1)=strcnt;
                    sCmagn(strcnt,tempk) = sFmagn(templ,tempk);
                    sCcplx(strcnt,tempk) = sFcplx(templ,tempk);
                    sCfreq(strcnt,tempk) = sFfreq(templ,tempk);
                    sCphas(strcnt,tempk) = sFphas(templ,tempk);
                    sCmagn(strcnt,tempk+1) = sFmagn(tempm,tempk+1);
                    sCcplx(strcnt,tempk+1) = sFcplx(tempm,tempk+1);
                    sCfreq(strcnt,tempk+1) = sFfreq(tempm,tempk+1);
                    sCphas(strcnt,tempk+1) = sFphas(tempm,tempk+1);
                else % Stretch
                    sFstno(tempm,tempk+1)=sFstno(templ,tempk);
                    sCmagn(sFstno(templ,tempk),tempk+1) = sFmagn(tempm,tempk+1);
                    sCcplx(sFstno(templ,tempk),tempk+1) = sFcplx(tempm,tempk+1);
                    sCfreq(sFstno(templ,tempk),tempk+1) = sFfreq(tempm,tempk+1);
                    sCphas(sFstno(templ,tempk),tempk+1) = sFphas(tempm,tempk+1);
                end;
            end;
        end;
    end;
    for templ=1:sortTop(tempk)-1,
        if (sFstno(templ,tempk) == 0),
            tempStringFlag = 0;
        else
            tempStringFlag = sCfreq(sFstno(templ,tempk),tempk+1);
        end;
        if (tempStringFlag == 0),
            fDiff=-1; % Frequency diff
            dDiff=sFfreq(templ,tempk)*(delta-1);
            tmpR=0;
            for tempm=1:sortTop(tempk+1),
                if (sFfreq(templ,tempk) ~= 0) && (sFfreq(tempm,tempk+1) ~= 0) && ...
                        (sFstno(tempm,tempk+1) == 0),
                    if (abs(sFfreq(templ,tempk)-sFfreq(tempm,tempk+1)) <= dDiff)...
                            && (abs(sFfreq(templ,tempk)-sFfreq(tempm,tempk+1))...
                                 <= abs(sFfreq(templ+1,tempk)-sFfreq(tempm,tempk+1))),
                        if (fDiff<0),
                            fDiff=abs(sFfreq(templ,tempk)-sFfreq(tempm,tempk+1));
                            tmpR=tempm;
                        else
                            if (abs(sFfreq(templ,tempk)-sFfreq(tempm,tempk+1)) < fDiff),
                                fDiff=abs(sFfreq(templ,tempk)-sFfreq(tempm,tempk+1));
                                tmpR=tempm;
                            else
                                break;
                            end;
                        end;
                    end;
                end;
            end;
            if (tmpR~=0),
                if(sFstno(templ,tempk)==0), % New String
                    strcnt=strcnt+1;
                    sFstno(templ,tempk)=strcnt;
                    sFstno(tmpR,tempk+1)=strcnt;
                    sCmagn(strcnt,tempk) = sFmagn(templ,tempk);
                    sCcplx(strcnt,tempk) = sFcplx(templ,tempk);
                    sCfreq(strcnt,tempk) = sFfreq(templ,tempk);
                    sCphas(strcnt,tempk) = sFphas(templ,tempk);
                    sCmagn(strcnt,tempk+1) = sFmagn(tmpR,tempk+1);
                    sCcplx(strcnt,tempk+1) = sFcplx(tmpR,tempk+1);
                    sCfreq(strcnt,tempk+1) = sFfreq(tmpR,tempk+1);
                    sCphas(strcnt,tempk+1) = sFphas(tmpR,tempk+1);
                else % Stretch
                    sFstno(tmpR,tempk+1)=sFstno(templ,tempk);
                    sCmagn(sFstno(templ,tempk),tempk+1) = sFmagn(tmpR,tempk+1);
                    sCcplx(sFstno(templ,tempk),tempk+1) = sFcplx(tmpR,tempk+1);
                    sCfreq(sFstno(templ,tempk),tempk+1) = sFfreq(tmpR,tempk+1);
                    sCphas(sFstno(templ,tempk),tempk+1) = sFphas(tmpR,tempk+1);
                end;
            end;
        end;
    end;
    for templ=1:sortTop(tempk),
        if (sFstno(templ,tempk) == 0),
            tempStringFlag = 0;
        else
            tempStringFlag = sCfreq(sFstno(templ,tempk),tempk+1);
        end;
        if (tempStringFlag == 0),
            fDiff=-1; % Frequency diff
            dDiff=sFfreq(templ,tempk)*(delta-1);
            tmpR=0;
            for tempm=1:sortTop(tempk+1),
                if (sFfreq(templ,tempk) ~= 0) && (sFfreq(tempm,tempk+1) ~= 0)...
                        && (sFstno(tempm,tempk+1) == 0),
                    if (abs(sFfreq(templ,tempk)-sFfreq(tempm,tempk+1)) <= dDiff),
                        if (fDiff<0),
                            fDiff=abs(sFfreq(templ,tempk)-sFfreq(tempm,tempk+1));
                            tmpR=tempm;
                        else
                            if (abs(sFfreq(templ,tempk)-sFfreq(tempm,tempk+1)) < fDiff),
                                fDiff=abs(sFfreq(templ,tempk)-sFfreq(tempm,tempk+1));
                                tmpR=tempm;
                            else
                                break;
                            end;
                        end;
                    end;
                end;
            end;
            if (tmpR~=0),
                if(sFstno(templ,tempk)==0), % New string
                    strcnt=strcnt+1;
                    sFstno(templ,tempk)=strcnt;
                    sFstno(tmpR,tempk+1)=strcnt;
                    sCmagn(strcnt,tempk) = sFmagn(templ,tempk);
                    sCcplx(strcnt,tempk) = sFcplx(templ,tempk);
                    sCfreq(strcnt,tempk) = sFfreq(templ,tempk);
                    sCphas(strcnt,tempk) = sFphas(templ,tempk);
                    sCmagn(strcnt,tempk+1) = sFmagn(tmpR,tempk+1);
                    sCcplx(strcnt,tempk+1) = sFcplx(tmpR,tempk+1);
                    sCfreq(strcnt,tempk+1) = sFfreq(tmpR,tempk+1);
                    sCphas(strcnt,tempk+1) = sFphas(tmpR,tempk+1);
                else % Stretch
                    sFstno(tmpR,tempk+1)=sFstno(templ,tempk);
                    sCmagn(sFstno(templ,tempk),tempk+1) = sFmagn(tmpR,tempk+1);
                    sCcplx(sFstno(templ,tempk),tempk+1) = sFcplx(tmpR,tempk+1);
                    sCfreq(sFstno(templ,tempk),tempk+1) = sFfreq(tmpR,tempk+1);
                    sCphas(sFstno(templ,tempk),tempk+1) = sFphas(tmpR,tempk+1);
                end;
            end;
        end;
    end;
end;



% --- String Sort&Select
clear sCstln;
clear sLcplx;
clear sLfreq;
clear sLmagn;
clear sLphas;
nString=strcnt;
strLen=StringLength; % Selected String Length
nSstring=0;
for templ=1:nString,  % Length of String
    tempLen=0;
    for tempk=1:nframe, 
        if (sCcplx(templ,tempk)~=0),
            tempLen=tempLen+1;
        end;
    end;
    sCstln(templ,1)=tempLen;
    if(tempLen >= strLen),
        nSstring=nSstring+1;
    end;
end;
[ sCstlntemp, sortIdx ] = sortrows( sCstln, -1 );
for templ=1:nSstring,
    for tempk=1:nframe,
        sLmagn(templ,tempk) = sCmagn(sortIdx(templ),tempk);
        sLcplx(templ,tempk) = sCcplx(sortIdx(templ),tempk);
        sLfreq(templ,tempk) = sCfreq(sortIdx(templ),tempk);
        sLphas(templ,tempk) = sCphas(sortIdx(templ),tempk);
    end;
end;



% --- 3D Graph plot
if(ConnctSlctFrequency3DGraph),
    for templ=1:nSstring,  % Number of String
        for tempk=1:nframe,  % Frame
            t3D2(tempk) = (dftsize/Fs)*(tempk);
            f3D2(templ,tempk) = sLfreq(templ,tempk);
            m3D2(templ,tempk) = sLmagn(templ,tempk);
            db3D2(templ,tempk) = 20*log10(sLmagn(templ,tempk));
        end;
        tempLw=3;
        tempMs=5;
        if(templ==1),
            plot3(t3D2,f3D2(templ,:),db3D2(templ,:),'-ob',...
                                                    'LineWidth',tempLw,...
                                                    'MarkerSize',tempMs);
            xlabel('Time [sec]');
            ylabel('Frequency [Hz]');
            zlabel('Magnitude [dB]');
            hold on;
            grid on;
        else
            colorNo = mod(templ,5);
            switch colorNo
                case 1
                    plot3(t3D2,f3D2(templ,:),db3D2(templ,:),'-ob',...
                                                    'LineWidth',tempLw,...
                                                    'MarkerSize',tempMs);
                case 2
                    plot3(t3D2,f3D2(templ,:),db3D2(templ,:),'-or',...
                                                    'LineWidth',tempLw,...
                                                    'MarkerSize',tempMs);
                case 3
                    plot3(t3D2,f3D2(templ,:),db3D2(templ,:),'-og',...
                                                    'LineWidth',tempLw,...
                                                    'MarkerSize',tempMs);
                case 4
                    plot3(t3D2,f3D2(templ,:),db3D2(templ,:),'-oy',...
                                                    'LineWidth',tempLw,...
                                                    'MarkerSize',tempMs);
                case 0
                    plot3(t3D2,f3D2(templ,:),db3D2(templ,:),'-ok',...
                                                    'LineWidth',tempLw,...
                                                    'MarkerSize',tempMs);
            end;
        end;
    end;
    hold off;
end;



% --- Re-composition with Sinewave
stringS = zeros(nSstring,length(s0));
for templ=1:nSstring,
    for tempk=1:nframe,
        frameStart = (tempk-1)*dftsize+1;
        if(sLmagn(templ,tempk) > 0),
            stringMagn = sLmagn(templ,tempk)/(dftsize/2);
            stringFreq = sLfreq(templ,tempk);
            for tempj=1:dftsize,
                timeIdx = frameStart+tempj-1;
                stringS(templ,timeIdx) = stringMagn*sin(2*pi*(stringFreq/Fs)*(timeIdx));
            end;
        end;
        % Magnitude Smoothing with linear prediction
        if(MagnitudeSmoothing) && (tempk~=1),
            if(sLmagn(templ,tempk-1) > 0),
                for temph = (tempk-2)*dftsize+1:(tempk-1)*dftsize,
                    diffMagn = sLmagn(templ,tempk)/(dftsize/2) - sLmagn(templ,tempk-1)/(dftsize/2);
                    mlp = ((diffMagn/dftsize) * (temph - (tempk-2)*dftsize))/(sLmagn(templ,tempk-1)/(dftsize/2));
                    stringS(templ,temph)=stringS(templ,temph)*(1+mlp);
                end;
            end;
        end;
    end;
end;



% --- Strings Summation
FlagOfsumS = 0;
for templ=1:nSstring,
    if(templ==1),
        sumS = stringS(templ,:);
    else
        sumS = sumS + stringS(templ,:);
    end;
end;
sumS = sumS*SoundMultiplier;
if(TreatedSound),
    sound(sumS,Fs)
end;
if(TreatedGraph),
    t0 = (1:length(sumS))/Fs; % Time vector
    plot(t0,sumS);
    %axis([2.0,2.25,-5.9,5.9]);
end;



% --- Write WAV File
if(WavFileWrite),
    wavwrite(sumS,Fs,OutputWavName);
end;



return;
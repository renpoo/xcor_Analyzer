close all; 
clear;


% --- WAV?t?@?C?????I??
[ fname, pname ] = uigetfile( '*.wav', 'SELECT WAV FILE' );
audFileName = strcat( pname, '/', fname );

% --- WAV???????????????Fsamples???J?n???I???i?b??*Fs?Ainf???S?????j
samples = [1,inf];
[s0,Fs] = audioread(audFileName,samples);

% --- ????????
t0 = (1:length(s0))/Fs; % Time vector
s0R = s0(1:length(s0),1); % R channel
%s0L = s0(1:length(s0),2); % L channel
s = s0R; % s??1?`???l????????



%sound( s0, Fs ); %Original audio



% --- Matlab?g??Low-Pass Filter????
if(1),
    cutf = 4000; % Cut-off frequency
    cutfnorm = cutf/(Fs/2); % Normalized frequency
    df = designfilt('lowpassfir','FilterOrder',100,'CutoffFrequency',cutfnorm);
    % --- Filter???????x?????m?F
    %grpdelay(df,2048,Fs); % Group delay?????l?????P?????????V?t?g??????????
    D = mean(grpdelay(df)); % Average delay
    % --- Filter + ?x??????????
    slength = length(s);
    %s = filter(df, s); % ?x????????????Filter????
    s = filter(df, [s;zeros(D,1)]);
    s = s(D+1:slength+D);
    %sound(s, Fs);
    %plot(t0, s0R, t0, s);
    %axis([0.3,0.35,-0.2,0.2]);
end;



% --- Matlab?g??FFT????
dftsize = 512;
nframe = floor(length(s0)/dftsize);
clear sCplx; % fft???????f???i?[?z??
clear sFreq; % fft???????g???i?[?z??
clear sMagn; % fft???????x?i?U???j?i?[?z??
clear sPhas; % fft?????????i?[?z??
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



% --- ???g???????????????????r????3D Graph plot
for tempk=1:nframe,
    t3D(tempk) = (dftsize/Fs)*(tempk);
end;
for templ=1:dftsize/2,
    f3D(templ) = (Fs/dftsize)*(templ);
end;
for tempk=1:nframe,
    for templ=1:dftsize/2,
        m3D(templ,tempk) = sMagn(templ,tempk);
        db3D(templ,tempk) = 20*log10(sMagn(templ,tempk));
        x3D(templ,tempk) = sCplx(templ,tempk);
    end;
end;
if (0),
    surf(t3D,f3D,db3D,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
    %mesh(t3D,f3D,db3D);
    xlabel('Time [sec]');
    ylabel('Frequency [Hz]');
    zlabel('Magnitude [dB]');
    return;
end;


% --- Magnitude??????Sort??Select
if(0),
    sortTop(1:nframe) = 8;
    clear sScplx; % Select???????f???i?[?z??
    clear sSfreq; % Select???????g???i?[?z??
    clear sSmagn; % Select???????x?i?U???j?i?[?z??
    clear sSphas; % Select?????????i?[?z??
    for tempk=1:nframe,
        [ sSmagntemp, sortIdx ] = sortrows( m3D, -1*tempk );
        for templ=1:sortTop(tempk),
            sSmagn(templ,tempk) = sSmagntemp(templ,tempk);
            sScplx(templ,tempk) = sCplx(sortIdx(templ),tempk);
            sSfreq(templ,tempk) = sFreq(sortIdx(templ),tempk);
            sSphas(templ,tempk) = sPhas(sortIdx(templ),tempk);
        end;
    end;
% --- 2D Graph plot
    if(0),
        for tempk=1:nframe,  % 
            for templ=1:sortTop,
                t3D2(tempk) = (dftsize/Fs)*(tempk);
                f2D(1,(tempk-1)*sortTop+templ) = sSfreq(templ,tempk);
                f2D(2,(tempk-1)*sortTop+templ) = t3D2(tempk);
            end;
        end;
        scatter(f2D(2,:),f2D(1,:),50,'+');
        xlabel('Time [sec]');
        ylabel('Frequency [Hz]');
        %axis([1.0,1.5,0,4000]);
        axis([0,3.5,0,4000]);
    end;
% --- 3D Graph plot
    if(1),
        for templ=1:sortTop,  % ???g????
            for tempk=1:nframe,  % ??????
                t3D2(tempk) = (dftsize/Fs)*(tempk);
                f3D2(templ,tempk) = sSfreq(templ,tempk);
                m3D2(templ,tempk) = sSmagn(templ,tempk);
                db3D2(templ,tempk) = 20*log10(sSmagn(templ,tempk));
            end;
            if(templ==1),
                scatter3(t3D2,f3D2(templ,:),db3D2(templ,:));
                xlabel('Time [sec]');
                ylabel('Frequency [Hz]');
                zlabel('Magnitude [dB]');
                hold on;
            else
                scatter3(t3D2,f3D2(templ,:),db3D2(templ,:));
            end;
        end;
        hold off;
    surf(t3D2,f3D2,db3D2,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
    %surf(t3D2,f3D2,db3D2);
    %mesh(t3D2,f3D2,db3D2);
    %scatter3(t3D2,f3D2,db3D2);
    return;
    end;
    
    
    
% --- Magnitude??Sort&Select????????????????IFFT
    if(0),
        ifftS = zeros(1,dftsize);
        for tempk=1:nframe,
            for templ=1:sortTop,
                Xp(templ) = sScplx(templ,tempk);
                Xp(dftsize-templ) = sScplx(templ,tempk);
            end;
            ifftS = horzcat( ifftS, real( ifft( Xp, dftsize )*5.5 ) ); %real??????
        end;
        sound( ifftS, Fs ); 
        plot(ifftS);
        %axis([8190,12288,-0.8,0.8]);
    end;
% --- Frequency??????Sort
    clear sFcplx; % Frquency Sort???????f???i?[?z??
    clear sFfreq; % Frquency Sort???????g???i?[?z??
    clear sFmagn; % Frquency Sort???????x?i?U???j?i?[?z??
    clear sFphas; % Frquency Sort?????????i?[?z??
    for tempk=1:nframe,
        [ sCfreqtemp, sortIdx ] = sortrows( sSfreq, tempk );
        for templ=1:sortTop(tempk),
            sFmagn(templ,tempk) = sSmagn(sortIdx(templ),tempk);
            sFcplx(templ,tempk) = sScplx(sortIdx(templ),tempk);
            sFfreq(templ,tempk) = sCfreqtemp(templ,tempk);
            sFphas(templ,tempk) = sSphas(sortIdx(templ),tempk);
        end;
    end;
% --- Frequency??Sort????????????????IFFT
    if(0),
        for tempk=1:nframe,
            for templ=1:sortTop,
                Xp(templ) = sFcplx(templ,tempk);
                Xp(dftsize-templ) = sFcplx(templ,tempk);
            end;
            if(tempk==1),
                ifftS = real( ifft( Xp, dftsize )*5.5);
            else
                ifftS = horzcat( ifftS, real( ifft( Xp, dftsize )*5.5 ) );
            end;
        end;
        sound( ifftS, Fs );
        tXp = (1:length(ifftS))/Fs; % Time vector
        plot(tXp,ifftS);
        axis([1,1.1,-0.7,0.7]);
    end;
end;



% --- Peak???o??????Select
if(1),
    sortTop(1:nframe) = 0;
    tempStop = 0;
    clear sFcplx; % Select???????f???i?[?z??
    clear sFfreq; % Select???????g???i?[?z??
    clear sFmagn; % Select???????x?i?U???j?i?[?z??
    clear sFphas; % Select?????????i?[?z??
    for tempk=1:nframe,
        tempStop = 0;
        if(sMagn(1,tempk) > 0.1),
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
        for templ=2:dftsize/2-1,
            if(sMagn(templ,tempk) > 0.1),
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
        if(sMagn(dftsize/2,tempk) > 0.1),
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
% --- 2D Graph plot
    if(0),
        plot(m3D(:,101));
        hold on;
        plot(sFmagntmp(:,101),'bo');
        hold off;
        axis([0,50,0,15]);
    end;
end;
% --- 2D Graph plot
if(0),
    for tempk=1:nframe,  % ??????
        t3D2(tempk) = (dftsize/Fs)*(tempk);
    end;
    scatter(t3D2,sFfreq(1,:),30,'+');
    xlabel('Time [sec]');
    ylabel('Frequency [Hz]');
    %axis([1.0,1.5,0,4000]);
%    axis([0.5,2.0,0,700]);
    %axis([0,3.5,0,4500]);
    hold on;
    for templ=2:max(sortTop),
        scatter(t3D2,sFfreq(templ,:),30,'+');
    end;
    hold off;
end;



% --- Frequency??????Connect????
delta = 2^(1/12);
strcnt = 0;
clear sFstno; % ?RConnect?????????R?????i?[?z??
sFstno = zeros(max(sortTop),nframe);
clear sCcplx; % ?RConnect???????f???i?[?z??
clear sCfreq; % ?RConnect???????g???i?[?z??
sCfreq = zeros(max(sortTop),nframe); % ?RConnect???????g???i?[?z??
clear sCmagn; % ?RConnect???????x?i?U???j?i?[?z??
clear sCphas; % ?RConnect?????????i?[?z??
if(1),
for tempk=1:nframe-1,
    for templ=1:sortTop(tempk),
        for tempm=1:sortTop(tempk+1),
            if (sFfreq(templ,tempk) ~= 0) && (sFfreq(tempm,tempk+1) ~= 0) && ...
                    (sFfreq(templ,tempk) == sFfreq(tempm,tempk+1)),
                if(sFstno(templ,tempk)==0),
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
                else
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
            fDiff=-1;
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
                if(sFstno(templ,tempk)==0),
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
                else
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
            fDiff=-1;
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
                if(sFstno(templ,tempk)==0),
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
                else
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
% --- 2D Graph plot
    if(0),
        plot(sCfreq(116,:));
    end;
end;



% --- 2D Graph plot
if(0),
    for tempk=1:nframe,  % ??????
        t3D2(tempk) = (dftsize/Fs)*(tempk);
    end;
    scatter(t3D2,sCfreq(1,:),30,'+');
    xlabel('Time [sec]');
    ylabel('Frequency [Hz]');
    %axis([1.0,1.5,0,4000]);
    axis([0.5,2.0,0,700]);
    %axis([0,3.5,0,4500]);
    hold on;
    for templ=2:strcnt,
        scatter(t3D2,sCfreq(templ,:),30,'+');
    end;
    hold off;
end;




% --- ?R????????Sort&Select????
clear sCstln; % ?RConnect?????R??
clear sLcplx; % ?R??Select???????f???i?[?z??
clear sLfreq; % ?R??Select???????g???i?[?z??
clear sLmagn; % ?R??Select???????x?i?U???j?i?[?z??
clear sLphas; % ?R??Select?????????i?[?z??
nString=strcnt;
strLen=13;
nSstring=0;
if(1),
for templ=1:nString,
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
end;
% -----------------------------------------------
%????Sort?????S?????e?s???????????R??????????????????
%sLcplx = sFcplx;
%sLmagn = sFmagn;
%sLfreq = sFfreq;
%sLphas = sFphas;
%for tempk=1:nframe,
%    for templ=1:sortTop,
%        sCstno(templ,tempk) = templ;
%        sCstor(templ,tempk) = tempk;
%    end;
%end;
% -----------------------------------------------



% --- 2D Graph plot
if(0),
    for tempk=1:nframe,  % ??????
        t3D2(tempk) = (dftsize/Fs)*(tempk);
    end;
    scatter(t3D2,sLfreq(1,:),50,'+');
    xlabel('Time [sec]');
    ylabel('Frequency [Hz]');
    %axis([1.0,1.5,0,4000]);
    axis([0,3.5,0,4500]);
    hold on;
    for templ=2:nSstring,
        scatter(t3D2,sLfreq(templ,:),50,'+');
    end;
    hold off;
end;



% --- 3D Graph plot
if(1),
    for templ=1:nSstring,  % ?R??
        for tempk=1:nframe,  % Frame
            t3D2(tempk) = (dftsize/Fs)*(tempk);
            f3D2(templ,tempk) = sLfreq(templ,tempk);
            m3D2(templ,tempk) = sLmagn(templ,tempk);
            db3D2(templ,tempk) = 20*log10(sLmagn(templ,tempk));
        end;
        tempLw=3;
        tempMs=5;
        if(templ==1),
            surf(t3D2,f3D,db3D,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
            %mesh(t3D2,f3D,db3D);
            %plot3(t3D2,f3D2(templ,:),db3D2(templ,:),'-ob',...
            %                                        'LineWidth',tempLw,...
            %                                        'MarkerSize',tempMs);
            %plot3(t3D2,f3D2(1,:),db3D2(1,:));
            %scatter3(t3D2,f3D2(1,:),db3D2(1,:));
            xlabel('Time [sec]');
            ylabel('Frequency [Hz]');
            zlabel('Magnitude [dB]');
            hold on;
            grid on;
        else
            colorNo = mod(templ,5);
            switch colorNo
                case 1
                    %strC = 'b';
                    plot3(t3D2,f3D2(templ,:),db3D2(templ,:),'-ob',...
                                                    'LineWidth',tempLw,...
                                                    'MarkerSize',tempMs);
                case 2
                    %strC = 'r';
                    plot3(t3D2,f3D2(templ,:),db3D2(templ,:),'-or',...
                                                    'LineWidth',tempLw,...
                                                    'MarkerSize',tempMs);
                case 3
                    %strC = 'g';
                    plot3(t3D2,f3D2(templ,:),db3D2(templ,:),'-og',...
                                                    'LineWidth',tempLw,...
                                                    'MarkerSize',tempMs);
                case 4
                    %strC = 'y';
                    plot3(t3D2,f3D2(templ,:),db3D2(templ,:),'-oy',...
                                                    'LineWidth',tempLw,...
                                                    'MarkerSize',tempMs);
                case 0
                    %strC = 'k';
                    plot3(t3D2,f3D2(templ,:),db3D2(templ,:),'-ok',...
                                                    'LineWidth',tempLw,...
                                                    'MarkerSize',tempMs);
            end;
            %plot3(t3D2,f3D2(templ,:),db3D2(templ,:),strC);
            %scatter3(t3D2,f3D2(templ,:),db3D2(templ,:));
        end;
    end;
    hold off;
end;



% --- ?c???R(sL?n??)????????IFFT&3??????
if(1),
for templ=1:nSstring,
    for tempk=1:nframe,
%        if(sLcplx(templ,tempk) ~= 0),
            Xp(templ+1) = sLcplx(templ,tempk);
            Xp(dftsize-templ+1) = sLcplx(templ,tempk);
%        end;
        if(tempk==1),
            ifftS = real( ifft( Xp, dftsize ) )*2 ;
        else
            ifftS = horzcat( ifftS, real( ifft( Xp, dftsize ) )*2 );
if(1), % 3??????????
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
            for tempj =1:dftsize-1, 
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
            for tempi=beta2:originIdx-1,
                ifftS(tempi) = gThree*((tempi-originIdx)/Fs)^3 + gTwo*((tempi-originIdx)/Fs)^2 + gOne*((tempi-originIdx)/Fs) + gZero;
            end;
end;
        end;
    end; % Frame??????????
    % ?R?????Z????????????
    if(templ==1),
        sumS = ifftS;
    else
        sumS = sumS + ifftS;
    end;
end; % String??????????
%sound( sumS, Fs ); 
%tXp = (1:length(sumS))/Fs; % Time vector
%plot(tXp,sumS);
%axis([0.0,1.55,-0.5,0.5]);
end;




close all; 
clear;


% --- �e��p�����^�̐ݒ�
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


% --- WAV�t�@�C���̑I��
[ fname, pname ] = uigetfile( '*.wav', 'SELECT WAV FILE' );
audFileName = strcat( pname, '/', fname );
% --- WAV�̓ǂݍ���
[s0,Fs] = audioread(audFileName);
% --- �����ݒ�
t0 = (1:length(s0))/Fs; % Time vector
s0R = s0(1:length(s0),1); % R channel
%s0L = s0(1:length(s0),2); % L channel
s = s0R; % s��1�`���l���ň���
%sound( s0, Fs ); %Original audio

% --- Matlab�g��Low-Pass Filter����
if(switchLPFilter),
    cutf = CutOffFrequency; % Cut-off frequency
    cutfnorm = cutf/(Fs/2); % Normalized frequency
    df = designfilt('lowpassfir','FilterOrder',100,'CutoffFrequency',cutfnorm);
    % --- Filter�ɂ��x���̊m�F
    %grpdelay(df,2048,Fs); % Group delay����l�Ȃ�P���Ȏ��ԃV�t�g�ɂ��␳
    D = mean(grpdelay(df)); % Average delay
    % --- Filter + �x���␳����
    slength = length(s);
    %s = filter(df, s); % �x���������Ȃ�Filter����
    s = filter(df, [s;zeros(D,1)]); % s�̏I�[��D�[���t�B��
    s = s(D+1:slength+D); % s��D�������V�t�g
    %sound(s, Fs);
    %plot(t0, s0R, t0, s);
    %axis([0.3,0.35,-0.2,0.2]);
end;

% --- Matlab�g��FFT����
dftsize = SizeOfDFT; % fft��̊i�[�z��̍s�ɑ���
nframe = floor(length(s0)/dftsize); % fft��̊i�[�z��̗�ɑ���
clear sCplx; % fft��̕��f���i�[�z��
clear sFreq; % fft��̎��g���i�[�z��
clear sMagn; % fft��̋��x�i�U���j�i�[�z��
clear sPhas; % fft��̈ʑ��i�[�z��
for k=1:nframe,  % �eFrame����dftsize���̗�x�N�g���P�ʂ�FFT
    tmpshift=dftsize*(k-1);
    fftS=fft(s(tmpshift+1:tmpshift+dftsize),dftsize);
    if (k==1), % ����̂ݒP�����
        sCplx=fftS;
        sMagn=abs(fftS);
        sPhas=unwrap(angle(fftS));
    else  % ����ȍ~�͗�x�N�g���𐅕����Z
        sCplx = horzcat(sCplx, fftS);
        sMagn = horzcat(sMagn, abs(fftS));
        sPhas = horzcat(sPhas, unwrap(angle(fftS)));
    end;
    for tempk=1:dftsize,  % ���g���͌Œ�
        sFreq(tempk,k) = (Fs/dftsize)*(tempk);
    end;
end;

% --- ���g���̈�̑Ώƕ����̔r����3D Graph plot
for tempk=1:nframe,  % ���Ԏ�
    t3D(tempk) = (dftsize/Fs)*(tempk);
end;
for templ=1:dftsize/2,  % ���g�����i�Ώې������āj
    f3D(templ) = (Fs/dftsize)*(templ);
end;
for tempk=1:nframe,  % ���x�i�{dB�ϊ��j�s��i�Ώې������āj
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

% --- Magnitude�ɂ��Sort��Select
sortTop = NumberOfSelectedWave; % Select����Magnitude�̏�ʐ�
clear sScplx; % Select��̕��f���i�[�z��
clear sSfreq; % Select��̎��g���i�[�z��
clear sSmagn; % Select��̋��x�i�U���j�i�[�z��
clear sSphas; % Select��̈ʑ��i�[�z��
for tempk=1:nframe,  % Frame�������e��ɑ΂��č~����Sort�����{
    [ sSmagntemp, sortIdx ] = sortrows( m3D, -1*tempk );
    for templ=1:sortTop,  % sortTop������Select���ĐV�z��Ɋi�[
        sSmagn(templ,tempk) = sSmagntemp(templ,tempk);
        sScplx(templ,tempk) = sCplx(sortIdx(templ),tempk);
        sSfreq(templ,tempk) = sFreq(sortIdx(templ),tempk);
        sSphas(templ,tempk) = sPhas(sortIdx(templ),tempk);
    end;
end;

% --- 2D Graph plot
for tempk=1:nframe,  % 
    for templ=1:sortTop,  % 1�s�ڂ͎��g���A2�s�ڂ͎��Ԑ�
        f2D(1,(tempk-1)*sortTop+templ) = sSfreq(templ,tempk);
        f2D(2,(tempk-1)*sortTop+templ) = t3D(tempk);
    end;
end;
%scatter(f2D(2,:),f2D(1,:),50,'+');
%xlabel('Time [sec]');
%ylabel('Frequency [Hz]');
%axis([1.0,1.5,0,4000]);

% --- Frequency�ɂ��Sort
clear sCcplx; % Sort��̕��f���i�[�z��
clear sCfreq; % Sort��̎��g���i�[�z��
clear sCmagn; % Sort��̋��x�i�U���j�i�[�z��
clear sCphas; % Sort��̈ʑ��i�[�z��
clear sCstno; % Sort��̕R�ԍ��i�[�z��
clear sCstor; % Sort��̕R�������ԍ��i�[�z��
for tempk=1:nframe,  % Frame�������e��ɑ΂���Frequency�~����Sort�����{
    [ sCfreqtemp, sortIdx ] = sortrows( sSfreq, -1*tempk );
    for templ=1:sortTop,  % �V�z��Ɋi�[
        sCmagn(templ,tempk) = sSmagn(sortIdx(templ),tempk);
        sCcplx(templ,tempk) = sScplx(sortIdx(templ),tempk);
        sCfreq(templ,tempk) = sCfreqtemp(templ,tempk);
        sCphas(templ,tempk) = sSphas(sortIdx(templ),tempk);
    end;
end;
% --- ����Sort��̑S�Ă̊e�s���ЂƂ̕R�ł���Ƃ݂Ȃ�
for tempk=1:nframe,
    for templ=1:sortTop,
        sCstno(templ,tempk) = templ;
        sCstor(templ,tempk) = tempk;
    end;
end;

% --- �R�ɑ΂���IFFT&Interpolation
for templ=1:sortTop,
    for tempk=1:nframe,
        fftCplx(templ+1) = sCcplx(templ,tempk);
        fftCplx(dftsize-templ+1) = sCcplx(templ,tempk);
        if(tempk==1),
            ifftS = real( ifft( fftCplx, dftsize )*1 ) ;
        else
            ifftS = horzcat( ifftS, real( ifft( fftCplx, dftsize )*1 ) );
if(switchInterpolation), % �ڑ�����
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
            % beta2����originIdx-1�܂�3����Ԏ��ŏ㏑��
            for tempi=beta2:originIdx-1,
                ifftS(tempi) = gThree*((tempi-originIdx)/Fs)^3 + gTwo*((tempi-originIdx)/Fs)^2 + gOne*((tempi-originIdx)/Fs) + gZero;
            end;
end;
        end;
    end; % Frame���Ƃ̏���
    if(templ==1),
        sumS = ifftS;
    else
        sumS = sumS + ifftS;
    end;
end; % String���Ƃ̏���

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

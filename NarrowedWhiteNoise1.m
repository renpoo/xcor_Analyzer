close all; 
clear;

Fs = 44100;            % Sampling rate
Usec = 1;              % Unit time duration
Tsec = 30;              % Number of Unit time
cutf1 = 6400;          % Cut-off frequency 1
cutf2 = 1600;          % Cut-off frequency 2
cutf3 = 800;          % Cut-off frequency 3
cutf4 = 400;          % Cut-off frequency 4
cutf5 = 100;          % Cut-off frequency 5

% White Noise
sWnoi = 1-2.*rand(Usec*Fs,1);
%sound( sWnoi, Fs ); % Original Noise
%plot(sWnoi);
%axis([44000,44100,-1,1]);

% --- Matlab Low-Pass Filter
sLp = sWnoi; % Original White Noise
for k = 1:Tsec,
    switch k
    case 1
        cutf=cutf1;
    case 2
        cutf=cutf2;
    case 3
        cutf=cutf3;
    case 4
        cutf=cutf4;
    case 5
        cutf=cutf5;
    otherwise
        disp('Check Tsec');
    end;
    cutfnorm = cutf/(Fs/2); % Normalized frequency
    df = designfilt('lowpassfir','FilterOrder',100,'CutoffFrequency',cutfnorm);
    
    % --- LP-Filter No delay revision
    sWnoi = filter(df, sWnoi); 
    
    % --- Revise delay caused by LP-Filter
    %grpdelay(df,2048,Fs); % For check group delay
    %D = mean(grpdelay(df)); % Delay Average
    % --- LP-Filter & Delay compensation
    %slength = length(sWnoi);
    %sWnoi = filter(df, [sWnoi;zeros(D,1)]); % Zero fill
    %sWnoi = sWnoi(D+1:slength+D); % Shift

    sLp = vertcat(sLp, sWnoi*k);
    
end;

disp(size(sLp));
sound(sLp, Fs);
plot(sLp);
%axis([44000,44100,-1,1]);

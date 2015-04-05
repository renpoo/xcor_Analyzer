close all; 
clear;


Fs = 44100;        % Sampling Rate
T = 1/Fs;          % Sample time
Len = 256;         % Window Size
sec = 0.5;           % Unit Time of Sinnal
t1 = (1:Fs*sec*1)*T;  % Time vector 1
t2 = (Fs*sec*1+1:Fs*sec*2)*T;  % Time vector 2
t3 = (Fs*sec*2+1:Fs*sec*3)*T;  % Time vector 3


% 3̎gg𐶐
s1 = sin(2*pi*441*t1);
%plot(t1,s1);
s2 = sin(2*pi*442*t2);
%plot(t2,s2);
s3 = sin(2*pi*443*t3);
%plot(t3,s3);


% s1s2̋Ë
%plot(t1,s1,t2,s2);
%axis([0.495,0.505,-1,1]);

% s2s3̋Ë
%plot(t2,s2,t3,s3);
%axis([0.99,1.01,-1,1]);

% s1s2s3𐅕
%s0 = horzcat(s1, s2, s3);
%t0 = horzcat(t1, t2, t3);
%plot(t0,s0);
%axis([0.48,0.52,-1,1]);
%axis([0.98,1.02,-1,1]);
%sound(s0, Fs);


% s1s2ڑs1̍ŏI[1gȓŕ␳
%y = 10000007600*power((t1-0.499897),3)+16869300*power((t1-0.499897),2)+5440*(t1-0.499897)-0.5;
%plot(t1,s1,t2,s2,t1,y);
%axis([0.495,0.505,-1,1]);

for k = 1:Fs*sec*1,
    if (and(t1(k)>0.4987, t1(k)<0.50)),
        s4(k) = 10000007600*power((t1(k)-0.499897),3)+16869300*power((t1(k)-0.499897),2)+5440*(t1(k)-0.499897)-0.5;
        %disp(s4(k));
    else
        s4(k) = sin(2*pi*441*t1(k));
    end;
end;

% s2s3͊lƋX炩ɐڑĂ邽ߐڑȂ


% ŏI[␳ς݂s1=s4s2̋Ë
%plot(t1,s4,t2,s2);
%axis([0.495,0.505,-1,1]);

% ŏI[␳ς݂s1=s4ƁAs2s3𐅕
s0 = horzcat(s4, s2, s3);
t0 = horzcat(t1, t2, t3);
plot(t0,s0);
axis([0.497,0.503,-1,1]);
%axis([0.98,1.02,-1,1]);
sound(s0, Fs);

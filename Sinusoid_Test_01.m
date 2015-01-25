% Generating Sinusoid by connecting two sine waves with cubic curve

close all; 
clear;

t = 0.0;

fs = 44100;        % Sampling Rate
tUnit = 1.0 / fs;  % Sample Time
window_size = 256; % Window Size
dur = 0.5;         % duration of Sine Wave generated (s)
N = fs * dur * 1;  % Number of time length for Cycle Time

A1 = 1.0;
A2 = 0.8;
frq1 = 200; % (Hz)
frq2 = 203; % (Hz)
theta1 = 0; % (radian)
theta2 = +pi/6; % (radian)
ts = 1.0 - tUnit * 10; % (s)
te = 1.0 + tUnit * 10; % (s)

ts1 = 0.0;
te1 = ts1 + dur - tUnit;
ts2 = dur;
te2 = ts2 + dur - tUnit;


[ s1, tVec1 ] = generateSinWave_(A1, frq1, fs, ts1, te1, theta1);
[ s2, tVec2 ] = generateSinWave_(A2, frq2, fs, ts2, te2, theta2);

sound(s1, fs);
pause;
sound(s2, fs);
pause;

[ ds1dt, tVec1dt ] = generateSinWave_(A1, frq1, fs, ts1, te1, theta1+pi/2);
[ ds2dt, tVec2dt ] = generateSinWave_(A2, frq2, fs, ts2, te2, theta2+pi/2);

ds1dt = ds1dt;
ds2dt = ds2dt;

sound(ds1dt, fs);
pause;
sound(ds2dt, fs);
pause;

%return;


tsN = ceil(ts*N)+1; % (samples)
teN = ceil(te*N)+1; % (samples)


F1 = s1(tsN);
F2 = s2(teN-N);

D1 = ds1dt(tsN);
D2 = ds2dt(teN-N);

[ a3, a2, a1, a0 ] = calc_cubicCoefficientsForInterp_( ts, te, F1, F2, D1, D2 );

delta  = te - ts;
deltaN = teN - tsN;

tVec3 = (tsN:teN)*delta;

%s3 = zeros( teN-tsN+1, 1 );
%s3 = cubicFunc_( tVec3, a3, a2, a1, a0 );

%sound(s3, fs);

compS123 = vertcat(s1,s2);

%sound( compS123, fs );

width = 0.03;
sAll = compS123;
tAll = ( 1:2*N-2 )'/fs/dur;

%plot(tAll,sAll);
%axis([ ts-width, te+width, -2, 2 ]);


%return;


for t = ts : 1/deltaN : te,
  compS123(ceil((ts+t)*N)) = cubicFunc_( t, a3, a2, a1, a0 );
end;

sound( compS123, fs );


sAll = compS123;
plot(tAll,sAll);
axis([ ts-width, te+width, -2, 2 ]);

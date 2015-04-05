% ACF and IACF Factor Calculation for violin sound

close all; 
clear;


pkg load signal;
pkg load io;
#pkg load java;


% Definition of parameter
int=2.0;                    % Integration interval [s]
int=0.1;

rs=0.5;                     % Running step [s]
rs=0.05;

gainL=125.1; gainR=129.6;	% gain for Laeq (dB) dummyhead AIST 2010/12/20
gainL=100.0; gainR=100.0;


if (0),
  % Read Sound Data
  [fname,pname] = uigetfile('*.wav','WAVE DATA');
  filename = strcat( pname, "/", fname );
  [x,Fs,Bits] = wavread(filename);
  y = x(1:50000,:);
endif;


if (1),
  % Read Sound Data
  [yl,Fs,Bits] = wavread('/Users/renpoo/Projects/ITOKEN.proj.1/Sounds/TestSinusoid_400Hz.wav');
  [yr,Fs,Bits] = wavread('/Users/renpoo/Projects/ITOKEN.proj.1/Sounds/TestSinusoid_400Hz_15deg.wav');
  filename = '/Users/renpoo/Projects/ITOKEN.proj.1/Sounds/TestSinusoid_400Hz.wav';
  y(:,1) = yl;
  y(:,2) = yr;
endif;


% Functions Running ACF/IACF
res=fun_runACFIACF_violin(y,Fs,int,rs,gainL,gainR,filename);

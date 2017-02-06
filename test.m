clear;

%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%%
timeS0 = 0.0;
%timeE0 = 2.0;
%timeE0 = 10.0;
%timeE0 = 20.0;
timeE0 = 30.0;

%tau = 0.001;
tau = 0.01;
%tau = 0.1;
%tau = 1.0;

unitScale = 1000;


wavFilename = 'Nippon.m4a';


%LRflag = 'L';
%LRflag = 'R';
LRflag = 'C';



results = Laplace_Analyzer( wavFilename, timeS0, timeE0, tau, unitScale, LRflag );


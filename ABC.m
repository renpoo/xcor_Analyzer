close all; 
clear;

s1 = soundGeneratedSinusoid_(210, 44100, 0.1, 0);
s2 = soundGeneratedSinusoid_(220, 44100, 0.1, 14);
s3 = soundGeneratedSinusoid_(230, 44100, 0.1, 23);

s = vertcat(s1,s2,s3);
c = (1:length(s))';
#c = c/(240-200);

sound(s.*c, 44100);

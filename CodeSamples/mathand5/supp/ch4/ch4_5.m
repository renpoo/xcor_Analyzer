clear all;close all
[numd,dend]=c2dm(1,[2,1],0.01);
sim('ch4_5_1');
plot(tout,simout)


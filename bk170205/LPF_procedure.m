
Fnorm = 75/(fs/2);
df = designfilt('lowpassfir','FilterOrder',70,'CutoffFrequency',Fnorm);
grpdelay(df,2048,fs)
D = mean(grpdelay(df))

yL = filter(df,[tauE_Vec_L'; zeros(D,1)]);
yR = filter(df,[tauE_Vec_R'; zeros(D,1)]);

tmp = yL - yR;
figure;plot(yL)
figure;plot(yR)
figure;plot(tmp)

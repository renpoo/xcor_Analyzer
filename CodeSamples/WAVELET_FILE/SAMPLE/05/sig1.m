% �T���v���M���Ƃ��̃X�y�N�g�����̕\��
t=0:0.001:0.512;				% �T���v�����O����0.001
y=sin(2*pi*50*t)+0.5*sin(2*pi*400*t); 	% 50Hz�̐M��,400Hz�̐M��

figure(1);
subplot(2,1,1)
plot(y(1:512))				// 
axis([0, 512, -1.5,  1.5]);
title(" Original Signal");
xlabel("samples NO.")
%% FFT�̌��ʂ̕\��
Y=fft(y,512);			%% 512�t�[���G�ϊ��ɂ����g���̈�ɕϊ�
Pyy=Y.*conj(Y)/512;		%% �X�y�N�g�����x
f=1000*(0:511)/512;
subplot(2,1,2)
plot(f,Pyy(1:512))
title(" spectrum   f1=50Hz, noise=400Hz")
xlabel("(Hz)")
%%

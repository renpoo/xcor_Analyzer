// �����̓ǌo
// ���ۂ̉��A�ǌo�̐��A�����̏���
clf;
y=loadwave("kane1.wav");    // wav�`���̃f�[�^�����[�h����B
figure();
subplot(2,1,1)
plot(y(1:8192*8))    // ���̐M��
xgrid(1);
title(" Original Signal");

Y=fft(y); 			// �t�[���G�ϊ��ɂ����g���̈�ɕϊ�
Pyy=Y.*conj(Y)/512;		// �X�y�N�g�����x
f=1000*(0:511)/512;

subplot(2,1,2)
plot(f,Pyy(1:512))
title(" spectrum")
xlabel("(Hz)")
xgrid(1);

// �����̓ǌo
// ���ۂ̉��A�ǌo�̐��A�����̏���
clf;
stacksize('max');		// �������[�̈�̊m��
y=loadwave("kane1.wav");	// wav�`���̃f�[�^�����[�h����B
figure();
subplot(2,1,1)
plot(y(1:8192*8))		// ���̐M���̕\��
xgrid(1);
title(" Original Signal");
Y=fft(y);			// �t�[���G�ϊ��ɂ����g���̈�ɕϊ�
Pyy=Y.*conj(Y)/512;		// �X�y�N�g�����xconj�|���f����
f=1000*(0:511)/512;
subplot(2,1,2)
plot(f,Pyy(1:512));		// �X�y�N�g�����̕\��
title(" spectrum")
xlabel("(Hz)")
xgrid(1);
figure(1);
//----------------------- dwt �ϊ� ------------------------------------------
// �E�F�[�u���b�g�֐�
wname='db2';
[ca1 cd1] = dwt(y(1:2048),wname);
// �E�F�[�u���b�g�ϊ��̌��ʂ̕\��
subplot(2,1,2)
plot(cd1);
xgrid(1);
subplot(2,1,1)
plot(ca1);
xgrid(1);
title('���U�E�F�[�u���b�g�ϊ��@�ߎ��W���@�ڍ׌W��');

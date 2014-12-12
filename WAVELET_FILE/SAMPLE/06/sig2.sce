// �T���v���M���̃X�y�N�g�����\���Ɨ��U�E�F�[�u���b�g�ϊ��̌���
clf;
t=0:0.001:0.512; // �T���v�����O���g��1000Hz
y=sin(2*%pi*50*t)+0.5*sin(2*%pi*400*t);		// 50Hz��,400Hz�̐M��
figure(1);
subplot(2,1,1)
plot(y(1:512))					// �M���̕\��
xgrid(1)
title(" Original Signal");
// 
// FFT�\��
Y=fft(y);					// 512�t�[���G�ϊ��ɂ����g���̈�ɕϊ�
Pyy=Y.*conj(Y)/512;				// �X�y�N�g��
f=1000*(0:511)/512;
subplot(2,1,2)
plot(f,Pyy(1:512))
title(" spectrum   f1=50Hz, noise=400Hz")
xlabel("(Hz)")
xgrid(1)
//------------------------------------------
// �E�F�[�u���b�g�֐��̒l
p = [0.482962913145 0.836516303738 0.224143868042 -0.129409522551];
sup=length(p); // ����̒���
q = - ( (-1).^(1:sup) ).*p(sup:-1:1);
//
g = p;
h = q;
ss=y(1:512);					// Origial signal�̔z�񂩂�ꕔ�R�s�[
[ca1,cd1]  = dwt(ss, g, h);			// ���U�E�F�[�u���b�g�ϊ������s
figure(2);
subplot(2,1,2)
plot(cd1);					// �ߎ��W���̕\��
xgrid(1)
subplot(2,1,1)
plot(ca1);					// �ڍ׌W���̕\��
xgrid(1)
title('���U�E�F�[�u���b�g�ϊ��@�ߎ��W���Əڍ׌W��');

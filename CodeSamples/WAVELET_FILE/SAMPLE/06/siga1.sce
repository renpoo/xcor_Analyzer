// �Q�̐M���̃X�y�N�g�����̕\��
// ���̗�ł� 50Hz�̐M�����ω����܂��B
clf;
clear
t=0:0.001:0.512;				// �T���v�����O�����@0.001
ts=1:0.003:2.536;				// �h�炬�̎���
y=sin(2*%pi*50*t.*ts)+0.2*sin(2*%pi*400*t);	// ���g�����ϓ�����50Hz�̐M����,400Hz�̐M��
figure(1);
subplot(2,1,1)
plot(y(1:512))					// ���̐M��
xgrid(1);
title(" Original Signal");
Y=fft(y); 					// 512�t�[���G�ϊ��ɂ����g���̈�ɕϊ�
Pyy=Y.*conj(Y)/512;				// �X�y�N�g�����xconj�|���f����
f=1000*(0:511)/512;

subplot(2,1,2)
plot(f,Pyy(1:512))
title(" spectrum")
xlabel("(Hz)")
xgrid(1);
figure(2);
//------------------------------------------
// �E�F�[�u���b�g�֐�
p = [0.482962913145 0.836516303738 0.224143868042 -0.129409522551];
sup=length(p);
q = - ( (-1).^(1:sup) ).*p(sup:-1:1);
g = p;
h = q;
[ca1 cd1] = dwt(y, g, h);
// �E�F�[�u���b�g�ϊ��̌��ʂ̕\��
subplot(2,1,2)
plot(cd1);
xgrid(1);
subplot(2,1,1)
plot(ca1);
xgrid(1);
title('���U�E�F�[�u���b�g�ϊ��@�ߎ��W���@�ڍ׌W��');

// �Q�̐M���̃X�y�N�g�����\��
// ���̗�ł� 50Hz�̐M�����ω����܂��B
clf;
clear
stacksize('max');
t=0:0.001:0.512;				// �T���v�����O�����@0.001
ts=1:0.003:2.536;				// �h�炬�̐M��
y=sin(2*%pi*50*t.*ts)+0.2*sin(2*%pi*400*t); 	// 50Hz�̐M��,400Hz�̐M���̍���
figure(1);
subplot(2,1,1)
plot(y(1:512))					// ���̐M��
xgrid(1);
title(" Original Signal");
Y=fft(y); 					// 512�t�[���G�ϊ��ɂ����g���̈�ɕϊ�
Pyy=Y.*conj(Y)/512;				// �X�y�N�g��
f=1000*(0:511)/512;
subplot(2,1,2)
plot(f,Pyy(1:512));				// �X�y�N�g���̕\��
title(" spectrum")
xlabel("(Hz)")
xgrid(1);
figure(2);
// cwt �ϊ� ------------------------------------------
scale=[1:128]				// scale factor
coef=cwt(y,scale,'gaus5');		//  cwt�ϊ�
surf(coef);				//  surf   3D�\�����s���܂��B
xgrid(1);
xtitle('cwt�ϊ���3D�\��');
//
cwtplot(coef,scale);			// cwt�̌��ʂ� 2D �\��
xtitle('cwt�ϊ��̌W��');

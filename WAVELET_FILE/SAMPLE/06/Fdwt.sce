//�@N ���C���[ dwt�ϊ��ɂ�镪�̓v���O����
clc;					// �R���\�[�����N���A�[����B
clf;					// �摜�N���A�[
stacksize('max');			// �X�^�b�N���m��
// �ȉ��̕��������������邱�ƂŐM����ύX���ď������ϑ��ł��܂��B
//s=[1:2048];                		// �T���v�����@
//signal = sin(2*%pi*s/100)+sin(10*%pi*s/100);     //�@��{�̐����g���쐬���܂�
signal=5*sin(20.*linspace(0,%pi,1000))+rand(1,1000);    // 1000�|�C���g
//
disp('�f�[�^�T�C�Y=',length(signal));
waven=input('�g�p����E�F�[�u���b�g�́H�F','s');
//
N=input('�������x���H�F');				// �������x���̐�����͂���B
start=input('�ŏ��̃T���v���|�C���g�H�F');		// �ŏ��̃T���v���|�C���g�B
last=input('�Ō�̃T���v���|�C���g�H�F');		// �Ō�̃T���v���|�C���g�B
[C,L]=wavedec(signal,N,waven);
// �M���̃v���b�g 
subplot(311), plot(signal); 
a=gca();a.data_bounds=[1 length(signal) -10 10];
xgrid(1);
title('���̐M��'); 
// N���x���̋ߎ��W���A�������x��N
A=appcoef(C,L,waven,N);
subplot(312), plot(A), a=gca();a.data_bounds=[start last -10 10];        // ��ʂ̍\��
title('�ߎ��W��');
xgrid(1);
// N���x���̏ڍ׌W���A�������x��N
D = wrcoef('d',C,L,waven,N);
subplot(313), plot(D), a=gca();a.data_bounds=[start last -1.0 1.0]; 
title('�ڍ׌W��');
xgrid(1);
//

//�@cwt�ϊ��ɂ�镪�̓v���O����
clc;					// �R���\�[�����N���A�[����B
clf;					// �摜�N���A�[
stacksize('max');			// �X�^�b�N���m��
// �[���M���@�����g�{�����_���m�C�Y
signal=5*sin(20.*linspace(0,%pi,1000))+rand(1,1000);	// 1000�|�C���g
//
disp('�f�[�^�T�C�Y=',length(signal));
waven=input('�g�p����E�F�[�u���b�g�́H�F','s');
//
numb=input('�X�P�[���H�F');				// �������x���̐�����͂���B
start=input('�ŏ��̃T���v���|�C���g�H�F');		// �ŏ��̃T���v���|�C���g�B
last=input('�Ō�̃T���v���|�C���g�H�F');		// �Ō�̃T���v���|�C���g�B
bitt=input('�Ԉ������H�F');				// �Ԉ����T���v���|�C���g�B
//
scale=1:numb;				//�@�X�P�[���̐ݒ�
// continous wavelet transform
coef=cwt(signal(start:bitt:last),scale,waven);		// cwt�ϊ�
surf(coef);						// 3D�\��
xgrid(1);
title('cwt�ϊ���3D�\�� �\ �G�����܂񂾐����g');
//
cwtplot(coef,scale);					//�W���̕\��
title('cwt�ϊ��̌W�� �\ �G�����܂񂾐����g');
//
title('�g�p�����E�F�[�u���b�g�� '+waven);
//

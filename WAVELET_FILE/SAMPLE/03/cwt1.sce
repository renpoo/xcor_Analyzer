//
// �����g�Ƀ����_���m�C�Y���d�􂳂ꂽ�M����cwt�ϊ�
clf;
//
lines(0);clc; 
//        �M���쐬
y=sin(20.*linspace(0,%pi,1000))+0.2*rand(1,1000);	// �����g�{�G���̐M��
// �T���v���|�C���g�@1000�|�C���g
//  �������[�T�C�Y�̊m��
stacksize(10000000);
//       �A���E�F�[�u���b�g�ϊ�
coef=cwt(y,1:128,'DOG');			// cwt�ϊ�
surf(coef);					// 3D�\��
xgrid(1);
xtitle('cwt�ϊ���3D�\�� �\�\ �G�����܂񂾐����g');
//
cwtplot(coef,1:128);				//�@�E�F�[�u���b�g�W���̃v���b�g
xtitle('cwt�ϊ��̌W�� �\�\ �G�����܂񂾐����g');
//

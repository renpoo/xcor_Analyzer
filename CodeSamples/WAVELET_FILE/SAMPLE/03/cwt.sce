//
// 2�̎��g���̐����g�̍������ꂽ�M����cwt�ϊ�
clf;		// �O���t��ʂ̃N���A�[
clc;		// �R���\�[���̃N���A�[
//        �M���쐬
s=[1:1000];					// �T���v���|�C���g��
y = sin(2*%pi*s/100)+sin(0.5*%pi*s/100); 	// �A�������M���A2�̐����g�̍���
stacksize('max'); 				// �������[�̊m��
//        �A���E�F�[�u���b�g�ϊ�
coef=cwt(y,1:128,'gaus5');			//  cwt�ϊ��@�X�P�[���@1:128
surf(coef);					//  surf   3D�\�����s���܂��B
xgrid(1);
xtitle('cwt�ϊ���3D�\��');
//
cwtplot(coef,1:128);				// �E�F�[�u���b�g�W���̃v���b�g
xtitle('cwt�ϊ��̌W��');
//

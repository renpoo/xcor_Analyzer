//�@cwt�ϊ��ɂ�镪�̓v���O����
clc;            // �R���\�[�����N���A�[����B
clf;            // �摜�N���A�[
stacksize('max');    // �X�^�b�N���m��
// �t�@�C�������R���\�[��������́B�t�@�C���� wave �`���̂݁B
filename=input('�g�p����t�@�C�����́H�F','s');
//�@���̕�����SCILAB�Ɍ��肳���L�q�ł��B
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
//
signal=loadwave(filename);			// wav�`���̃f�[�^�����[�h����B
disp('�f�[�^�T�C�Y=',length(signal));		// �t�@�C���̑傫����\��
//
waven=input('�g�p����E�F�[�u���b�g�́H�F','s');
//
numb=input('�X�P�[���H�F');			// �������x���̐�����͂���B
start=input('�ŏ��̃T���v���|�C���g�H�F');	// �ŏ��̃T���v���|�C���g�B
last=input('�Ō�̃T���v���|�C���g�H�F');	// �Ō�̃T���v���|�C���g�B
bitt=input('�Ԉ������H�F');			// �Ō�̃T���v���|�C���g�B
//
scale=1:numb;
// �A���E�F�[�u���b�g�ϊ�
coef=cwt(signal(start:bitt:last),scale,waven);		// cwt�ϊ�
surf(coef);						// 3D�\��
xgrid(1);
title('�E�G�u���b�g�W�� ');
//
cwtplot(coef,scale);	// �W���̕\��
//
title('cwt�ϊ��@�g�p�����E�F�[�u���b�g�� '+waven);
//

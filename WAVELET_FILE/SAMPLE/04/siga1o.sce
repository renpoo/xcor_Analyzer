// �������̑��ۂ̉�
// �E�F�[�u���b�g�ϊ��ƍč\��
clf;
stacksize('max');
y=loadwave("kane1.wav");    // wav�`���̃f�[�^�����[�h����B
//
subplot(2,1,1)
plot(y(1:8192*8))    // ���̐M��
xgrid(1);
title(" ���̐M��");
subplot(2,1,2)
title('�t�ϊ��̌���');
//------------------------------------------
// dwt �ϊ� --------------------- �E�F�[�u���b�g�֐�
wname='db2';
[ca1 cd1] = dwt(y(1:8192),wname);
// �t�ϊ����s���܂��B
ss = idwt(ca1,cd1,wname);    // �t�E�F�[�u���b�g�ω����s���܂��B
//
subplot(2,1,2)
plot(ss);			// �t�ϊ����ꂽ�M����\�����܂��B
title('�t�ϊ��̌���');
xgrid(1);
// �����Đ����Ă݂܂��B
playsnd(ss);

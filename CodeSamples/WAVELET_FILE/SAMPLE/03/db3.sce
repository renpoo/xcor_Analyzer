//�@cwt�ϊ��ɂ��t�B���^�[�̉e���̒���
clc;
stacksize('max');
xset('window',0);clf(0);
waven=input('�g�p����E�F�[�u���b�g�́H�F','s');
noise = wnoise(5,9);			// �G���̍쐬
//
nsample = 0.1*noise;			// �G��
plot2d(nsample);
xgrid(1);
title('���M���̔g�`');
xset('window',1);clf(1);
// dwt�ϊ�
coef=cwt(nsample,1:128,waven);		// cwt�ϊ��A�E�F�[�u���b�g�W��
surf(coef);				//
xgrid(1);
TITLES='�E�F�[�u���b�g�֐� '+waven+' �� cwt';
title(TITLES);
//

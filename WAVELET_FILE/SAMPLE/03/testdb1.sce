//�@dwt�ϊ��ɂ��t�B���^�[�̉e���̒���
clc;			// �R���\�[�����N���A�[����B
stacksize('max');
xset('window',0);clf(0);
waven=input('�g�p����E�F�[�u���b�g�́H�F','s');
//
noise = wnoise(5,9);		// �G���̍쐬
//
nsample = 0.1*noise;		// �G��
plot2d(nsample);
xgrid(1);
title('���M���̔g�`');
xset('window',1);clf(1);
// dwt�ϊ�
[cA,cD]=dwt(nsample,waven);
xsetech([0,0.5,1,0.45]);
plot(cA);			// �ߎ��W��
xgrid(1);
title('�ߎ��W��');
xsetech([0,0,1,0.45]);
plot(cD);			// �ڍ׌W��
xgrid(1);
TITLES='�E�F�[�u���b�g�֐� '+waven+' �̏ڍ׌W��';
title(TITLES);
//

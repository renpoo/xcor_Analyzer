//wavedec �ƎG������
clf;
mode(-1);
// �����_���̏����l
snr =3; init = 31456615866;
// �G���̍쐬 
[xref,x] = wnoise(4,12,snr,init);
//  �G�������̃X���b�V���z�[���h�B�\�t�g�X���b�V���z�[���h�w��
level =6;
xd = wden(x,'heursure','s','one',level,'sym8');
//
subplot(311), plot(x), a=gca();a.data_bounds=[1 2048 -10 10];
title(['�m�C�Y ratio = ',... string(fix(snr))]); 
subplot(312), plot(xd), a=gca();a.data_bounds=[1 2048 -10 10];
TITLES={'�X���b�V���z�[���h���x��',..string(fix(level))};
title(TITLES);
// �G���폜�@�\�t�g�A�X���b�V���z�[���h���x�� = level 2
level =2;
xd = wden(x,'heursure','s','one',level,'sym8');
//
subplot(313), plot(xd), a=gca();a.data_bounds=[1 2048 -10 10];
TITLES={'�X���b�V���z�[���h���x��',..string(fix(level))};
title(TITLES);
//

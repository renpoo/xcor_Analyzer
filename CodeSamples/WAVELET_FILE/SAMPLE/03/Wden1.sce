// wden �̎G������
clf;
mode(-1);
lines(0);
// �����_���G���̏����l
snr = 3; init = 31456615866;
// �G���̍쐬 .xref�͍쐬���ꂽ�M���Ax�̓m�C�Y���܂񂾐M��
[xref,x] = wnoise(4,12,snr,init);
//  �G�������̃X���b�V���z�[���h
level = 4;
// �m�C�Y�������
xd = wden(x,'heursure','s','one',level,'sym8');
// �M���̃v���b�g 
subplot(311), plot(xref); 
a=gca();a.data_bounds=[1 2048 -10 10];
title('���̐M��'); 
subplot(312), plot(x), a=gca();a.data_bounds=[1 2048 -10 10];		// ��ʂ̍\��
title(['�m�C�Y ratio = ',... 
string(fix(snr))]); 
subplot(313), plot(xd), a=gca();a.data_bounds=[1 2048 -10 10];
title('�G��������'); 
// �G���폜�@�\�t�g�A�X���b�V���z�[���h���x�� = level
xd = wden(x,'heursure','s','one',level,'sym8');

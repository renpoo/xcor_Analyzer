// �����g�ƃ����_���m�C�Y
scf();
clf
// �����_���̏����l
snr =3; init = 31456615866;
// �G���̍쐬 
[xref,x] = wnoise(4,12,snr,init);
//
thr=35;
// ���k�@�X���b�V���z�[���h�l���g�p�i��L�j ���x���S�A�n�[�h�X���b�V���z�[���h�ɂ��܂�
[xcomp,cxd,lxd,perf0,perfl2] = wdencmp('gbl',x,'db3',4,thr,'h',1);
// �O���[�o���l�̃X���b�V���z�[���h��
// thr  =  15.62813
[thr,sorh,keepapp] = ddencmp('den','wv',x);
// ��L�̃X���b�V���z�[���h�l�ɂ��m�C�Y�����B�\�t�g�X���b�V���z�[���h
xd = wdencmp('gbl',x,'db3',4,thr,sorh,keepapp);
//
plot(x);
plot(xcomp,'r');	// ���k�f�[�^
//plot(xd,'r')		// �G�����������鎞�̓R�����g���͂���
plot(xref,'g');		// ���̐M��
legend(["noisy signal","compressed signal","original ref,signal"],1);
xgrid(1);            
 title('�G���t���M���̈��k');

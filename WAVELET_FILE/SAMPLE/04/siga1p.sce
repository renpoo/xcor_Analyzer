// �������̑��ۂ̉�
// �E�F�[�u���b�g�ϊ��Ńm�C�Y�폜
clf;
stacksize('max');
y=loadwave("kane1.wav");		// wav�`���̃f�[�^�����[�h����B
//
subplot(211)
plot(y(1:8192*4))			// ���̐M��
xgrid(1);
title(" ���̐M��");
//
level=6;		// �����Ӂ��X���b�V���z�[���h���x����6�𒴂���Ɣg�`�ɂЂ��݂�������
xd = wden(y(1:8192*4),'rigrsure','s','one',level,'db2');
// �Q�̃X�y�N�g�����̕\��
subplot(212)
plot(xd);				//�G��������̐M����\�����܂��B
xgrid(1);
figure(1);
subplot(121)				// ���ɕ\��
analyze(y(1:8192*4),10,500);
title('�ϊ��O�̃X�y�N�g����');
xlabel('���g�� Hz');
xgrid(1);
//
subplot(122)				// ���ɕ\��
analyze(xd(1:8192*4),10,500);
xlabel('���g�� Hz');
title('�t�ϊ���̃X�y�N�g����');
xgrid(1);
//

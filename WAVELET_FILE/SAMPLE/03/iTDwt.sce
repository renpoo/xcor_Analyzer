//�@�t���U�E�F�[�u���b�g�ϊ��̎��{
clf;
 x=linspace(-%pi,%pi,10000);	// �T���v�����O�|�C���g��10000 �˃T���v�����O���[�g�̋t��
 s=sin(x);			// �f�[�^�̐����g�̍쐬
 [ca1,cd1] = dwt(s,'haar');	// ���U�E�F�[�u���b�g�ϊ����s���܂��B
// �t�ϊ����s���܂��B.
ss = idwt(ca1,cd1,'haar');	// �t�E�F�[�u���b�g�ω����s���܂��B
//
plot(ss);			// �t�ϊ����ꂽ�M����\�����܂��B
xtitle('�t�ϊ��̌���');

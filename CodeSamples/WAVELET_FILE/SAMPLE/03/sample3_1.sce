// 
clf;
 x=linspace(-%pi,%pi,10000);	// �M���͈̔͂ƃT���v���|�C���g
 s=sin(x);			// �^����ꂽ�M���B�����g
 [ca1,cd1] = dwt(s,'haar');		// �E�F�[�u���b�g�ϊ��B�E�F�[�u���b�g�֐�����haar���g�p�B 
// .
xsetech([0,0.5,1,0.45]);
plot(cd1);			// �ڍ׌W���̕\��
xgrid(1);
xsetech([0,0,1,0.45]);
plot(ca1);			// �ߎ��W���̕\��
xgrid(1);

clf;
 x=linspace(-%pi,%pi,10000);	// �T���v���f�[�^ 10000�|�C���g
 s=sin(x); 			// �����g�̐M���f�[�^���쐬���܂��B
 [ca1,cd1] = dwt(s,'db2');	// �E�F�[�u���b�g�֐���db2���g�p
xsetech([0,0.5,1,0.45]) 
plot(cd1);
xgrid(1);				// �ڐ���
xsetech([0,0,1,0.45]);
plot(ca1);
xgrid(1);

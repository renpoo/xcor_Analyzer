//�@2�����E�F�[�u���b�g�ϊ�
clf;
x=rand(200,200);			// ����
[C,S]=wavedec2(x,3,'db2');		// ���x��3�ŃE�F�[�u���b�g�ϊ�
//
coff=appcoef2(C,S,'db2',3);		// ���x��3�̋ߎ��W��
surf(coff);				//  surf ��3D�\�����s���܂��B
xgrid(1);
title('�����_���m�C�Y�̕ϊ�');

// �G������
clf;
s=sin(20.*linspace(0,%pi,1000))+0.2*rand(1,1000);	//  �M��
figure(1)
plot(s)			// �G�����d�􂵂��M��
xgrid(1);
//
figure(2);
[cA,cD]=dwt(s,'haar');	// ���U�E�F�[�u���b�g�ϊ�
xsetech([0,0.5,1,0.45]);
plot(cA);			// �ߎ��W��
xgrid(1);
xsetech([0,0,1,0.45]);
plot(cD);			// �ڍ׌W��
xgrid(1);

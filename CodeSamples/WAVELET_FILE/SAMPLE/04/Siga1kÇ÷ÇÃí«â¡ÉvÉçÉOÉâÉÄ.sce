//------------------------------------------
// cwt �ϊ� ------------------------------------------
scale=[1:512];				// �X�P�[��
coef=cwt(y(1:512),scale,'gaus5');	//  cwt�ϊ�
surf(coef);				//  surf   3D�\�����s���܂��B
xgrid(1);
xtitle('cwt�ϊ���3D�\��');
xlabel('���/����');
ylabel('�X�P�[��');
figure(2);
//
cwtplot(coef,scale);			// �E�F�[�u���b�g�W���̃v���b�g
xtitle('cwt�ϊ��̌W��');

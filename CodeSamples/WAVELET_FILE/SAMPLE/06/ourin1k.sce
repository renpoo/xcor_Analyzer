// �ނ̃X�y�N�g�����̕\��
// �T���v���P
clf;
stacksize('max');
y=loadwave("ourin1.wav");	// wav�`���̃f�[�^�����[�h����B
//------------------------------------------
// cwt �ϊ� ------------------------------------------
scale=[1:32]
coef=cwt(y(1:8192*0.5),scale,'gaus5');	//  cwt�ϊ�
surf(coef);				//  surf   3D�\�����s���܂��B
xgrid(1);
xtitle('cwt�ϊ���3D�\��');
xlabel('���/����');
ylabel('�X�P�[��');
figure(1);
cwtplot(coef,scale);	// cwt�̃v���b�g
xtitle('cwt�ϊ��̌W��');

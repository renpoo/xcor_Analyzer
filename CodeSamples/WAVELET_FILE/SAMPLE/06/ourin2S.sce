// �ނ̉��̉��
// �T���v���P
clf;
stacksize('max');
[y,Fs]=loadwave("ourin2.wav");		// wav�`���̃f�[�^�����[�h����B
// Fs�ɂ̓t�@�C������f�[�^�̏�񂪂���܂��B3�Ԗڂ��T���v�����[�g�ł��B
size_w=length(y);			// �f�[�^�̐��̑傫��
FS=Fs(3);				// �����^�����̃T���v�����O���g��
//
xset('window',0);
plot(y(1:size_w))			// ���̐M��
xgrid(1);
title(" �ނ̉� ");
xset('window',1);
//-------------------------------------
// dwt �ϊ� ------------------------------------------
[cA,cD]=dwt(y(1:size_w),'haar');	// ���U�E�F�[�u���b�g�ϊ�
xsetech([0,0.5,1,0.45]); 
plot(cA);				//�@�͈͂𐧌����g�`�����₷������B
title('�ߎ��W��');
xgrid(1);
xsetech([0,0,1,0.45]);
plot(cD);
title('�ڍ׌W��');
xgrid(1);
//
xset('window',2);
//------------------------------------------
// cwt �ϊ� ------------------------------------------
scale=[1:128];        // �X�P�[��
// cwt �ϊ����s���Ƃ��̃T���v�����O���ꂽ�f�[�^�̊Ԉ����������Ȃ��B
MULT=8192;	// �Ԉ������s��
coef=cwt(y(1:MULT:size_w),scale,'gaus5');	//  cwt�ϊ�
surf(coef);					//  surf   3D�\�����s���܂��B
xgrid(1);
xtitle('cwt�ϊ���3D�\��');
xlabel('����');
ylabel('�X�P�[��');
xset('window',3);
//
cwtplot(coef,scale);				//�W���̃v���b�g
xtitle('cwt�ϊ��̌W��');

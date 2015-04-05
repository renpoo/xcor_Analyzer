// 1 �����E�F�[�u���b�g�ϊ�
clf;
//�@�܂��P���Ȕg�`���쐬���܂��B
x = 0:4;
 y = zeros(1,5);
  y(3) = 2; 
  t = linspace(0,4,2^9);
sample = interp1(x,y,t);
xset('window',0);
plot2d(sample);				// �쐬�����g�`�̕\��
title('�I���W�i���̔g�`');
xgrid(1);
// �G�����쐬���������܂��B
noise = wnoise(5,9);				// �G���̍쐬
nsample = sample+0.1*noise;			// �G�����d�˂܂��B
xset('window',1);				// ��ڂ̃O���t
plot(nsample)					// �G�����܂񂾐M���̔g�`
xgrid(1);�v
xset('window',2);
// cwt�ϊ����s���A���ʂ�\�����܂��B
c = cwt(sample,1:32,'DOG');		// �X�P�[���t�@�N�^�[�� [1:32] �Ƃ��Ă��܂��B
surf(c);				// cwt�\��
title('cwt�g�` 3D�\��');
xgrid(2);
xset('window',3);
// dwt�ϊ����s���܂��B
[cA1,cD1]=dwt(nsample,'db3');
ls=length(nsample);
A1=upcoef('a',cA1,'db3',1,ls);
D1=upcoef('d',cD1,'db3',1,ls);
// dwt �t�ϊ�
A0=idwt(cA1,cD1,'db2',ls);
xsetech([0,0,1,0.45]);
plot(A0);				// �ߎ��W��
xgrid(1);
xsetech([0,0.5,1,0.45]);
plot(D1);				// �ڍ׌W��
xgrid(1);
title('figure2');
// �����x���̃E�F�[�u���b�g�ϊ��i�R���x���j���s���܂�
[C,L]=wavedec(nsample,3,'db3');		// 3���x���̃E�F�[�u���b�g�ϊ�
cA3=appcoef(C,L,'db3',3);
cD3=detcoef(C,L,3); cD2=detcoef(C,L,2); cD1=detcoef(C,L,1);
//
A3=wrcoef('a',C,L,'db3',3);
D1=wrcoef('d',C,L,'db3',1);
D2=wrcoef('d',C,L,'db3',2);
D3=wrcoef('d',C,L,'db3',3);
xset('window',4);
// �o���オ�����ڍ׌W���Ȃǂ̕\�����s���܂��BMATLAB�̏ꍇ�� xsetetch ���@subplot �ŋL�q���܂��B
xsetech([0,0,1,0.2]);
plot(A3); xgrid(1);
xsetech([0,0.25,1,0.2]);
plot(D1); xgrid(1);
xsetech([0,0.5,1,0.2]);
plot(D2); xgrid(1);
xsetech([0,0.75,1,0.2]);
plot(D3); xgrid(1);
title('figure3');
//

// 
clf;
s=[1:100];				// �f�[�^�̈�̊m�ہB�T���v�����B
a = sin(2*%pi*s/100)+sin(3*%pi*s/100);	// ��{�̐����g���쐬
// �E�F�[�u���b�g�ϊ����s���܂��B3���x���Ɏw��B
[C,L] = wavedec(a,3,'haar');
// 3�̃��x����C����ߎ��W�������߂�B
cA3 = appcoef(C,L,'haar',3);
// C ���烌�x��3, 2,��1 �̏ڍ׌W�������߂�
cD3 = detcoef(C,L,3);
cD2 = detcoef(C,L,2);
cD1 = detcoef(C,L,1);
// ��L�̂R�s�͈ȉ��̗l�ɂ܂Ƃ߂邱�Ƃ��ł��܂��B
//  [cD1,cD2,cD3] = detcoef(C,L,[1,2,3]);
//  C ���烌�x���R�̋ߎ��W�������߂�
A3 = wrcoef('a',C,L,'haar',3);
// C���烌�x��123��details �����߂�
D1 = wrcoef('d',C,L,'haar',1);
D2 = wrcoef('d',C,L,'haar',2);
D3 = wrcoef('d',C,L,'haar',3);
// �o���オ�����W���Ȃǂ̕\�����s���܂��B��̃O���t�ɂS�\�����܂��B
xsetech([0,0,1,0.2]);
plot(A3);
xgrid(1);
xsetech([0,0.25,1,0.2]);
plot(D1);
xgrid(1);
xsetech([0,0.5,1,0.2]);
plot(D2);
xgrid(1);
xsetech([0,0.75,1,0.2]);
plot(D3);
xgrid(1);

//�@�t�ϊ��̎��{
clf;
s=[1:100];				// �T���v�����@�ˁ@100��
a = sin(2*%pi*s/100)+sin(3*%pi*s/100);	//�@��{�̐����g���쐬���܂�
// ���ɃE�F�[�u���b�g�ϊ����s���܂�
[C,L] = wavedec(a,3,'haar');
// level 3 approximation coecients from C,:
cA3 = appcoef(C,L,'haar',3);
//  levels 3, 2, and 1 detail coecients from C
cD3 = detcoef(C,L,3);
cD2 = detcoef(C,L,2);
cD1 = detcoef(C,L,1);
// ��L�̂R�s�͈ȉ��̗l�ɂ܂Ƃ߂邱�Ƃ��ł��܂��B
// [cD1,cD2,cD3] = detcoef(C,L,[1,2,3]);
// �ڍ׌W���̍č\��
D1 = wrcoef('d',C,L,'haar',1);
D2 = wrcoef('d',C,L,'haar',2);
D3 = wrcoef('d',C,L,'haar',3);
// ���Ƃ̐M���ɂ��ǂ����߂ɋt�E�F�[�u���b�g�ϊ����s���܂��B
A = waverec(C,L,'haar');
// ���Ƃ̐M����\�����܂��B
plot(A)

// �G������
clf;
signal=sin(20.*linspace(0,%pi,1000))+0.2*rand(1,1000);    // 1000�|�C���g
//
waven=input('�g�p����E�F�[�u���b�g�́H�F','s')
N=input('�������x���H�F');	// �������x���̐�����͂���B
[C,L]=wavedec(signal,N,waven);
plot(signal),title('Original');
xgrid(1);
figure(1);
//
// 1�����̋ߎ��W���A�������x��N
A=appcoef(C,L,waven,N);
plot(A);
title('�g�p�����E�F�[�u���b�g�� '+waven);
xgrid(1);
//

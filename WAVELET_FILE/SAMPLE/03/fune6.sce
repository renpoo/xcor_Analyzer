// �摜�̗��U�E�F�[�u�E�F�[�u���b�g�ϊ��\��
stacksize('max');
wname='bior3.3'
im=imread("DSC_0188.JPG");
G=rgb2gray(im);			// RGB���O���[�X�P�[����
x=im2double(G);			// �f�[�^��double�ɂ���@�ˁ@�d�v
[CA,CH,CV,CD]=dwt2(x,wname);	// 2�������U�E�F�[�u���b�g�ϊ�
a=CA-min(CA);
a=a/max(a);
imshow(a);

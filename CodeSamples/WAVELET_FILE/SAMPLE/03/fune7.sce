// �K�E�X�m�C�Y�̏d�􂵂��f�[�^��dwt�ϊ����\��
stacksize('max');
wname='bior3.3'
im=imread("DSC_0188.JPG");
imn=imnoise(im,'gaussian');		// �m�C�Y�̕t��
G=rgb2gray(imn);			// RGB���O���[�R�[�h�ɕϊ�
x=im2double(G);				// �f�[�^��double�ɂ���
[CA,CH,CV,CD]=dwt2(x,wname);		// dwt2�̎��s
a=CA-min(CA);
a=a/max(a);
imshow(a);			// �ߎ��W���̕\��

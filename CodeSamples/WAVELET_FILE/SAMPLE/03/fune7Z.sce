// �摜�f�[�^��cwt�ϊ�
//
stacksize('max');
wname='bior3.3'
im=imread("DSC_0188.JPG");
//
imn=imnoise(im,'gaussian');		// �m�C�Y�̕t��
G=rgb2gray(imn);
y=im2double(G);				// �f�[�^��double�ɂ���
size_zu=length(y);			// �f�[�^�̂�������
stacksize('max');
scale=[1:64];			// �X�P�[��
coef=cwt(y(1:4096:size_zu),scale,'gaus5');	// cwt�ϊ�
subplot(121)			// ���ɕ\��
surf(coef);			// 3D�\��
xgrid(1);
xtitle('�m�C�Y������ꍇ');
//
G1=rgb2gray(im);			// RGB ����O���[�X�P�[���֕ϊ�
y1=im2double(G1);			// �f�[�^��double�ɂ���
scale=[1:64];				//  �X�P�[��
coef=cwt(y1(1:4096:size_zu),scale,'gaus5');	// cwt�ϊ�
subplot(122)				// �E�ɕ\��
surf(coef);				// 3D�\��
title('�m�C�Y���Ȃ����')
xgrid(1);

// �摜�̕\��'
stacksize('max');
im=imread("DSC_0188.JPG");
imshow(im); 		// �I���W�i����\�����܂��B
// �q�X�g�O���t�̕\��
im = rgb2gray(im);		// rgb ����O���[�X�P�[���ɕϊ�
[count, cells]=imhist(im);	// 	�q�X�g�O�������쐬����
//
plot(cells,count);		// ������cell�A�c����count�ŕ\��
xlabel('cells');
ylabel('count');
title('�q�X�g�O����');
xgrid(1);
//

// �摜�̕\���ƃq�X�g�O�����̕\��
stacksize('max');
im=imread("DSC_0188.JPG");
disp('�m�C�Y�@speckle �������܂��B')
//
imn=imnoise(im,'speckle');		// �m�C�Y�̎w��
imshow(imn); 
// �q�X�g�O���t�̕\���A�m�C�Y�Ȃ�
im = rgb2gray(imn);
[count, cells]=imhist(im);
//
plot(cells,count);
xlabel('cells');
ylabel('count');
title('�q�X�g�O����');
xgrid(1);
//

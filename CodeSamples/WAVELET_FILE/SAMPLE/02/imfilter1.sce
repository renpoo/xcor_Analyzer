// �摜���t�B���^�����O���ĕ\��
stacksize('max');
im=imread("DSC_0188.JPG");
filter = fspecial('sobel');		// �t�B���^�[�̐ݒ�
imf = imfilter(im, filter);
imshow(imf);

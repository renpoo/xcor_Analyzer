// �摜�̑傫���ύX�ƕ�F�̕\��
stacksize('max');
im=imread("DSC_0188.JPG");
ima=imresize(im,0.5);		// �摜�̑傫���𔼕��ɂ���
imout=imcomplement(ima);	// ��F�̉摜���쐬
imshow(imout);			// �摜�̕\��

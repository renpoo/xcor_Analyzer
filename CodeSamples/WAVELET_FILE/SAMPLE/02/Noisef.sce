// �摜�̃m�C�Y�t���A�摜�t�@�C����320X240�s�N�Z���̑傫��
stacksize('max');
filename =  'people.jpg';
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
im=imread(filename);
imn = imnoise(im, 'gaussian');	// �K�E�V�A���m�C�Y���摜�f�[�^�ɗ^���܂��B
imshow(imn);			// �m�C�Y��������ꂽ�摜�f�[�^��\�����܂��B

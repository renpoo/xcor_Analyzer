// �x�~���[�h�Ŏ��s�B�R���\�[���ň�s���ƂɁu���s�v����͂��܂��B
mode(7)
// �摜�̃m�C�Y�t���A�摜�t�@�C����320X240�s�N�Z���̑傫��
stacksize('max');
filename='/usr/share/scilab/contrib/sivp/images/people.jpg';
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
im = imread(filename);
    imn = imnoise(im, 'gaussian');
    imshow(imn);
// �摜 Gaussian �m�C�Y

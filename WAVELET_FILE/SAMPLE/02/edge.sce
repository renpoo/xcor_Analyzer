// ��̃G�b�W���o�A�摜�t�@�C����320X240�s�N�Z���̑傫��
stacksize('max');
filename =  'F:\SCILAB-DEMO\demos4/image/DSCF0242.jpg';
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
im = imread(filename);
im=imread(filename);
imc=edge(rgb2gray(im),'canny');		// �I���W�i���̉摜�f�[�^����G�b�W���o���s���܂��B
imshow(imc);				// �G�b�W���o����C�����ꂽ�摜��\�����܂��B

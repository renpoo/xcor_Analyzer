stacksize('max');		// �X�^�b�N���\�Ȍ���傫���m�ۂ��܂��B
filename =  'people.jpg';	// �\������摜�t�@�C���̖��̂��p�X�ƂƂ��Ɏw�肵�܂��B
// Windows�̏ꍇ�̓T�u�f�B���N�g�����o�b�N�X���b�V�����Z�p���[�^�ɂȂ邽�߂�OS�̎��ʂ��s���܂��B
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
// �w�肳�ꂽ�摜�t�@�C�����A�t�@�C���n���h�� im �Ɏ󂯎��܂��B
im = imread(filename);
face = detectfaces(im);		// �摜�f�[�^������F����face�Ɋi�[���܂��B
[m,n] = size(face);		// ��̐����m�F���A�f�[�^�ɘg�����܂��B
for i=1:m,
    im = rectangle(im, face(i,:), [0,255,0]); // �g��\�����܂��B�������face�ɑ΂��Ď��{���܂��B
end;
// �g������ꂽ��Ԃŉ摜��\�����܂��B
imshow(im);

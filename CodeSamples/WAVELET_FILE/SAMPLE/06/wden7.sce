// wden �ɂ��G������
clc;
mode(-1);
lines(0);
stacksize('max');	// �X�^�b�N���m��
//
level=input('�X���b�V���z�[���h���x���H�F');	// �X���b�V���z�[���h���x���̐�����͂���B
clf;
filename=input('�g�p����t�@�C�����́H�F','s');
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
//
signal=loadwave(filename);
x=signal(1:100000);
disp('�f�[�^�T�C�Y=',length(signal));
//
xd = wden(x,'heursure','s','one',level,'sym8');
// �M���̃v���b�g 
subplot(211), plot(x); 
a=gca();a.data_bounds=[1 2048 -1.0 1.0];
title('���̐M��'); 
subplot(212), plot(xd), a=gca();a.data_bounds=[1 2048 -1.0 1.0];
TITLES={'�X���b�V���z�[���h���x��',..
string(fix(level))};
title(TITLES);
// �G���폜��̉��̍Đ�
sound(xd)

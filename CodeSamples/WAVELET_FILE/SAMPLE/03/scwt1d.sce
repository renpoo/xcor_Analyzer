//
stacksize('max');
s=[1:800];						// �T���v����
//
freqbrk = sin(2*%pi*s/100)+sin(3*%pi*s/100); 		//��{�̐����g���쐬
scalef=1:1:128;		// �X�P�[���t�@�N�^�[
waven='gaus5';		// �E�F�[�u���b�g�֐���
//
xset('window',0);clf(0);
c=cwt(freqbrk,scalef,waven);				// �A���E�F�[�u���b�g�ϊ�
surf(c);						// �ϊ����ʂ�3D�\��
xgrid(1);
title('�A���E�F�[�u���b�g');
//
xset('window',1);clf(1);
cwtplot(c,scalef);		// �E�F�[�u���b�g�W��
set(gca(),'grid',[1 1]*color('gray'));
xgrid(1);
title("Wavelet Analys")
xlabel('Time')
ylabel('Scale Factor')
//

stacksize('max');
wname='bior3.3'
im=imread("DSC_0188.JPG");		// �G���̂Ȃ����
imn=imnoise(im,'gaussian');		// �m�C�Y�̕t�����ꂽ���
G=rgb2gray(imn);
x=im2double(G);				// �f�[�^��double�ɂ���
[CA,CH,CV,CD]=dwt2(x,wname);		// dwt2�̎��s�BCA�ɋߎ��W�����c��B
a=CA-min(CA);
a=a/max(a);        // 
//
G1=rgb2gray(im);			// ���̉摜���O���[�X�P�[���ɕϊ�
x1=im2double(G1);
//
imx=imabsdiff(x,x1)		// ���̉摜�ƃm�C�Y�̂���摜���r����B
//imx=imsubtract(x,x1);		// �������߂�ꍇ
imshow(imx);

// �摜��3���C���[�̓񎟌����U�E�F�[�u���b�g�ϊ�
stacksize('max');
wname='haar'
//
im=imread("DSC_0188.JPG");
ima=imresize(im,1);			// �摜�̑傫���𔼕��ɂ���
G=rgb2gray(ima);
x=im2double(G);				// �f�[�^��double�ɂ���
// �����x���̃E�F�[�u���b�g�ϊ��i�R���x���j���s���܂�
[C,S]=wavedec2(x,3,wname);		// 3���x���̃E�F�[�u���b�g�ϊ�
cA3=appcoef2(C,S,wname,3);		// 3���x���̋ߎ��W��
//
A3=wrcoef2('a',C,S,wname,3);
D1=wrcoef2('d',C,S,wname,1);		// �e���x���ɂ�����ڍ׌W��
D2=wrcoef2('d',C,S,wname,2);
D3=wrcoef2('d',C,S,wname,3);
xset('window',1);
// �o���オ�����ڍ׌W���Ȃǂ̕\���B
xsetech([0,0,1,0.2]);
plot(A3); xgrid(1);
xsetech([0,0.25,1,0.2]);
plot(D1); xgrid(1);
xsetech([0,0.5,1,0.2]);
plot(D2); xgrid(1);
xsetech([0,0.75,1,0.2]);
plot(D3); xgrid(1);
title('figure');
//
// �č\���̎��{
x0=waverec2(C,S,wname)
//
imshow(x0);			// �č\����̉摜�̕\��

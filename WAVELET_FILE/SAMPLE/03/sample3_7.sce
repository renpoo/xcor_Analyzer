//    integer �� double�@�ɕϊ��B
x=im2double(G);				// �摜��double�̃t�H�[�}�b�g�Ƃ���B
//    3���x�� �̕����A�񎟌����U�E�F�[�u���b�g�ϊ�
[cA,cH,cV,cD]=dwt2(x,'bior3.3');
// dwt2�E�F�[�u���b�g�ϊ��B
// �E�F�[�u���b�g�֐����Ƃ��� bior3�iB�X�v���C���j���g�p���Ă��܂��B
a = cA-min(cA);				// �摜�̋ߎ��W���̍ŏ��v�f�����ߋߎ��W���Ƃ̍��𓾂�
a=a/max(a);				// �ő�v�f
//    ����̌��ʁi�ߎ��W���̃f�[�^�j��\�����܂��B
imshow(a);

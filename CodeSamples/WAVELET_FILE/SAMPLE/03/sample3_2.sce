// �G���̍쐬 
[xref,x] = wnoise(5,12,snr,init);

//  �G�������̃X���b�V���z�[���h
level =2;
xd = wden(x,'minimaxi','s','one',level,'sym8');

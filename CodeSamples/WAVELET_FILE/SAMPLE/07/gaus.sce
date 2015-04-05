// Set effective support and grid parameters.
clf;
lb = -5; ub = 5; n = 1000;		// �ˁ@�}�̍��E�̒l
// Compute Gaussian wavelet of order 8.
[psi,x] = gauswavf(lb,ub,n,8);		// �ˁ@�E�F�[�u���b�g�̎w��
// Plot Gaussian wavelet of order 8.
plot(x,psi),			// ��}
title('Gaussian wavelet');
xgrid(1);

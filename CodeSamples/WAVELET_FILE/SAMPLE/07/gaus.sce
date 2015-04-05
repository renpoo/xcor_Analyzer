// Set effective support and grid parameters.
clf;
lb = -5; ub = 5; n = 1000;		// ⇒　図の左右の値
// Compute Gaussian wavelet of order 8.
[psi,x] = gauswavf(lb,ub,n,8);		// ⇒　ウェーブレットの指定
// Plot Gaussian wavelet of order 8.
plot(x,psi),			// 作図
title('Gaussian wavelet');
xgrid(1);

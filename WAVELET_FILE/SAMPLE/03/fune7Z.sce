// 画像データのcwt変換
//
stacksize('max');
wname='bior3.3'
im=imread("DSC_0188.JPG");
//
imn=imnoise(im,'gaussian');		// ノイズの付加
G=rgb2gray(imn);
y=im2double(G);				// データをdoubleにする
size_zu=length(y);			// データのおおきさ
stacksize('max');
scale=[1:64];			// スケール
coef=cwt(y(1:4096:size_zu),scale,'gaus5');	// cwt変換
subplot(121)			// 左に表示
surf(coef);			// 3D表示
xgrid(1);
xtitle('ノイズがある場合');
//
G1=rgb2gray(im);			// RGB からグレースケールへ変換
y1=im2double(G1);			// データをdoubleにする
scale=[1:64];				//  スケール
coef=cwt(y1(1:4096:size_zu),scale,'gaus5');	// cwt変換
subplot(122)				// 右に表示
surf(coef);				// 3D表示
title('ノイズがない状態')
xgrid(1);

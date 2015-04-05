// 画像の離散ウェーブウェーブレット変換表示
stacksize('max');
wname='bior3.3'
im=imread("DSC_0188.JPG");
G=rgb2gray(im);			// RGBをグレースケールへ
x=im2double(G);			// データをdoubleにする　⇒　重要
[CA,CH,CV,CD]=dwt2(x,wname);	// 2次元離散ウェーブレット変換
a=CA-min(CA);
a=a/max(a);
imshow(a);

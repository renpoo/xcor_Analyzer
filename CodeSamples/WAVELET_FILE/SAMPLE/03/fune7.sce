// ガウスノイズの重畳したデータをdwt変換し表示
stacksize('max');
wname='bior3.3'
im=imread("DSC_0188.JPG");
imn=imnoise(im,'gaussian');		// ノイズの付加
G=rgb2gray(imn);			// RGBをグレーコードに変換
x=im2double(G);				// データをdoubleにする
[CA,CH,CV,CD]=dwt2(x,wname);		// dwt2の実行
a=CA-min(CA);
a=a/max(a);
imshow(a);			// 近似係数の表示

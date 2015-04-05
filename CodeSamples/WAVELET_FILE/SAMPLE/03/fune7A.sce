stacksize('max');
wname='bior3.3'
im=imread("DSC_0188.JPG");		// 雑音のない状態
imn=imnoise(im,'gaussian');		// ノイズの付加された状態
G=rgb2gray(imn);
x=im2double(G);				// データをdoubleにする
[CA,CH,CV,CD]=dwt2(x,wname);		// dwt2の実行。CAに近似係数が残る。
a=CA-min(CA);
a=a/max(a);        // 
//
G1=rgb2gray(im);			// 元の画像をグレースケールに変換
x1=im2double(G1);
//
imx=imabsdiff(x,x1)		// 元の画像とノイズのある画像を比較する。
//imx=imsubtract(x,x1);		// 差を求める場合
imshow(imx);

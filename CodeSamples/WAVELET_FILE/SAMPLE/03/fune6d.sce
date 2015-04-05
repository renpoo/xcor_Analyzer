// 画像を3レイヤーの二次元離散ウェーブレット変換
stacksize('max');
wname='haar'
//
im=imread("DSC_0188.JPG");
ima=imresize(im,1);			// 画像の大きさを半分にする
G=rgb2gray(ima);
x=im2double(G);				// データをdoubleにする
// 多レベルのウェーブレット変換（３レベル）を行います
[C,S]=wavedec2(x,3,wname);		// 3レベルのウェーブレット変換
cA3=appcoef2(C,S,wname,3);		// 3レベルの近似係数
//
A3=wrcoef2('a',C,S,wname,3);
D1=wrcoef2('d',C,S,wname,1);		// 各レベルにおける詳細係数
D2=wrcoef2('d',C,S,wname,2);
D3=wrcoef2('d',C,S,wname,3);
xset('window',1);
// 出来上がった詳細係数などの表示。
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
// 再構成の実施
x0=waverec2(C,S,wname)
//
imshow(x0);			// 再構成後の画像の表示

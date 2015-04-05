// 画像の表示'
stacksize('max');
im=imread("DSC_0188.JPG");
imshow(im); 		// オリジナルを表示します。
// ヒストグラフの表示
im = rgb2gray(im);		// rgb からグレースケールに変換
[count, cells]=imhist(im);	// 	ヒストグラムを作成する
//
plot(cells,count);		// 横軸はcell、縦軸はcountで表示
xlabel('cells');
ylabel('count');
title('ヒストグラム');
xgrid(1);
//

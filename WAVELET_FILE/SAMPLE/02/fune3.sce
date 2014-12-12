// 画像の表示とヒストグラムの表示
stacksize('max');
im=imread("DSC_0188.JPG");
disp('ノイズ　speckle を加えます。')
//
imn=imnoise(im,'speckle');		// ノイズの指定
imshow(imn); 
// ヒストグラフの表示、ノイズなし
im = rgb2gray(imn);
[count, cells]=imhist(im);
//
plot(cells,count);
xlabel('cells');
ylabel('count');
title('ヒストグラム');
xgrid(1);
//

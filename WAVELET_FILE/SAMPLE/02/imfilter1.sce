// 画像をフィルタリングして表示
stacksize('max');
im=imread("DSC_0188.JPG");
filter = fspecial('sobel');		// フィルターの設定
imf = imfilter(im, filter);
imshow(imf);

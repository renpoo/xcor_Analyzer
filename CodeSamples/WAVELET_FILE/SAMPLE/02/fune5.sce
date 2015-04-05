// 画像の大きさ変更と補色の表示
stacksize('max');
im=imread("DSC_0188.JPG");
ima=imresize(im,0.5);		// 画像の大きさを半分にする
imout=imcomplement(ima);	// 補色の画像を作成
imshow(imout);			// 画像の表示

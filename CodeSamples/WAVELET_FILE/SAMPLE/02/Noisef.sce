// 画像のノイズ付加、画像ファイルは320X240ピクセルの大きさ
stacksize('max');
filename =  'people.jpg';
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
im=imread(filename);
imn = imnoise(im, 'gaussian');	// ガウシアンノイズを画像データに与えます。
imshow(imn);			// ノイズが加えられた画像データを表示します。

// 顔のエッジ検出、画像ファイルは320X240ピクセルの大きさ
stacksize('max');
filename =  'F:\SCILAB-DEMO\demos4/image/DSCF0242.jpg';
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
im = imread(filename);
im=imread(filename);
imc=edge(rgb2gray(im),'canny');		// オリジナルの画像データからエッジ検出を行います。
imshow(imc);				// エッジ検出され修正された画像を表示します。

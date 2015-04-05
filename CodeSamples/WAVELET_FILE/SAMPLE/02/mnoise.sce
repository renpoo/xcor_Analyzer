// 休止モードで実行。コンソールで一行ごとに「改行」を入力します。
mode(7)
// 画像のノイズ付加、画像ファイルは320X240ピクセルの大きさ
stacksize('max');
filename='/usr/share/scilab/contrib/sivp/images/people.jpg';
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
im = imread(filename);
    imn = imnoise(im, 'gaussian');
    imshow(imn);
// 画像 Gaussian ノイズ

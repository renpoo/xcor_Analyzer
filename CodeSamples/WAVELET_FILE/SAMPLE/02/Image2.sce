filename =  'people.jpg';    // 表示する画像ファイルの名称
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
im = imread(filename);
imshow(im);

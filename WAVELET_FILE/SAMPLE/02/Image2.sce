filename =  'people.jpg';    // �\������摜�t�@�C���̖���
if getos() == 'Windows' then 
  filename=strsubst(filename,'/','\');
end
im = imread(filename);
imshow(im);

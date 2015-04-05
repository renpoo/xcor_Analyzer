im=imread("DSC_0188.JPG");
imc=edge(rgb2gray(im),'canny');
imshow(imc);

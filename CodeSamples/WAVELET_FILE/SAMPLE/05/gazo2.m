im=imread("DSC_0188.JPG");
imn=imnoise(im,'speckle');
imshow(imn);

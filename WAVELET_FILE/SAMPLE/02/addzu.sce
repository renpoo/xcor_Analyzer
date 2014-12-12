// ‚Q‚Â‚Ì‰æ‘œ‚Ì‰‰Z‚ğs‚¤
stacksize('max');
im1 = imread('DSC_0001.JPG');
im2 = imread('DSC_0002.JPG');
ims1 = imabsdiff(im1, im2);
//ims1 = imadd(im1, 5);
imshow(ims1);

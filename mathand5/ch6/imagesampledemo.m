clear all;close all
load clown
p(1)=imagesample(X);
subplot(2,2,1);imshow(p(1));
for i=2:4
  p(i)=p(i-1).filtering;
  subplot(2,2,i);imshow(p(i));
end
figure
for i=1:4
gazou=p(i).gazou;
subplot(2,2,i);imshow(gazou,[]);
end

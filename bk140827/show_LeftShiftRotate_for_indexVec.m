clear;

#y = [1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9];
y = [1 : 256];
yTmp = y;


len = length(y);
indexVec = (1 : len);


for k = 1 : len,
  disp(indexVec);
  #disp(yTmp);
  
  tmpVec = indexVec(2 : len);
  tmpVec(len) = indexVec(1);
  indexVec = tmpVec;

  yTmp = y(indexVec);
endfor;

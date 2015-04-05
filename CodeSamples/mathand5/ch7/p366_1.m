yy=double(y);
[var(yy), sum((yy-mean(yy)).^2)/(length(yy)-1)]
[std(yy) sqrt(sum((yy-mean(yy)).^2)/(length(yy)-1))]

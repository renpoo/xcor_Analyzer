num=input('学生証番号下一桁を入れてください．->');
gakusei=1+num;
data=sin((1:1024)*2*pi/1024*gakusei);
[val,ind]=max(data);
fprintf('最初のピーク値は，%gで%d番目です．\n',val,ind);
plot(data);hold on;plot(ind,val,'rp');hold off


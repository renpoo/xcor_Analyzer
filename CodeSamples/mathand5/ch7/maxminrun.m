animation = 1;
set(1,'interruptible','on','windowbuttondownfcn','animation =0;');
while (animation)
recordblocking (r,0.5);
y = getaudiodata(r, 'int16');
[maxyval,maxyind]=max(y);
[minyval,minyind]=min(y);
set(aaa(1),'ydata',y);
set(aaa(2),'ydata',[maxyval,maxyval]);
set(aaa(3),'ydata',[minyval,minyval]);
title([' êUïù',num2str(double(maxyval)-double(minyval))]);
drawnow;
i=i+1;
end;
set(1,'interruptible','on','windowbuttondownfcn','maxminrun;');

close all;
pupind=[];
pdwnind=[];
for i=2:length(yy)
  if (yy(i-1)<=triglevel(1))&(triglevel(1)<yy(i))
    pupind=[pupind i];
  end
  if (yy(i-1)>=triglevel(1))&(triglevel(1)>yy(i))
    pdwnind=[pdwnind i];
  end
end
plot(t,yy,t(pupind),yy(pupind),'p',t(pdwnind),yy(pdwnind),'rp');

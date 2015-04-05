plogicval=(yy >= triglevel(1));
pupind=strfind(plogicval,[0 1]);
pdwnind=strfind(plogicval,[1 0]);
plot(t,yy,t(pupind),yy(pupind),'p',t(pdwnind),yy(pdwnind),'rp');

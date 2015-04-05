animation = 1;
set(1,'interruptible','on','windowbuttondownfcn','animation= 0;');
while (animation)
	i=i+1
	drawnow;
end;
set(1,'interruptible','on','windowbuttondownfcn','demorun;');

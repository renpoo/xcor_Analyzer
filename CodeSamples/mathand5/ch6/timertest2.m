t1=userevent('o');t2=userevent('x');
tt1=eventtimer(1);tt2=eventtimer(2);
t1.addtimer(tt1);t2.addtimer(tt2);
tic;while(toc < 5);drawnow;end
delete(tt1);delete(tt2); fprintf('\n');

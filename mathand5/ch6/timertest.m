t1=timer('TimerFcn','fprintf(''o'');','Period',1,'ExecutionMode','FixedRate');
t2=timer('TimerFcn','fprintf(''x'');','Period',2,'ExecutionMode','FixedRate');
start(t1);start(t2);
tic;while(toc < 5);drawnow;end
stop(t1);stop(t2);fprintf('\n');

function timeAxis = create_timeAxis_(tStart, tStop, length, duration )

tSpan = tStop - tStart;
tStep = tSpan / (length-1);

timeAxis = ( tStart : tStep : tStop );
%timeAxis = timeAxis * 1000; % unit change from [s] to [ms] 

function dump_outputData_( outputData, str )

[temp dateTime] = system("date +%y%m%d%H%M%S");
dateTime = dateTime( 1 : length(dateTime)-1 );
dumpFileName = strcat( "dump_calc_", str, ".", dateTime, ".csv" );
dump_data_( outputData, str, dumpFileName );

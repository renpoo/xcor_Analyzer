# test_Compare_eachAC_CC_for_TestSinusoid.m
clear;


wavFileName = "Sounds/TestSinusoid.wav";
window_size = 512;

[rxxOrg,       timeVec, m, lag] = test_Compare_eachAC_CC_for_Waveform(wavFileName, window_size, "AC", "Org",       3);
[rxxCustom,    timeVec, m, lag] = test_Compare_eachAC_CC_for_Waveform(wavFileName, window_size, "AC", "Custom",    3);
[rxxTachi,     timeVec, m, lag] = test_Compare_eachAC_CC_for_Waveform(wavFileName, window_size, "AC", "Tachi",     3);
[rxxSys_xcorr, timeVec, m, lag] = test_Compare_eachAC_CC_for_Waveform(wavFileName, window_size, "AC", "Sys_xcorr", 3);

[rxyOrg,       timeVec, m, lag] = test_Compare_eachAC_CC_for_Waveform(wavFileName, window_size, "CC", "Org",       3);
[rxyCustom,    timeVec, m, lag] = test_Compare_eachAC_CC_for_Waveform(wavFileName, window_size, "CC", "Custom",    3);
[rxyTachi,     timeVec, m, lag] = test_Compare_eachAC_CC_for_Waveform(wavFileName, window_size, "CC", "Tachi",     3);
[rxySys_xcorr, timeVec, m, lag] = test_Compare_eachAC_CC_for_Waveform(wavFileName, window_size, "CC", "Sys_xcorr", 3);


#plot(timeVec, rxxOrg, 'b', timeVec, rxxCustom, 'r', timeVec, rxxTachi, 'k');
#plot(timeVec, rxyOrg, 'b', timeVec, rxyCustom, 'r', timeVec, rxyTachi, 'k');
#plot(timeVec, rxxOrg,    'b', timeVec, rxyOrg,    'r');
#plot(timeVec, rxxCustom, 'b', timeVec, rxyCustom, 'r');
#plot(m, rxxTachi,  'b', m, rxyTachi,  'r');
plot(lag, rxxSys_xcorr, 'b', lag, rxySys_xcorr, 'r');

xlabel('Time (ms)'); ylabel('Auto/Cross Correlation Func ()');



pkg load io;
outputDataFileName = "Output\ Data/test_Compare_eachAC_CC_for_TestSinusoid.csv";
[fid, msg] = fopen(outputDataFileName, "wt");
if ( fid == -1 ) disp( msg ); endif;

fprintf( fid, "%s", "rxxOrg, " );
fprintf( fid, "%f, ", rxxOrg );
fprintf( fid, "%s", "\n" );
fprintf( fid, "%s", "rxyOrg, " );
fprintf( fid, "%f, ", rxyOrg );
fprintf( fid, "%s", "\n" );

fprintf( fid, "%s", "rxxCustom, " );
fprintf( fid, "%f, ", rxxCustom );
fprintf( fid, "%s", "\n" );
fprintf( fid, "%s", "rxyCustom, " );
fprintf( fid, "%f, ", rxyCustom );
fprintf( fid, "%s", "\n" );

fprintf( fid, "%s", "rxxTachi, " );
fprintf( fid, "%f, ", rxxTachi );
fprintf( fid, "%s", "\n" );
fprintf( fid, "%s", "rxyTachi, " );
fprintf( fid, "%f, ", rxyTachi );
fprintf( fid, "%s", "\n" );

fprintf( fid, "%s", "rxxSys_xcorr, " );
fprintf( fid, "%f, ", rxxSys_xcorr );
fprintf( fid, "%s", "\n" );
fprintf( fid, "%s", "rxySys_xcorr, " );
fprintf( fid, "%f, ", rxySys_xcorr );
fprintf( fid, "%s", "\n" );

fprintf( fid, "%s", "timeVec, " );
fprintf( fid, "%f, ", timeVec );
fprintf( fid, "%s", "\n" );

fprintf( fid, "%s", "m, " );
fprintf( fid, "%f, ", m );
fprintf( fid, "%s", "\n" );

fprintf( fid, "%s", "lag, " );
fprintf( fid, "%f, ", lag );
fprintf( fid, "%s", "\n" );

fclose( fid );

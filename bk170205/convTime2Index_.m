function tIdx = convTime2Index_( t, s, fs )

tIdx = floor( t * fs ) + 1;
%tIdx = floor( t * fs );

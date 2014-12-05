function [ T_Idx, tauIdx, startIdx, stopIdx ] = convTime2Index_for_Start_End_( tauEnd, duration, x )

T_Idx = length(x);
very_startIdx = -T_Idx;
very_stopIdx  = +T_Idx;
very_spanIdx  = round(very_stopIdx - very_startIdx);


tauIdx = floor(tauEnd / duration * very_spanIdx / 2);
startIdx = -tauIdx;
stopIdx  = +tauIdx;

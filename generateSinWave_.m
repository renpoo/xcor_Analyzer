function [ signal, tVec ] = generateSinWave_(A, f, fs, ts, te, theta)
% omega  : frequency [Hz]
% fs    : sampling rate [bit]
% ts    : time to start [s]
% te    : time to end [s]
% theta : phase [rad]

d = te - ts;
N = round( fs * d );  % #samples
tVec = ( 1 : N )'/fs;        % time vector
signal = A * sin( 2*pi * f * tVec + theta );   % sinusoid

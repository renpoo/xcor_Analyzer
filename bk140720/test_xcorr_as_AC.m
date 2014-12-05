wavFileName = "Sounds/TestSinusoid.wav";
[x,fs,bits] = wavread(wavFileName);
sound(x,fs); # Sound test before computation
maxlag = window_size - 1;

[rxx, lag] = xcorr ( x );
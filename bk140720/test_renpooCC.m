wavFileNameX = "Sounds/TestSinusoid-01.wav";
wavFileNameY = "Sounds/TestWhiteNoise-01.wav";
wavFileNameZ = "Sounds/TestWhiteNoise-02.wav";
wavFileNameW = "Sounds/tutu_mandelaCorFree.wav";

f = 440;
fs = 44100;
d = 1.0;

x = GenerateSinusoid_(f, fs, d, wavFileNameX);
y = GenerateWhiteNoise_(f, fs, d, wavFileNameY);
z = y * 0.01;


[x,fsX,bitsX] = wavread(wavFileNameX);
sound(x,fsX); # Sound test before computation

[y,fsY,bitsY] = wavread(wavFileNameY);
sound(y,fsY); # Sound test before computation

#[y,fsY,bitsY] = wavread(wavFileNameY);
sound(z,fsY); # Sound test before computation

[w,fsW,bitsW] = wavread(wavFileNameW);
sound(w,fsW); # Sound test before computation

#plot(x);
#maxlag = window_size - 1;

#C = CrossCorrelation_Renpoo_( x, y );
C = CrossCorrelation_Renpoo_( x, z );
#C = CrossCorrelation_Renpoo_( y, z );

#C = CrossCorrelation_Renpoo_( x, x );

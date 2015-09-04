BandsPerOctave = 1;
N = 6;           % Filter Order
F0 = 1000;       % Center Frequency (Hz)
Fs = 48000;      % Sampling Frequency (Hz)
f = fdesign.octave(BandsPerOctave,'Class 1','N,F0',N,F0,Fs);


F0 = validfrequencies(f);
Nfc = length(F0);
for i=1:Nfc,
    f.F0 = F0(i);
    Hd(i) = design(f,'butter');
end


f.BandsPerOctave = 3;
f.FilterOrder = 8;
F0 = validfrequencies(f);
Nfc = length(F0);
for i=1:Nfc,
    f.F0 = F0(i);
    Hd3(i) = design(f,'butter');
end


hfvt = fvtool(Hd,'FrequencyScale','log','color','white');
axis([0.01 24 -90 5])
title('Octave-Band Filter Bank')
hfvt = fvtool(Hd3,'FrequencyScale','log','color','white');
axis([0.01 24 -90 5])
title('1/3-Octave-Band Filter Bank')


Nx = 100000;
SA = dsp.SpectrumAnalyzer('SpectralAverages',50,'SampleRate',Fs,...
    'PlotAsTwoSidedSpectrum',false,'FrequencyScale','Log',...
    'YLimits', [-80 20]);
tic,
while toc < 15
    % Run for 15 seconds
    xw = randn(Nx,1);
    step(SA,xw);
end


SA2 = dsp.SpectrumAnalyzer('SpectralAverages',50,'SampleRate',Fs,...
    'PlotAsTwoSidedSpectrum',false,'FrequencyScale','Log',...
    'RBWSource','Property','RBW',2000);
yw = zeros(Nx,Nfc);
tic,
while toc < 15
    % Run for 15 seconds
    xw = randn(Nx,1);
    for i=1:Nfc,
        yw(:,i) = filter(Hd3(i),xw);
    end
    step(SA2,yw);
end


Hpink = dsp.ColoredNoise(1,Nx,1);
SA3 = dsp.SpectrumAnalyzer('SpectralAverages',50,'SampleRate',Fs,...
    'PlotAsTwoSidedSpectrum',false,'FrequencyScale','Log',...
    'YLimits', [-80 20]);
tic,
while toc < 15
    % Run for 15 seconds
    x = step(Hpink);
    step(SA3,x);
end


SA4 = dsp.SpectrumAnalyzer('SpectralAverages',50,'SampleRate',Fs,...
    'PlotAsTwoSidedSpectrum',false,'FrequencyScale','Log',...
    'RBWSource','Property','RBW',2000);
y = zeros(Nx,Nfc);
tic,
while toc < 15
    % Run for 15 seconds
    x = step(Hpink);
    for i=1:Nfc,
        y(:,i) = filter(Hd3(i),x);
    end
    step(SA4,y);
end


%
%      Make BandPass Noise through FFT
%      Irino, T.
%      Created before: 29 Jan 98
%      Modified: 8 Jun 2006
%
%      function [BPNoise] = MkBPNoise(fs, BandPassFreq, TSnd, RandSeed)
%      INPUT:  fs : sampling rate
%              BandPassFreq: Band pass Freq. [Min, Max]
%              TSnd: length of sound in (ms)  
%              RandSeed: random seed
%      OUTPUT: BPNoise: Bandpass Noise  (Sigma = 1 when White Gaussian Noise)
%      
%
%
function [NBNoise] = generateNarrowbandNoise03_( fMin, fMax, fs, TSnd, RandSeed )

if nargin <  3, TSnd = 1; end; 	%  sec
if nargin == 4, rng( 'shuffle' ); end; % randn: mean 0, variance 1.

LenSnd = round(TSnd*fs);

%RandSnd  = rand( [ 1 LenSnd ] );
RandSnd = ones( 1, LenSnd );

FRandSnd = fft( RandSnd );
Th = angle(FRandSnd);
df = fs/LenSnd;
freq = [0:df:(fs/2-df) -fs/2:df:-df];

NfBPp = find( freq >=  fMin &  fMax >= freq );
NfBPn = find( freq <= -fMin & -fMax <= freq );


MskAmp = zeros(1,LenSnd);
MskAmp(NfBPp) = ones(size(NfBPp));
MskAmp(NfBPn) = ones(size(NfBPn));

FRandSnd = MskAmp .* FRandSnd;
NBNoise  = real(ifft(FRandSnd));

% BPNoise = BPNoise(1:LenSnd);




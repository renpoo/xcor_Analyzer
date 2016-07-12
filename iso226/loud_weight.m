function g = loud_weight(f,phon)
% Calculate loudness weighting coefficients based on ISO 226
% 
%   g = loud_weight(f)
%   g = loud_weight(f,phon)
% 
%   G = LOUD_WEIGHT(F) returns loudness weighting
%   coefficients for frequencies F (Hz). The function is
%   based on the loudness at 65 phons defined in ISO
%   226:2003.
% 
%   G = LOUD_WEIGHT(F,PHON) returns loudness weighting
%   coefficients at the loudness level PHON. PHON should be
%   a scalar and, according to the standard, is only valid
%   at all frequencies such that 20<=PHON<80 (although the
%   function will return SPL values outside of this range).
% 
%   The input f may be an array of any size. The outputs
%   will be the same size as f, with coefficients calculated
%   for each element.
% 
%   NB: since ISO 226:2003 only reports values up to 12.5
%   kHz, frequencies are limited to 12.5 kHz for the
%   purposes of calculating weighting coefficients.
% 
%   See also ISO226, DUP_WEIGHT.

% !---
% ==========================================================
% Last changed:     $Date: 2015-03-31 15:19:31 +0100 (Tue, 31 Mar 2015) $
% Last committed:   $Revision: 352 $
% Last changed by:  $Author: ch0022 $
% ==========================================================
% !---


%% Check input

assert(all(f(:)>=0),'f should be greater than or equal to zero!')

if nargin<2
    phon = 65;
else
    assert(isscalar(phon),'phon must be a scalar.')
end

%% Calculate weighting coefficients

% return equal loudness contours
% limit SPL values for f > 12.5 kHz
IX = f>12500;
f2 = f;
f2(IX) = 12500;
spl = squeeze(iso226(phon,f2));

% calculate weighting coefficients
g = min(spl(:))-spl;
g = 10.^(g./20);

% [EOF]
function [ fCentre, fUpper, fLower ] = octaveBand_()

fCentre = 10^3 * (2 .^ [-6:4]);

fD = 2^(1/2);
%fD = 2^(1/6);

fUpper = fCentre * fD;
fLower = fCentre / fD;

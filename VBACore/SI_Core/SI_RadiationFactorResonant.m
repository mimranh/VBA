function [SigmaS, SigmaA] = SI_RadiationFactorResonant(Elements)
%
% This Function Calculates the RadiationFactorResonant for airborne in accordance with ISO 717-1
%
% INPUTS:
%   SigmaForced = Radiation factor for forced transmission
%   SigmaFW = Radiation factor for Free bending waves
%   EtaTotalSitu = Total Loss Factor
%   f = Ocatve Band Frequency in Hz
%   fc = Critical Frequency in Hz
%
% OUTPUTS:
%   SigmaS = Structural excitation
%   SigmaA = Radiation factor for airborne excitation
%
% USAGE Example:
%   [SigmaS,SigmaA] = RadiationFactorResonant(SigmaFW,SigmaForced,EtaTotalSitu,fc,f);
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Radiation Factors for Resonance Transmission
SI_constants;
SigmaFW = Elements.SigmaFW;
SigmaForced = Elements.SigmaForced;
EtaTotalSitu = Elements.EtaSitu;
fc = Elements.fc;
%
r = (pi * fc .* SigmaFW) ./ (4 * f .* EtaTotalSitu);
SigmaS = SigmaFW;
SigmaA = (SigmaForced + r .* SigmaFW) ./ (1 + r);

%%

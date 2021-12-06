function [SigmaForced, SigmaFW, RadiEfficiency, SigmaForced_small, SigmaFW_small] = SI_RadiationFactor(Elements)
%
% This Faction Calculates the RadiEfficiency, the radiation factor for free waves and the radiation,
% factor for forced transmission for airborne in accordance with ISO 717-1
% These equations are valid for a plate surrounded by an infinite baffle in the same plane. However, in
% buildings walls and floors are usually surrounded by orthogonal elements which will increase the
% radiation efficiency well below the critical frequency by a factor of 2 (edge modes) to 4 (corner modes)
%
% INPUTS:
%   L1 = Length of Element in meter
%   L2 = Length of Element in meter (L1 > L2)
%   ko = Wave Number
%   f = Ocatve Band Frequre in Hz
%   fc = Critcal Frequre
%   c0 = Velocity of Sound in Air
%
% OUTPUTS:
%   SigmaForced = Radiation factor for forced transmission
%   SigmaFW = Radiation factor for Free bending waves
%   RadiEfficiency = Radiation efficiency
%
% USAGE Example:
%   [SigmaForced, SigmaFW, RadiEfficiency] = RadiationFactor(4,3,ko,f,fc,343);
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2018
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

SI_constants;
L1 = Elements.Width;
L2 = Elements.Length;
fc = Elements.fc;
N1 = Elements.N1;
N2 = Elements.N2;

%% Radiation Factor

%% Radiation factor for forced transmission
Delta = -0.964 - ((0.5 + (L2 ./ (pi * L1))) .* log(L2./L1)) + ((5 * L2) ./ (2 * pi * L1)) - (1 ./ (4 * pi * L1 * L2 .* (ko.^2)));
SigmaForced = 0.5 * (log(ko.*sqrt(L1.*L2)) - Delta); % Radiation factor for forced transmission
SigmaForced(SigmaForced > 2) = 2;
RadiEfficiency = 10 * log10(SigmaForced);

Delta_small = -0.964 - ((0.5 + (L2./N2 ./ (pi * L1./N1))) .* log((L2./N2)./(L1./N1))) ...
    + ((5 * L2./N2) ./ (2 * pi * L1./N1)) - (1 ./ (4 * pi * L1./N1 * L2./N2 .* (ko.^2)));
SigmaForced_small = 0.5 * (log(ko.*sqrt(L1./N1.*L2./N2)) - Delta_small); % Radiation factor for forced transmission
SigmaForced_small(SigmaForced_small > 2) = 2;

%% Radiation factor for Free bending waves
Sigma1 = 1 ./ sqrt(1-(fc./f));
Sigma2 = 4 * L1 * L2 .* ((f ./ c0).^2);
Sigma3 = sqrt((2 * pi * f * (L1 + L2))./(16 * c0));

Sigma1_small = 1 ./ sqrt(1-fc./f);
Sigma2_small = 4 * L1./N1 * L2./N2 .* ((f ./ c0).^2);
Sigma3_small = sqrt((2 * pi * f * (L1./N1 + L2./N2))./(16 * c0));

F11 = ((c0.^2) ./ (4 * fc)) .* ((1 / L1.^2) + (1 / L2.^2));
SigmaFW = zeros(1, length(f)); % Radiation factor for Free bending waves
SigmaFW_small = zeros(1, length(f)); % Radiation factor for Free bending waves
%
for i = 1:length(f)
    if F11 <= fc / 2
        if f(i) >= fc
            SigmaFW(i) = Sigma1(i);
            SigmaFW_small(i) = Sigma1_small(i);
        elseif f(i) < fc
            Lemda = sqrt(f(i)./fc);
            Delta1 = (((1 - Lemda.^2) .* log((1 + Lemda)./(1 - Lemda))) + 2 * Lemda) ./ ((4 * pi.^2) .* (1 - Lemda.^2).^1.5);
            Delta1_small = (((1 - Lemda.^2) .* log((1 + Lemda)./(1 - Lemda))) + 2 * Lemda) ./ ((4 * pi.^2) .* (1 - Lemda.^2).^1.5);
            if f(i) > fc / 2
                Delta2 = 0;
                Delta2_small =0;
            elseif f(i) <= fc / 2
                Delta2 = (8 * c0^2 .* (1 - 2 * Lemda.^2)) ./ (fc.^2 * pi.^4 * L1 * L2 * Lemda .* (sqrt(1-Lemda.^2)));
                Delta2_small = (8 * c0^2 .* (1 - 2 * Lemda.^2)) ./ (fc.^2 * pi.^4 * L1./N1 * L2./N2 * Lemda .* (sqrt(1-Lemda.^2)));
            end
            SigmaFW(i) = ((2 * (L1 + L2)) ./ (L1 * L2)) .* (c0 ./ fc) .* Delta1 + Delta2;
            SigmaFW_small(i) = ((2 * (L1./N1 + L2./N2)) ./ (L1./N1 * L2./N2)) .* (c0 ./ fc) .* Delta1_small + Delta2_small;
        end
        if (F11 > f(i) && F11 < fc / 2 && SigmaFW(i) > Sigma2(i))
            SigmaFW(i) = Sigma2(i);
            SigmaFW_small(i) = Sigma2_small(i);
        end
    elseif F11 > fc / 2
        if (f(i) < fc) && (Sigma2(i) < Sigma3(i))
            SigmaFW(i) = Sigma2(i);
        elseif (f(i) > fc) && (Sigma1(i) < Sigma3(i))
            SigmaFW(i) = Sigma1(i);
        else
            SigmaFW(i) = Sigma3(i);
        end
        
        if (f(i) < fc) && (Sigma2_small(i) < Sigma3_small(i))
            SigmaFW_small(i) = Sigma2_small(i);
        elseif (f(i) > fc) && (Sigma1_small(i) < Sigma3_small(i))
            SigmaFW_small(i) = Sigma1_small(i);
        else
            SigmaFW_small(i) = Sigma3_small(i);
        end
    end
end
SigmaFW(SigmaFW >= 2) = 2;
SigmaFW_small(SigmaFW_small >= 2) = 2;
%

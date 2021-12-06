function [Dnfsit] = SI_NormFlankLevelDiffMeasurement(Dnflab, ta, Scs, ScsLab, Scr, ScrLab, hpl, hlab, AbsorbLining, f, Flag1)
%
% This Function Calculates the normalized flanking level difference
%
% INPUTS:
%   Dnflab = Measured Flanking Level Difference
%   ta = Thickness of the absorbing lining in the plenum, in metres
%   Scs = Area of the ceiling in the receiving room
%   ScsLab = Area of the ceiling source room for the laboratory
%   Scr = Area of the ceiling in the source room and receiving room
%   ScrLab = Area of the ceiling in receiving room for the laboratory
%   hpl = Free height of the plenum above the ceiling
%   hlab = Free height of the plenum above the ceiling for the laboratory
%   Flag1 = true if Determination from performance of the elements
%         = flase if Determination from Measured Flanking Level Difference
%   Flag2 = ture if the structure-borne transmission is Dominant
%         = false if the structure-borne transmission is Dominant
%
% OUTPUTS:
%   Dnfsit = is normalized flanking level difference from Measurements
%   Dnfij = is normalized flanking level difference from the performance of elements
%
% USAGE Example:
%   [Dnfsit,Dnfij] = NormFlankLevelDiff(Dnflab,ta,Scs,ScsLab,Scr,ScrLab,hpl,hlab,AbsorbLining,f,Flag1,Flag2);
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Determination of normalized flanking level difference
% Dominant airborne transmission (Determination form Data)
if Flag1
    Dnfsit = Dnflab;
else
    if AbsorbLining
        Ca = 0;
    else
        for k = 1:length(f)
            if f(k) <= 0.015 * (c0 ./ ta)
                Ca(k) = 0;
            elseif f(k) > 0.015 * (c0 ./ ta) && f(k) < (0.3 * c0) / min(hlab, hpl)
                Ca(k) = 10 * log10(sqrt((Scs * Scr)./(ScsLab * ScrLab))) .* (hlab ./ hpl);
            elseif f(k) > 0.3 * c0 / min(hlab, hpl)
                Ca(k) = 10 * log10(sqrt((Scs * Scr)./(ScsLab * ScrLab))) * (hlab ./ hpl).^2;
            end
        end
    end
    Dnfsit = Dnflab + (10 * log10((hpl * Lij)./(hLab * lLab))) + (10 * log10((Scslab * Scrlab)./(Scs * Scr)) + Ca);
end
%

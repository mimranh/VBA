function [fc, fceff] = SI_calcCriticalFrequency(Element)
%
% This Function Calculates the Critical Freqency
%
% INPUTS:
%   Element.QuasiLongPhaseVelocity = Qausi Longitudnal Phase Velocity
%   Element.Thickness = Thickness of the wall
%
% OUTPUTS:
%   fc = Critcal Frequency of the element for that the Absorpotion is required
%   fceff = Correction Term
%
% USAGE Example:
%   [fc,fceff] = calcCriticalFrequency(Partition);
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

SI_constants;
fc = (c0.^2) ./ (1.8 * Element.QuasiLongPhaseVelocity * Element.Thickness); % Critical Frequency
fceff = fc * (4.05 * Element.Thickness .* f ./ Element.QuasiLongPhaseVelocity + sqrt(1+(4.05 * Element.Thickness .* f ./ Element.QuasiLongPhaseVelocity).^2));
end

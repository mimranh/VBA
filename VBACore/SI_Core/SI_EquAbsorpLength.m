function [EquAbsorptionLength] = SI_EquAbsorpLength(Elements)
%
% This Function Calculates The equivalent absorption length for airborne in accordance with ISO EN: 12354-1
%
% INPUTS:
%   S = Surface Area of Lement in m2 (e.g.: 4)
%   Ts = Structural Reveberation Time
%   fref = Reference Frequency (1000 Hz)
%   f = Frequency
%   c0 = Velocity of Sound in Air
%
% OUTPUTS:
%   a = The equivalent absorption length
%
% USAGE Example:
%   [a] = EquAbsorpLength(S,Ts,f,fref,c0);
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% The equivalent absorption length
SI_constants
S = Elements.Area;
Ts = Elements.TsSitu;
%
EquAbsorptionLength = ((2.2 * (pi.^2) * S) ./ (c0 .* Ts)) .* (sqrt(fref./f));

%%

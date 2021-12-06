function Dns = SI_IndirectTransmission(ElementsResults, DoorStaus)
%
% This Function Calculates the indirect airborne transmission from performance
% of system elements
%
% INPUTS:
%   Rhs = is the sound reduction index of the wall between the hall and the source room, in decibels
%   Rhr = is the sound reduction index of the wall between the hall and the receiving room, in decibels
%   Shs = is the area of the wall between the hall and the source room, in square metres
%   Shr = is the area of the wall between the hall and the receiving room, in square metres
%   Ah = is the equivalent sound absorption area of the hall, in square metres
%   Cdoorposition = is a correction term to take into account the effect of the orientation of the doors to each other
%
% OUTPUTS:
%   Dns = Indirect airborne transmission
%
% USAGE Example:
%   [Dns] = IndAirBorneTrans(Rhs,Rhr,Ah,Shs,Shr,true);
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Determination of normalized flanking level difference
%
A0 = 10;
Rhs = ElementsResults.SWallF.RSitu;
Rhr = ElementsResults.RWallF.RSitu;
Shs = ElementsResults.SWallF.Area;
Shr = ElementsResults.RWallF.Area;
Ah = 64; % ????

if DoorStaus
    Cdoor = -2;
else
    Cdoor = 0;
end
Dns = Rhs + Rhr + 10 * log((Ah * A0)./(Shs * Shr)) + Cdoor;

%%
%

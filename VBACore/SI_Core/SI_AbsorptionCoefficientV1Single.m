function [AlphaKSitu, AlphakLab, AlphAvg, Kijs] = SI_AbsorptionCoefficientV1Single(Mass, fc, fcj, Kij, WallID)
%
% This Faction Calculates the Absorption Coefficient for airborne in accordance with ISO 717-1
%
% INPUTS:
%   ElementMass = Mass of the Partioning in Kg/m2 (e.g.: 460)
%   fc = Critcal Frequre of the element for that the Absorpotion is required
%   fref = Reference Frequency (1000 Hz)
%   Kij = Vibration transmission over junctions (Matrix conatining all paths from i-th element to j-th element)
%   fcj = Critcal Frequre of j-th Element
%
% OUTPUTS:
%   AlphAvg = Average Absorption Coefficient
%   AlphaK = Absorption Coefficient Lab
%   AlphakLab = Absorption Coefficient In-Situ
%
% USAGE Example:
%   [AlphaK,AlphakLab,AlphAvg] = AbsorptionCoefficient(ElementMass,fc,fref,Kij,fcj);
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Absorption Coefficient (Alpha)

fref = 1000;

%  Case-I: Average Absorption Coefficient (for heavy constructions (around 400 kg/m2))
AlphAvg = 0.15;
%
%  Case-II: Average Absorption Coefficient for Laboratory (for a heavy frame of 600 mm concrete around the test opening)
Chi = sqrt(31.1/fc);
Psy = 44.3 * (fc ./ Mass);
Alpha = (1 / 3) .* ((2 * sqrt(Chi.*Psy) .* (1 + Chi) .* (1 + Psy)) ./ (Chi .* (1 + Psy).^2 + 2 * Psy * (1 + Chi.^2))).^2;
AlphakLab = Alpha .* (1 - 0.9999 * Alpha);
%
%  Case-III: Absorption Coefficient for in-Situ (between 0.05 and 0.5)
%  fcj = {[fcSWall2,fcRWall2];[fcSWall3,fcRWall3];[fcRWall4,fc,fcSWall4];[fcSWall5,fc,fcRWall5]};
KIJ = 0;
% if strcmp(Geo,'GeoUnity34')
%     for perimeter = 1:4
%
%         KIJUnity = Elements.Kij{perimeter,:};
%         fcjUnity = Elements.fcj{perimeter,:};
%
%         %Perimt(j) = sqrt(fcj{perimeter,1}(j)./fref).*(10.^(-KIJ(j)/10));
%         AlphaKSitu(perimeter)  = sum(sqrt(fcjUnity./fref).*(10.^(-KIJUnity/10)));
%         Kijs(perimeter,:) = KIJUnity;
%     end
% end

for perimeter = 1:4
    Junc = Kij{perimeter, 1};
    [RowKIJ, ColumKIJ] = size(Junc);
    if RowKIJ == 4
        if strcmp(WallID, 'Partion') || strcmp(WallID, 'SWallC') || strcmp(WallID, 'RWallC')
            KIJ = Junc(2, :);
        elseif strcmp(WallID, 'SWallR') || strcmp(WallID, 'SWallL') || strcmp(WallID, 'SWallB') || strcmp(WallID, 'SWallF')
            KIJ = Junc(2, :);
        elseif strcmp(WallID, 'RWallR') || strcmp(WallID, 'RSWallL') || strcmp(WallID, 'RSWallB') || strcmp(WallID, 'RWallF')
            KIJ = Junc(3, :);
        else
            KIJ = Junc(1, :);
        end
    elseif RowKIJ == 3
        if strcmp(WallID, 'Partion') || strcmp(WallID, 'SWallC') || strcmp(WallID, 'RWallC')
            KIJ = Junc(2, :);
        elseif strcmp(WallID, 'SWallR') || strcmp(WallID, 'SWallL')
            KIJ = Junc(1, :);
        elseif strcmp(WallID, 'SWallB') || strcmp(WallID, 'SWallF')
            KIJ = Junc(2, :);
        elseif strcmp(WallID, 'RWallR') || strcmp(WallID, 'RSWallL')
            KIJ = Junc(3, :);
        elseif strcmp(WallID, 'RSWallB') || strcmp(WallID, 'RWallF')
            KIJ = Junc(2, :);
        else
            KIJ = Junc(1, :);
        end
    elseif RowKIJ == 2
        KIJ = Junc(1, :);
    end
    for j = 1:ColumKIJ
            Perimt(j) = sqrt(fcj{perimeter, 1}(j)./fref) .* (10.^(-KIJ(j) / 10));
        %
    end
    AlphaKSitu(perimeter) = sum(Perimt);
    Perimt = 0;
end

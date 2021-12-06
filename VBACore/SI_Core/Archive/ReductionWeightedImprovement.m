function [DeltaRwSitu, DeltaRw, DeltaRASitu, DeltaRA, DeltaRAtrSitu, DeltaRAtr] = ReductionWeightedImprovement ...
    (Elements, LayerP, LayerType, Lining, Anchors, GlueArea, SperGlued)
%
% This Function Calculates the Sound reduction index improvement of additional layers
% for airborne in accordance with ISO 717-1
% The improvement in sound reduction by a layer, such as a resiliently mounted wall lining,
% thermal insulation system, floating floor or suspended ceiling, is in principle different
% for flanking transmission and airborne direct transmission and depends additionally on the
% type of basic structural elements it is applied to. It should therefore be determined by
% measurements in a laboratory, both for direct and flanking transmission, with the same basic
% structural element as is applied in the field situation considered.
% For the time being there is a standardized measurement method available for airborne
% direct transmission, but none for flanking transmission, nor an accurate possibilities to
% derive the effect for flanking transmission from the one for airborne direct transmission
% or to correct results for changes in the basic structural element. Information is given in
% this annex for a realistic and practical approach.
%
% INPUTS:
%   Rw = Weighted sound reduction fo Basic Element at wichi the LAyer is attached
%   MassElement = Mass of Basic Element
%   MLayer = Mass of Additional layer
%   Stiff = Dynamic stiffness of the insulation layer in meganewtons per cubic metres
%   LiningMaterial = Type of Lining Material from on of them ('MineralWoll', 'Foams', 'StudsMetal')
%   LayerType = 1: For elements where the insulation layer is fixed directly to the basic construction (without studs or battens)
%               2: For additional layers built with metal or wooden studs or battens not directly connected to the basic structural element
%                  where the cavity is filled with a porous insulation layer with an air resistivity r = 5 kPas/m2
%   Lining = 'Interior' or 'Exterior'
%   Anchors = true: If anchors or battens are applied, (4/m2 to 10/m2), different from the reference situation, the correction true
%   GlueArea = true: If the glued area differs from 40 % as in the reference situation, the correction true
%   SperGlued = 40 (Defaults): The percentage of the area over which the layer is glued to the basic element
%
% OUTPUTS:
%   DeltaRw = Weighted Sound Reduction Improvement of additional layers
%
% USAGE Example:
%   [DeltaRw,DeltaRA,DeltaRAtr] = ReductionWeightedImprovement(Rw,MEle,MLayer,Stiff,'MineralWoll',1,'Interior',false,false,40);
%
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Weighted sound reduction Improvement of additional layers
%
d = 0.0035;
Rw = Elements.Rw;
MassElement = Elements.Mass;
MLayer = LayerP.Mass;
Stiff = LayerP.Stifness * 1000000;
LiningMaterial = LayerP.Type;

% Type1: Depending on Stiffness of the Layers
fo1 = (1 / (2 * pi)) .* (sqrt(Stiff.*(1 ./ MassElement + 1 ./ MLayer)));
% Type2:
fo2 = (1 / (2 * pi)) .* (sqrt((0.111 ./ d).*(1 ./ MassElement + 1 ./ MLayer)));
if LayerType == 1
    Fo = fo1;
elseif LayerType == 2
    Fo = fo2;
end
% Prediction of performance for interior linings
if strcmp(Lining, 'Interior')
    if (Rw >= 20 && Rw <= 60)
        if (Fo >= 30 && Fo <= 160)
            DeltaRw = 74.4 - 20 * log10(Fo) - Rw / 2;
        elseif Fo == 200
            DeltaRw = -1;
        elseif Fo == 250
            DeltaRw = -3;
        elseif Fo == 315
            DeltaRw = -5;
        elseif Fo == 400
            DeltaRw = -7;
        elseif Fo == 500
            DeltaRw = -9;
        elseif Fo >= 630 && Fo <= 1600
            DeltaRw = -10;
        elseif Fo > 1600 && Fo <= 5000
            DeltaRw = -5;
        else
            DeltaRw = 0;
        end
    else
        DeltaRw = 0;
    end
    % Prediction of performance for exterior linings
elseif (MassElement >= 350 && strcmp(Lining, 'Exterior'))
    switch LiningMaterial
        case 'MineralWoll' % Mineral wool >= -4
            DeltaRw = -36 * log10(Fo) + 82.5;
            DeltaRw(DeltaRw < -4) = -4;
            DeltaRA = -42 * log10(Fo) + 92;
            DeltaRA(DeltaRA < -4) = -4;
            DeltaRAtr = -39 * log10(Fo) + 87.7;
            DeltaRAtr(DeltaRAtr < -4) = -4;
        case 'Foams' % Foam lie polystyrene (PS), extruded polystyrene (EPS) or elastified extruded polystyrene (EEPS) >= -3
            DeltaRw = -33 * log10(Fo) + 76;
            DeltaRw(DeltaRw < -3) = -3;
            DeltaRA = -33 * log10(Fo) + 74;
            DeltaRA(DeltaRA < -3) = -3;
            DeltaRAtr = -36 * log10(Fo) + 77;
            DeltaRAtr(DeltaRAtr < -3) = -3;
        case 'StudsMetal' % Additional layers built with metal or wooden studs or battens not directly connected to the basic structural element
            DeltaRw = -20 * log10(Fo) + 48;
            DeltaRw(DeltaRw < -4) = -4;
            DeltaRA = -22 * log10(Fo) + 51;
            DeltaRA(DeltaRA < -4) = -4;
            DeltaRAtr = -24 * log10(Fo) + 54;
            DeltaRAtr(DeltaRAtr < -4) = -4;
    end
    if Anchors && (strcmp(LiningMaterial, 'MineralWoll') || strcmp(LiningMaterial, 'Foams'))
        DeltaRw = 0.66 * DeltaRw - 1.2;
        DeltaRA = 0.62 * DeltaRA - 1.3;
        DeltaRAtr = 0.54 * DeltaRAtr - 1.6;
    end
    if GlueArea && (strcmp(LiningMaterial, 'MineralWoll') || strcmp(LiningMaterial, 'Foams'))
        DeltaRw = DeltaRw - 0.05 * SperGlued + 2;
        DeltaRA = DeltaRA - 0.05 * SperGlued + 2;
        DeltaRAtr = DeltaRAtr - 0.05 * SperGlued + 2;
    end
end
% Data transfer to field situation
A = (1.35 * log10(Fo) - 3.5);
A(A > 0) = 0;
X = Rw - 53;
X(X > 7) = 7;
X(X < -10) = -10;
DeltaRwSitu = DeltaRw + A * X;
DeltaRASitu = DeltaRA + A * X;
DeltaRAtrSitu = DeltaRAtr + A * X;
%

function [KIJ] = VibTranJunctionHeavysV2(J, ElementID, Method)
%
% This Function Calculates the Vibration transmission over junctions: Case of heavy buildings Kij
%
% INPUTS:
%   ElementMass = Mass of the Partioning in Kg/m2 (e.g.: 460)
%   PerperMass = Mass of the Perperndicular Element in Kg/m2 (e.g.: 460)
%   fc = Critcal Frequre of the element for that the Absorpotion is required
%   fref = Reference Frequency (1000 Hz)
%   fcj = Critcal Frequre of j-th Element
%
% OUTPUTS:
%   Kij = Vibration transmission over junctions (Matrix conatining all paths from i-th element to j-th element)
%
% USAGE Example:
%   [AlphAvg,Alphak,Alpha] = AbsorptionCoefficient(ElementMass,fc,fref,Kij,fcj);
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Vibration Transmission over junctions: Case of heavy buildings Kij
%
load GeoData
if ElementID == 1
    JunctionAttched = {J{1}, J{2}, J{3}, J{4}};
    JunctionAttched{1}.Elements = [MSWall2, MEle];
    JunctionAttched{2}.Elements = [MSWall3, MEle];
    JunctionAttched{3}.Elements = [MEle, MSWall4];
    JunctionAttched{4}.Elements = [MEle, MSWall5];
elseif ElementID == 2
    JunctionAttched = {J{1}, J{5}, J{8}, J{9}};
    JunctionAttched{1}.Elements = [MSWall2, MEle];
    JunctionAttched{2}.Elements = [MSWall2, MSWall3];
    JunctionAttched{3}.Elements = [MSWall2, MSWall5];
    JunctionAttched{4}.Elements = [MSWall2, MEle];
elseif ElementID == 3
    JunctionAttched = {J{2}, J{5}, J{6}, J{10}};
    JunctionAttched{1}.Elements = [MSWall3, MEle];
    JunctionAttched{2}.Elements = [MSWall3, MSWall2];
    JunctionAttched{3}.Elements = [MSWall3, MSWall4];
    JunctionAttched{4}.Elements = [MSWall3, MEle];
elseif ElementID == 4
    JunctionAttched = {J{3}, J{6}, J{7}, J{11}};
    JunctionAttched{1}.Elements = [MSWall4, MEle];
    JunctionAttched{2}.Elements = [MSWall4, MSWall3];
    JunctionAttched{3}.Elements = [MSWall4, MSWall5];
    JunctionAttched{4}.Elements = [MSWall4, MEle];
elseif ElementID == 5
    JunctionAttched = {J{4}, J{7}, J{8}, J{12}};
    JunctionAttched{1}.Elements = [MSWall5, MEle];
    JunctionAttched{2}.Elements = [MSWall5, MSWall4];
    JunctionAttched{3}.Elements = [MSWall5, MSWall2];
    JunctionAttched{4}.Elements = [MSWall5, MEle];
elseif ElementID == 6
    JunctionAttched = {J{9}, J{10}, J{11}, J{12}};
    JunctionAttched{1}.Elements = [MEle, MSWall2];
    JunctionAttched{2}.Elements = [MEle, MSWall3];
    JunctionAttched{3}.Elements = [MEle, MSWall4];
    JunctionAttched{4}.Elements = [MEle, MSWall5];
elseif ElementID == 7
    JunctionAttched = {J{1}, J{17}, J{13}, J{20}};
    JunctionAttched{1}.Elements = [MRWall2, MEle];
    JunctionAttched{2}.Elements = [MRWall2, MRWall3];
    JunctionAttched{3}.Elements = [MRWall2, MEle];
    JunctionAttched{4}.Elements = [MRWall2, MRWall5];
elseif ElementID == 8
    JunctionAttched = {J{2}, J{17}, J{14}, J{18}};
    JunctionAttched{1}.Elements = [MEle, MRWall3];
    JunctionAttched{2}.Elements = [MRWall3, MRWall2];
    JunctionAttched{3}.Elements = [MRWall3, MEle];
    JunctionAttched{4}.Elements = [MRWall3, MRWall4];
elseif ElementID == 9
    JunctionAttched = {J{3}, J{18}, J{15}, J{19}};
    JunctionAttched{1}.Elements = [MRWall4, MEle];
    JunctionAttched{2}.Elements = [MRWall4, MRWall2];
    JunctionAttched{3}.Elements = [MRWall4, MEle];
    JunctionAttched{4}.Elements = [MRWall4, MRWall4];
elseif ElementID == 10
    JunctionAttched = {J{4}, J{19}, J{16}, J{20}};
    JunctionAttched{1}.Elements = [MRWall5, MEle];
    JunctionAttched{2}.Elements = [MRWall5, MRWall4];
    JunctionAttched{3}.Elements = [MRWall5, MEle];
    JunctionAttched{4}.Elements = [MRWall5, MRWall2];
elseif ElementID == 11
    JunctionAttched = {J{13}, J{14}, J{15}, J{16}};
    JunctionAttched{1}.Elements = [MEle, MRWall2];
    JunctionAttched{2}.Elements = [MEle, MRWall3];
    JunctionAttched{3}.Elements = [MEle, MRWall4];
    JunctionAttched{4}.Elements = [MEle, MRWall5];
end
%
for ii = 1:4
    JunctionsType = JunctionAttched{ii}.Type;
    AttachedMass = JunctionAttched{ii}.Elements;
    if strcmp(Method, 'Empirical')
        switch JunctionsType
            case 'CrossJunction'
                MK12Ratio = (log10(AttachedMass(2)./AttachedMass(1)));
                K12 = 8.7 + 5.7 * MK12Ratio.^2;
                MK13Ratio = (log10(AttachedMass(2)./AttachedMass(1)));
                K13 = 8.7 + 17.1 * MK13Ratio + 5.7 * MK13Ratio.^2;
                K14 = K12;
                K21 = K12;
                K23 = K12;
                MK24Ratio = (log10(AttachedMass(2)./AttachedMass(1)));
                if ElementID == 1
                    MK24Ratio = abs(MK24Ratio);
                else
                end
                K24 = 8.7 + 17.1 * MK24Ratio + 5.7 * MK24Ratio.^2;
                K31 = K13;
                K32 = K23;
                K34 = K12;
                K41 = K14;
                K42 = K24;
                K43 = K34;
                Kij = [K12, K13, K14; K21, K23, K24; K31, K32, K34; K41, K42, K43];
            case 'TJunction'
                MK12Ratio = (log10(AttachedMass(2)./AttachedMass(1)));
                K12 = 5.7 + 5.7 * MK12Ratio.^2;
                MK13Ratio = (log10(AttachedMass(2)./AttachedMass(1)));
                if ElementID == 4 || ElementID == 5
                    MK13Ratio = abs(MK13Ratio);
                else
                end
                K13 = 5.7 + 14.1 * MK13Ratio + 5.7 * MK13Ratio.^2;
                K21 = K12;
                K23 = K12;
                K31 = K13;
                K32 = K23;
                Kij = [K12, K13; K21, K23; K31, K32];
            case 'WallJunctionFlexibleInterLayer'
                % Under Constructionnm,mn              K24 = 3.0+14.1*MRatio+5.7*MRatio.^2;
                MRatio = (log10(AttachedMass(1)./AttachedMass(2)));
                K12 = 10 + 10 * MRatio + 3.3 * log10(f./fk);
                K14 = K12;
                K23 = K12;
                K34 = K12;
                Kij = [K12, K23, K14, K34];
            case 'LightDoubleLeafWallHomoL'
                MRatio = (log10(AttachedMass(1)./AttachedMass(2)));
                fk = 500;
                K12 = 10 + 10 * MRatio + 3.3 * log10(f./fk);
                K14 = K12;
                Kij = [K12, K14];
            case 'LCorner'
                MRatio = (log10(AttachedMass(1)./AttachedMass(2)));
                K12 = 15 * MRatio - 3;
                K12(K12 < -2) = -2;
                K21 = K12;
                Kij = [K12; K21];
            case 'Thinkness'
                MRatio = (log10(AttachedMass(1)./AttachedMass(2)));
                K12 = 5 * MRatio.^2 - 5;
                K21 = K12;
                Kij = [K12; K21];
            otherwise
                error('Select JunctionsType')
        end
        KIJ(ii, :) = {Kij};
        %
    elseif strcmp(Method, 'Numerical')
        % Data from simulations Structure-borne power transmission loss expressions for
        % L, T and X-junctions as a function of PC
        Type1 = JunctionsType{6};
        for i = 1:length(f)
            switch Type1
                case 'LCorner'
                    if (f(i) >= 50 && f(i) <= 200)
                        Mip = [];
                        MEle = [];
                        % fcc = (c0.^2/pi).*sqrt((3*M*(1-v.^2))./(E*Th.^3));
                        fcc = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        fccP = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        PCRatio = (Mip / MEle) ./ ((fcc ./ fccP).^3 / 2);
                        % PCRatio = (Mp/MEle)./((ThP*cL)./(Th*cL)).^3/2;
                        PC = log10(PCRatio);
                        GamaFact12(i) = -0.8 * PC.^3 + 5 * PC.^2 + 1.5 * PC + 5.9;
                    elseif (f(i) >= 250 && f(i) <= 5000)
                        Mip = [];
                        MEle = [];
                        % fcc = (c0.^2/pi).*sqrt((3*M*(1-v.^2))./(E*Th.^3));
                        fcc = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        fccP = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        PCRatio = (Mip / MEle) ./ ((fcc ./ fccP).^3 / 2);
                        % PCRatio = (Mp/MEle)./((ThP*cL)./(Th*cL)).^3/2;
                        PC = log10(PCRatio);
                        GamaFact12(i) = -0.24 * PC.^3 + 3 * PC.^2 + 1 * PC + 9.5;
                    end
                case 'TJunction'
                    if (f(i) >= 50 && f(i) <= 200)
                        Mip = [];
                        MEle = [];
                        % fcc = (c0.^2/pi).*sqrt((3*M*(1-v.^2))./(E*Th.^3));
                        fcc = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        fccP = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        PCRatio = (Mip / MEle) ./ ((fcc ./ fccP).^3 / 2);
                        % PCRatio = (Mp/MEle)./((ThP*cL)./(Th*cL)).^3/2;
                        PC = log10(PCRatio);
                        GamaFact12(i) = -0.4 * PC.^3 + 4.8 * PC.^2 + 1.4 * PC + 9.4;
                        GamaFact13(i) = -0.3 * PC.^3 + 4.5 * PC.^2 + 7.5 * PC + 8.9;
                        GamaFact23 = GamaFact12;
                    elseif (f(i) >= 250 && f(i) <= 1000)
                        Mip = [];
                        MEle = [];
                        % fcc = (c0.^2/pi).*sqrt((3*M*(1-v.^2))./(E*Th.^3));
                        fcc = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        fccP = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        PCRatio = (Mip / MEle) ./ ((fcc ./ fccP).^3 / 2);
                        % PCRatio = (Mp/MEle)./((ThP*cL)./(Th*cL)).^3/2;
                        PC = log10(PCRatio);
                        GamaFact12(i) = -0.43 * PC.^3 + 3.8 * PC.^2 + 0.3 * PC + 11.5;
                        GamaFact13(i) = -0.2 * PC.^3 + 1.3 * PC.^2 + 6.9 * PC + 9.1;
                        GamaFact23 = GamaFact12;
                    elseif (f(i) >= 1250 && f(i) <= 5000)
                        GamaFact12(i) = -0.43 * PC.^3 + 3.8 * PC.^2 + 0.3 * PC + 11.5;
                        GamaFact13(i) = -0.04 * PC.^3 + 1 * PC.^2 + 4.5 * PC + 5;
                        GamaFact23 = GamaFact12;
                    end
                case 'CrossJunction'
                    if (f(i) >= 50 && f(i) <= 200)
                        GamaFact12(i) = -0.5 * PC.^3 + 4.1 * PC.^2 + 1.4 * PC + 12.5;
                        GamaFact13(i) = -0.2 * PC.^3 + 3.7 * PC.^2 + 10.3 * PC + 11.7;
                        GamaFact23 = GamaFact12;
                        GamaFact14 = GamaFact12;
                        GamaFact34 = GamaFact12;
                    elseif (f(i) >= 250 && f(i) <= 1000)
                        GamaFact12(i) = -0.5 * PC.^3 + 4.1 * PC.^2 + 1.4 * PC + 12.5;
                        GamaFact13(i) = 0.03 * PC.^3 + 1.8 * PC.^2 + 8.8 * PC + 11.4;
                        GamaFact23 = GamaFact12;
                        GamaFact14 = GamaFact12;
                        GamaFact34 = GamaFact12;
                    elseif (f(i) >= 1250 && f(i) <= 5000)
                        GamaFact12(i) = -0.5 * PC.^3 + 4.1 * PC.^2 + 1.4 * PC + 12.5;
                        GamaFact13(i) = 0.2 * PC.^3 + 1.4 * PC.^2 + 5.9 * PC + 7.3;
                        GamaFact23 = GamaFact12;
                        GamaFact14 = GamaFact12;
                        GamaFact34 = GamaFact12;
                    end
                otherwise
            end
        end
    end
end

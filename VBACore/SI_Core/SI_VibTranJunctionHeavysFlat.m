function [KIJ, PrepMass] = SI_VibTranJunctionHeavysFlat(Element, Method, Geo)
%
% This Function Calculates the Vibration transmission over junctions: Case of heavy buildings Kij
%
% INPUTS:
%   ElementID = Element ID for with to calculate Kij
%   Method = 'Empirical' or 'Numerical'
%
% OUTPUTS:
%   Kij = Vibration transmission over junctions (Matrix conatining all paths from i-th element to j-th element)
%
% USAGE Example:
%   [KIJ] = VibTranJunctionHeavysV1(PartionID,'Empirical');
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Vibration Transmission over junctions: Case of heavy buildings Kij
%
ElementID = Element.ID;
JunctionsType = {'CrossJunction', 'TJunction', 'WallJunctionFlexibleInterLayer', ...
    'LightDoubleLeafWallHomoX', 'LightDoubleLeafWallHomoL', 'LCorner', 'Thinkness', ...
    'TJunctionFloor:Faced', 'XJunctionFloorDouble', 'TJunctionFloor:Double', 'XJunctionFloor:Countinuous'};

if strcmp(Geo, 'GeometriesFlat') || strcmp(Geo, 'Geo34')
    if strcmp(Geo, 'Geo34')
        Geo34;
    elseif strcmp(Geo, 'GeometriesFlat')
        GeometriesFlat;
    end
    % Define All Junctions for teh Flat
    J1.Type = JunctionsType{2};
    J2.Type = JunctionsType{1};
    J3.Type = JunctionsType{2};
    J4.Type = JunctionsType{2};
    J5.Type = JunctionsType{6};
    J6.Type = JunctionsType{2};
    J7.Type = JunctionsType{2};
    J8.Type = JunctionsType{6};
    J9.Type = JunctionsType{2};
    J10.Type = JunctionsType{2};
    J11.Type = JunctionsType{2};
    J12.Type = JunctionsType{2};
    J13.Type = JunctionsType{6};
    J14.Type = JunctionsType{2};
    J15.Type = JunctionsType{2};
    J16.Type = JunctionsType{6};
    J17.Type = JunctionsType{6};
    J18.Type = JunctionsType{2};
    J19.Type = JunctionsType{6};
    J20.Type = JunctionsType{6};
    J = {J1, J2, J3, J4, J5, J6, J7, J8, J9, J10, J11, J12, J13, J14, J15, J16, J17, J18, J19, J20};
end
if strcmp(Geo, 'Geo12')
    Geo12;
    % Define All Junctions for teh Flat
    J1.Type = JunctionsType{6};
    J2.Type = JunctionsType{2};
    J3.Type = JunctionsType{6};
    J4.Type = JunctionsType{6};
    J5.Type = JunctionsType{6};
    J6.Type = JunctionsType{2};
    J7.Type = JunctionsType{2};
    J8.Type = JunctionsType{6};
    J9.Type = JunctionsType{2};
    J10.Type = JunctionsType{1};
    J11.Type = JunctionsType{2};
    J12.Type = JunctionsType{2};
    J13.Type = JunctionsType{6};
    J14.Type = JunctionsType{2};
    J15.Type = JunctionsType{2};
    J16.Type = JunctionsType{6};
    J17.Type = JunctionsType{6};
    J18.Type = JunctionsType{2};
    J19.Type = JunctionsType{6};
    J20.Type = JunctionsType{6};
    J = {J1, J2, J3, J4, J5, J6, J7, J8, J9, J10, J11, J12, J13, J14, J15, J16, J17, J18, J19, J20};
end
if strcmp(Geo, 'Geo23')
    Geo23;
    % Define All Junctions for the Flat
    J1.Type = JunctionsType{6};
    J2.Type = JunctionsType{2};
    J3.Type = JunctionsType{6};
    J4.Type = JunctionsType{6};
    J5.Type = JunctionsType{6};
    J6.Type = JunctionsType{2};
    J7.Type = JunctionsType{2};
    J8.Type = JunctionsType{6};
    J9.Type = JunctionsType{2};
    J10.Type = JunctionsType{1};
    J11.Type = JunctionsType{2};
    J12.Type = JunctionsType{2};
    J13.Type = JunctionsType{6};
    J14.Type = JunctionsType{2};
    J15.Type = JunctionsType{6};
    J16.Type = JunctionsType{6};
    J17.Type = JunctionsType{6};
    J18.Type = JunctionsType{2};
    J19.Type = JunctionsType{6};
    J20.Type = JunctionsType{6};
    J = {J1, J2, J3, J4, J5, J6, J7, J8, J9, J10, J11, J12, J13, J14, J15, J16, J17, J18, J19, J20};
end
if strcmp(Geo, 'GeoUnity34') || strcmp(Geo, 'Geo34') || strcmp(Geo, 'GeometriesFlat')
    % Define All Junctions for the Flat
    if strcmp(Geo, 'Geo34')
        Geo34;
    elseif strcmp(Geo, 'GeoUnity34')
        GeoUnity34;
    end
    %     JunctionAttched = {Element.Junctions(1,1), Element.Junctions(1,2), Element.Junctions(1,3), Element.Junctions(1,4)};
    %     JunctionAttched{1}.Elements = [Element.Mass, Element.Unity.PrepMass(1,1)];
    %     JunctionAttched{2}.Elements = [Element.Mass, Element.Unity.PrepMass(1,2)];
    %     JunctionAttched{3}.Elements = [Element.Mass, Element.Unity.PrepMass(1,3)];
    %     JunctionAttched{4}.Elements = [Element.Mass, Element.Unity.PrepMass(1,4)];
    % else
    if strcmp(ElementID, 'Partion')
        JunctionAttched = {J{9}, J{10}, J{11}, J{12}};
        JunctionAttched{1}.Elements = [Partion.Mass, SWallF.Mass];
        JunctionAttched{2}.Elements = [Partion.Mass, SWallL.Mass];
        JunctionAttched{3}.Elements = [Partion.Mass, SWallC.Mass];
        JunctionAttched{4}.Elements = [Partion.Mass, SWallR.Mass];
    elseif strcmp(ElementID, 'SWallR')
        JunctionAttched = {J{4}, J{5}, J{12}, J{8}};
        JunctionAttched{1}.Elements = [SWallR.Mass, SWallB.Mass];
        JunctionAttched{2}.Elements = [SWallR.Mass, SWallF.Mass];
        JunctionAttched{3}.Elements = [SWallR.Mass, Partion.Mass];
        JunctionAttched{4}.Elements = [SWallR.Mass, SWallC.Mass];
    elseif strcmp(ElementID, 'SWallL')
        JunctionAttched = {J{2}, J{6}, J{10}, J{7}};
        JunctionAttched{1}.Elements = [SWallL.Mass, SWallB.Mass];
        JunctionAttched{2}.Elements = [SWallL.Mass, SWallF.Mass];
        JunctionAttched{3}.Elements = [SWallL.Mass, Partion.Mass];
        JunctionAttched{4}.Elements = [SWallL.Mass, SWallC.Mass];
    elseif strcmp(ElementID, 'SWallB')
        JunctionAttched = {J{1}, J{2}, J{3}, J{4}};
        JunctionAttched{1}.Elements = [SWallB.Mass, SWallF.Mass];
        JunctionAttched{2}.Elements = [SWallB.Mass, SWallL.Mass];
        JunctionAttched{3}.Elements = [SWallB.Mass, SWallC.Mass];
        JunctionAttched{4}.Elements = [SWallB.Mass, SWallR.Mass];
    elseif strcmp(ElementID, 'SWallF')
        JunctionAttched = {J{1}, J{5}, J{9}, J{6}};
        JunctionAttched{1}.Elements = [SWallF.Mass, SWallB.Mass];
        JunctionAttched{2}.Elements = [SWallF.Mass, SWallR.Mass];
        JunctionAttched{3}.Elements = [SWallF.Mass, Partion.Mass];
        JunctionAttched{4}.Elements = [SWallF.Mass, SWallL.Mass];
    elseif strcmp(ElementID, 'SWallC')
        JunctionAttched = {J{3}, J{8}, J{11}, J{7}};
        JunctionAttched{1}.Elements = [SWallC.Mass, SWallB.Mass];
        JunctionAttched{2}.Elements = [SWallC.Mass, SWallR.Mass];
        JunctionAttched{3}.Elements = [SWallC.Mass, Partion.Mass];
        JunctionAttched{4}.Elements = [SWallC.Mass, SWallL.Mass];
    elseif strcmp(ElementID, 'RWallR')
        JunctionAttched = {J{12}, J{13}, J{20}, J{16}};
        JunctionAttched{1}.Elements = [RWallR.Mass, Partion.Mass];
        JunctionAttched{2}.Elements = [RWallR.Mass, RWallF.Mass];
        JunctionAttched{3}.Elements = [RWallR.Mass, RWallB.Mass];
        JunctionAttched{4}.Elements = [RWallR.Mass, RWallC.Mass];
    elseif strcmp(ElementID, 'RWallL')
        JunctionAttched = {J{10}, J{14}, J{18}, J{15}};
        JunctionAttched{1}.Elements = [RWallL.Mass, Partion.Mass];
        JunctionAttched{2}.Elements = [RWallL.Mass, RWallF.Mass];
        JunctionAttched{3}.Elements = [RWallL.Mass, RWallB.Mass];
        JunctionAttched{4}.Elements = [RWallL.Mass, RWallC.Mass];
    elseif strcmp(ElementID, 'RWallB')
        JunctionAttched = {J{17}, J{18}, J{19}, J{20}};
        JunctionAttched{1}.Elements = [RWallB.Mass, RWallF.Mass];
        JunctionAttched{2}.Elements = [RWallB.Mass, RWallL.Mass];
        JunctionAttched{3}.Elements = [RWallB.Mass, RWallC.Mass];
        JunctionAttched{4}.Elements = [RWallB.Mass, RWallR.Mass];
    elseif strcmp(ElementID, 'RWallF')
        JunctionAttched = {J{9}, J{13}, J{17}, J{14}};
        JunctionAttched{1}.Elements = [RWallF.Mass, Partion.Mass];
        JunctionAttched{2}.Elements = [RWallF.Mass, RWallR.Mass];
        JunctionAttched{3}.Elements = [RWallF.Mass, RWallB.Mass];
        JunctionAttched{4}.Elements = [RWallF.Mass, RWallL.Mass];
    elseif strcmp(ElementID, 'RWallC')
        JunctionAttched = {J{11}, J{16}, J{19}, J{15}};
        JunctionAttched{1}.Elements = [RWallC.Mass, Partion.Mass];
        JunctionAttched{2}.Elements = [RWallC.Mass, RWallR.Mass];
        JunctionAttched{3}.Elements = [RWallC.Mass, RWallB.Mass];
        JunctionAttched{4}.Elements = [RWallC.Mass, RWallL.Mass];
    end
    PrepMass = [JunctionAttched{1}.Elements; JunctionAttched{2}.Elements; JunctionAttched{3}.Elements; JunctionAttched{4}.Elements];
    
end


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
        for i = 1:length(f)
            switch JunctionsType
                case 'LCorner'
                    if (f(i) >= 50 && f(i) <= 200)
                        Mip = [];
                        Partion.Mass = [];
                        % fcc = (c0.^2/pi).*sqrt((3*M*(1-v.^2))./(E*Th.^3));
                        fcc = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        fccP = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        PCRatio = (Mip / Partion.Mass) ./ ((fcc ./ fccP).^3 / 2);
                        % PCRatio = (Mp/Partion.Mass)./((ThP*cL)./(Th*cL)).^3/2;
                        PC = log10(PCRatio);
                        GamaFact12(i) = -0.8 * PC.^3 + 5 * PC.^2 + 1.5 * PC + 5.9;
                    elseif (f(i) >= 250 && f(i) <= 5000)
                        Mip = [];
                        Partion.Mass = [];
                        % fcc = (c0.^2/pi).*sqrt((3*M*(1-v.^2))./(E*Th.^3));
                        fcc = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        fccP = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        PCRatio = (Mip / Partion.Mass) ./ ((fcc ./ fccP).^3 / 2);
                        % PCRatio = (Mp/Partion.Mass)./((ThP*cL)./(Th*cL)).^3/2;
                        PC = log10(PCRatio);
                        GamaFact12(i) = -0.24 * PC.^3 + 3 * PC.^2 + 1 * PC + 9.5;
                    end
                case 'TJunction'
                    if (f(i) >= 50 && f(i) <= 200)
                        Mip = [];
                        Partion.Mass = [];
                        % fcc = (c0.^2/pi).*sqrt((3*M*(1-v.^2))./(E*Th.^3));
                        fcc = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        fccP = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        PCRatio = (Mip / Partion.Mass) ./ ((fcc ./ fccP).^3 / 2);
                        % PCRatio = (Mp/Partion.Mass)./((ThP*cL)./(Th*cL)).^3/2;
                        PC = log10(PCRatio);
                        GamaFact12(i) = -0.4 * PC.^3 + 4.8 * PC.^2 + 1.4 * PC + 9.4;
                        GamaFact13(i) = -0.3 * PC.^3 + 4.5 * PC.^2 + 7.5 * PC + 8.9;
                        GamaFact23 = GamaFact12;
                    elseif (f(i) >= 250 && f(i) <= 1000)
                        Mip = [];
                        Partion.Mass = [];
                        % fcc = (c0.^2/pi).*sqrt((3*M*(1-v.^2))./(E*Th.^3));
                        fcc = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        fccP = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
                        PCRatio = (Mip / Partion.Mass) ./ ((fcc ./ fccP).^3 / 2);
                        % PCRatio = (Mp/Partion.Mass)./((ThP*cL)./(Th*cL)).^3/2;
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

function [KIJ, DVIJN] = VibTranJunctionLight(ElementID, f, Charac)
%
% This Function Calculates the Vibration transmission over junctions: Case
% of Light buildings Kij and Dv,ij,n
%
% INPUTS:
%   f = Frequre band
%   Charac = true: if calculation from Kij
%          = false: if calculation form Dvijn
% OUTPUTS:
%   Kij = Vibration transmission over junctions (Matrix conatining all paths from i-th element to j-th element)
%   Dvijn
%
% USAGE Example:
%   [Kij,Dvijn] = VibTranJunctionLight(f,true);
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Vibration transmission over junctions: Case of lightweight buildings
load GeoData
JunctionsType = {'CrossJunction', 'TJunction', 'TJunctionFloor:Faced', ...
    'XJunctionFloorDouble', 'TJunctionFloor:Double', 'XJunctionFloor:Countinuous', 'TimberFrameLightBuilding:Double'};
%
J1.Type = JunctionsType{3};
J2.Type = JunctionsType{4};
J3.Type = JunctionsType{5};
J4.Type = JunctionsType{6};
J5.Type = JunctionsType{6};
J6.Type = JunctionsType{2};
J7.Type = JunctionsType{1};
J8.Type = JunctionsType{2};
J9.Type = JunctionsType{2};
J10.Type = JunctionsType{2};
J11.Type = JunctionsType{1};
J12.Type = JunctionsType{1};
J13.Type = JunctionsType{2};
J14.Type = JunctionsType{2};
J15.Type = JunctionsType{1};
J16.Type = JunctionsType{1};
J17.Type = JunctionsType{6};
J18.Type = JunctionsType{2};
J19.Type = JunctionsType{1};
J20.Type = JunctionsType{2};
J = {J1, J2, J3, J4, J5, J6, J7, J8, J9, J10, J11, J12, J13, J14, J15, J16, J17, J18, J19, J20};
%
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
% Type-I: Empirical data for junctions characterized by Kij
for jj = 1:4
    JunctionsType = JunctionAttched{jj}.Type;
    AttachedMass = JunctionAttched{jj}.Elements;
    if Charac
        switch JunctionsType
            case 'CrossJunction'
                for ii = 1:length(f)
                    fk = 500;
                    MRatio = 10 * log10(AttachedMass(2)./AttachedMass(1));
                    K12(ii) = 18 + 3.3 * log10(f(ii)./fk);
                    K13(ii) = 10 - 3.3 * log10(f(ii)./fk) + 10 * MRatio;
                    K14(ii) = K12(ii);
                    K21(ii) = K12(ii);
                    K23(ii) = K12(ii);
                    K24(ii) = 23 + 3.3 * log10(f(ii)./fk);
                    K31(ii) = K13(ii);
                    K32(ii) = K12(ii);
                    K34(ii) = K12(ii);
                end
                Kij = [K12; K13; K14; K21; K23; K24; K31; K32; K34];
            case 'TJunction'
                for kk = 1:length(f)
                    fk = 500;
                    K12(kk) = 15 + 3.3 * log10(f(kk)./fk);
                    K13(kk) = 22 + 3.3 * log10(f(kk)./fk);
                    K21(kk) = K12(kk);
                    K23(kk) = K12(kk);
                    K31(kk) = K13(kk);
                    K32(kk) = K12(kk);
                end
                Kij = [K12; K13; K21; K23; K31; K32];
            otherwise
        end
        KIJ(jj, :) = {Kij};
        DVIJN = 0;
    else
        % Type-II: Empirical data for junctions characterized by Dv,ij,n
        % Sub-Type-I: Timber frame lightweight building elements; inner leaf transmission
        % a) Floors in the range 30 kg/m2 to 70 kg/m2;
        % b) Façades in the range 25 kg/m2 to 45 kg/m2;
        % c) Double frame wall in the range 35 kg/m2 to 75 kg/m2;
        % d) Single frame partition in the range 20 kg/m2 to 40 kg/m2.
        %    Solid wood and CLT elements are excluded.
        switch JunctionsType
            case 'TJunctionFloor:Faced'
                for i = 1:length(f)
                    fk = 500; % Slope 3dB
                    Dv12n(i) = 30 + log10(f(i)./fk);
                    Dv13n(i) = Dv12n(i);
                end
                Dvijn = [Dv12n; Dv13n];
            case 'XJunctionFloorDouble'
                for i = 1:length(f)
                    fk = 500;
                    Dvij(i) = 38 + 13.3 * log10(f(i)./fk); % Any horizontal path through the cavity (except floor-floor)
                    Dv13n(i) = 36 + 3.3 * log10(f(i)./fk); % Floor-floor path
                    Dv12n(i) = 18 + 3.3 * log10(f(i)./fk); % Floor-separating wall
                    Dv24n(i) = 22 + 3.3 * log10(f(i)./fk); % Separating wall-separating wall
                end
                Dvijn = [Dvij; Dv12n; Dv13n; Dv24n];
            case 'TJunctionFloor:Double' % Any path through the cavity
                for i = 1:length(f)
                    fk = 500;
                    Dv12n(i) = 38 + 13.3 * log10(f(i)./fk);
                    Dv13n(i) = Dv12n(i);
                end
                Dvijn = [Dv12n; Dv13n];
            case 'XJunctionFloor:Countinuous'
                for i = 1:length(f)
                    % Floor-floor or floor-wall path
                    Dv13n(i) = 20 - 3.3 * log10(f(i)./fk);
                    Dv34n(i) = Dv13n(i);
                    % Wall-wall path
                    Dv24n(i) = 30 + 3.3 * log10(f(i)./fk);
                end
                Dvijn = [Dv13n; Dv34n; Dv24n];
            case 'TimberFrameLightBuilding:Double'
                
                for i = 1:length(f)
                    % Sub-Type-II: Timber frame lightweight building elements; double elements as a whole
                    Dv12n = 15 + 10 * abs(MRatio) - 3.3 * log10(f./fk);
                    Dv13n = 15 + 20 * MRatio - 3.3 * log10(f./fk);
                    Dv23n = Dv12n;
                end
                Dvijn = [Dv12n; Dv13n; Dv23n];
            otherwise
        end
        KIJ = 0;
        DVIJN(jj, :) = {Dvijn};
    end
end

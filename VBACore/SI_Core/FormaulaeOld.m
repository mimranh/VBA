    
%% ISO: EN 12354-1

%% Geometries and Elements Index
% (7) and (8) are Ceilings
%   ______________________________________________
%  |           2           |          6           |
%  |                       |                      |
%  |                       |                      |
%  |       (4)             |         (8)          |
%  |                     0 |                      |
%  |        3              |          7           |
%  |                       |                      |
%  |       Source          |      Receiver        |
%  |___________1___________|__________5___________|
%

%% Constants
c0 = 340; % Velocity of Sound in Air
Rho0 = 1.29; % Density of air ?0 (kg/m3)
M0 = 1; % Reference Mass
fref = 1000; % Reference Frequency
f = [50, 63, 80, 100, 125, 160, 200, 250, 315, 400, 500, 630, 800, 1000, 1250, 1600, 2000, 2500, 3150, 4000, 5000]; % Frequency Band 1/3 Oct
ko = (2 * pi * f) ./ c0; % Wave Number
Csab = 0.16; % Sabine constant

%% Material Properties, Dim and Geometry
%%%%%% Available Material %%%%%%
% Concrete, Calcium, AutoclavedConcrete, LightAggregateBlocks,
% DenseAggregateBlocks, Bricks, Plasterboard, Plasterboard2, Chipboard

Partion = MaterialProperties('Concrete');
% Source Room
SWall1 = MaterialProperties('Concrete');
SWall2 = MaterialProperties('Concrete');
SFloor = MaterialProperties('Concrete');
SRoof = MaterialProperties('Concrete');
% Receiver Room
RWall5 = MaterialProperties('Concrete');
RWall6 = MaterialProperties('Concrete');
RFloor = MaterialProperties('Concrete');
RRoof = MaterialProperties('Concrete');
% Additional Layer
Layer = MaterialProperties('Layer');

% Partion Properties
ReductionData = Partion.Reduction1;
PartionName = Partion.Type;
Rho = Partion.Density;
cL = Partion.QuasiLongPhaseVelocity;
EtaInitial = Partion.InternalLossFactor;
MEle = Partion.Mass1;
Th = Partion.Thickness1;
L2 = Partion.Length;
L1 = Partion.Width;
S = L1 * L2; % or S = 10
fc = (c0.^2) ./ (1.8 * cL * Th); % Critical Frequency
fceff = fc * (4.05 * Th .* f ./ cL + sqrt(1+4.05*Th.*f./cL).^2);

% SWall1 Properties
SWall1Name = SWall1.Type;
RhoSWall1 = SWall1.Density;
cLSWall1 = SWall1.QuasiLongPhaseVelocity;
EtaInitialSWall1 = SWall1.InternalLossFactor;
MSWall1 = SWall1.Mass1;
ThSWall1 = SWall1.Thickness1;
L2SWall1 = SWall1.Length;
L1SWall1 = SWall1.Width;
SSWall1 = L1SWall1 * L2SWall1; % or S = 10
fcSWall1 = (c0.^2) ./ (1.8 * cLSWall1 * ThSWall1); % Critical Frequency
fceffSWall1 = fcSWall1 * (4.05 * ThSWall1 .* f ./ cLSWall1 + sqrt(1+4.05*ThSWall1.*f./cLSWall1).^2);

% SWall2 Properties
SWall2Name = SWall2.Type;
RhoSWall2 = SWall2.Density;
cLSWall2 = SWall2.QuasiLongPhaseVelocity;
EtaInitialSWall2 = SWall2.InternalLossFactor;
MSWall2 = SWall2.Mass1;
ThSWall2 = SWall2.Thickness1;
L2SWall2 = SWall2.Length;
L1SWall2 = SWall2.Width;
SSWall2 = L1SWall2 * L2SWall2; % or S = 10
fcSWall2 = (c0.^2) ./ (1.8 * cLSWall2 * ThSWall2); % Critical Frequency
fceffSWall2 = fcSWall2 * (4.05 * ThSWall2 .* f ./ cLSWall2 + sqrt(1+4.05*ThSWall2.*f./cLSWall2).^2);

% SFloor Properties
SFloorName = SFloor.Type;
RhoSFloor = SFloor.Density;
cLSFloor = SFloor.QuasiLongPhaseVelocity;
EtaInitialSFloor = SFloor.InternalLossFactor;
MSFloor = SFloor.Mass1;
ThSFloor = SFloor.Thickness1;
L2SFloor = SFloor.Length;
L1SFloor = SFloor.Width;
SSFloor = L1SFloor * L2SFloor; % or S = 10
fcSFloor = (c0.^2) ./ (1.8 * cLSFloor * ThSFloor); % Critical Frequency
fceffSFloor = fcSFloor * (4.05 * ThSFloor .* f ./ cLSFloor + sqrt(1+4.05*ThSFloor.*f./cLSFloor).^2);

% SRoof Properties
SRoofName = SRoof.Type;
RhoSRoof = SRoof.Density;
cLSRoof = SRoof.QuasiLongPhaseVelocity;
EtaInitialSRoof = SRoof.InternalLossFactor;
MSRoof = SRoof.Mass1;
ThSRoof = SRoof.Thickness1;
L2SRoof = SRoof.Length;
L1SRoof = SRoof.Width;
SSRoof = L1SRoof * L2SRoof; % or S = 10
fcSRoof = (c0.^2) ./ (1.8 * cLSRoof * ThSRoof); % Critical Frequency
fceffSRoof = fcSRoof * (4.05 * ThSRoof .* f ./ cLSRoof + sqrt(1+4.05*ThSRoof.*f./cLSRoof).^2);

% RWall5 Properties
RWall5Name = RWall5.Type;
RhoRWall5 = RWall5.Density;
cLRWall5 = RWall5.QuasiLongPhaseVelocity;
EtaInitialRWall5 = RWall5.InternalLossFactor;
MRWall5 = RWall5.Mass1;
ThRWall5 = RWall5.Thickness1;
L2RWall5 = RWall5.Length;
L1RWall5 = RWall5.Width;
SRWall5 = L1RWall5 * L2RWall5; % or S = 10
fcRWall5 = (c0.^2) ./ (1.8 * cLRWall5 * ThRWall5); % Critical Frequency
fceffRWall5 = fcRWall5 * (4.05 * ThRWall5 .* f ./ cLRWall5 + sqrt(1+4.05*ThRWall5.*f./cLRWall5).^2);

% SWall2 Properties
RWall6Name = RWall6.Type;
RhoRWall6 = RWall6.Density;
cLRWall6 = RWall6.QuasiLongPhaseVelocity;
EtaInitialRWall6 = RWall6.InternalLossFactor;
MRWall6 = RWall6.Mass1;
ThRWall6 = RWall6.Thickness1;
L2RWall6 = RWall6.Length;
L1RWall6 = RWall6.Width;
SRWall6 = L1RWall6 * L2RWall6; % or S = 10
fcRWall6 = (c0.^2) ./ (1.8 * cLRWall6 * ThRWall6); % Critical Frequency
fceffRWall6 = fcRWall6 * (4.05 * ThRWall6 .* f ./ cLRWall6 + sqrt(1+4.05*ThRWall6.*f./cLRWall6).^2);

% RFloor Properties
RFloorName = RFloor.Type;
RhoRFloor = RFloor.Density;
cLRFloor = RFloor.QuasiLongPhaseVelocity;
EtaInitialRFloor = RFloor.InternalLossFactor;
MRFloor = RFloor.Mass1;
ThRFloor = RFloor.Thickness1;
L2RFloor = RFloor.Length;
L1RFloor = RFloor.Width;
SRFloor = L1RFloor * L2RFloor; % or S = 10
fcRFloor = (c0.^2) ./ (1.8 * cLRFloor * ThRFloor); % Critical Frequency
fceffRFloor = fcRFloor * (4.05 * ThRFloor .* f ./ cLRFloor + sqrt(1+4.05*ThRFloor.*f./cLRFloor).^2);

% RRoof Properties
RRoofName = RRoof.Type;
RhoRRoof = RRoof.Density;
cLRRoof = RRoof.QuasiLongPhaseVelocity;
EtaInitialRRoof = RRoof.InternalLossFactor;
MRRoof = RRoof.Mass1;
ThRRoof = RRoof.Thickness1;
L2RRoof = RRoof.Length;
L1RRoof = RRoof.Width;
SRRoof = L1RRoof * L2RRoof; % or S = 10
fcRRoof = (c0.^2) ./ (1.8 * cLRRoof * ThRRoof); % Critical Frequency
fceffRRoof = fcRRoof * (4.05 * ThRRoof .* f ./ cLRRoof + sqrt(1+4.05*ThRRoof.*f./cLRRoof).^2);

% External Or Ineter Additional Layer
LayerName = Layer.Type;
RhoLayer = Layer.Density;
MLayer = Layer.Mass;
ThLayer = Layer.Thickness;
StifLayer = Layer.Stifness;
L2Layer = Layer.Length;
L1Layer = Layer.Width;
SLayer = L1Layer * L2Layer; % or S = 10

%% Weighted sound reduction
TypeElem = PartionName;
if strcmp(TypeElem, 'Concrete') || strcmp(TypeElem, 'Calcium') || strcmp(TypeElem, 'Bricks')
    % From German Lab Data
    % For 65 Kg/m2 < M < 720 kg/m2
    Rw = 30.9 * log10(MEle./M0) - 22.2;
    C = -1.6;
    Ctr = -4.6;
else
    % For M > 150 kg/m2
    Rw = 37.5 * log10(MEle./M0) - 42;
    C = -1; % or -2
    Ctr = 16 - 9 * log10(MEle./M0);
    Ctr(Ctr >= -1) = -1;
    Ctr(Ctr <= -7) = -7;
end

%% Weighted sound reduction Improvement of additional layers
d = 0.0035;
stiff = StifLayer * 1000000;
LiningMaterials = {'MineralWoll', 'Foams', 'StudsMetal'};
LiningMaterial = 'MineralWoll';
Anchors = false; % If anchors or battens are applied, (4/m2 to 10/m2), different from the reference situation, the correction true
GlueArea = false; % If the glued area differs from 40 % as in the reference situation, the correction true
SperGlued = 40; % The percentage of the area over which the layer is glued to the basic element
if ~isempty(MLayer)
    % Type1:
    % For elements where the insulation layer is fixed directly to the basic construction (without studs or battens)
    % the resonance frequency fo is calculated by
    fo1 = (1 / (2 * pi)) .* (sqrt(stiff.*(1 ./ MEle + 1 ./ MLayer)));
    % Type2:
    % For additional layers built with metal or wooden studs or battens not directly connected to the basic structural
    % element, where the cavity is filled with a porous insulation layer with an air resistivity r=5kPas/m2
    fo2 = (1 / (2 * pi)) .* (sqrt((0.111 ./ d).*(1 ./ MEle + 1 ./ MLayer)));
    LayerType = 1; % Select Type as 1 or 2 (As Above)
    Lining = 'Interior'; % Select 'Interior' or 'Exterior'
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
    elseif (MEle >= 350 && strcmp(Lining, 'Exterior'))
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
        if Anchors
            DeltaRw = 0.66 * DeltaRw - 1.2;
            DeltaRA = 0.62 * DeltaRA - 1.3;
            DeltaRAtr = 0.54 * DeltaRAtr - 1.6;
        end
        if GlueArea
            DeltaRw = DeltaRw - 0.05 * SperGlued + 2;
            DeltaRA = DeltaRA - 0.05 * SperGlued + 2;
            DeltaRAtr = DeltaRAtr - 0.05 * SperGlued + 2;
        end
    end
    % Data transfer to field situation
    
else
end

%% Radiation Factor
% Radiation factor for forced transmission
Delta = -0.964 - ((0.5 + (L2 ./ (pi * L1))) .* log(L2./L1)) + ((5 * L2) ./ (2 * pi * L1)) - (1 ./ (4 * pi * L1 * L2 .* (ko.^2)));
SigmaForced = 0.5 * (log(ko.*sqrt(L1.*L2)) - Delta); % Radiation factor for forced transmission
SigmaForced(SigmaForced > 2) = 2;
RadiEfficiency = 10 * log10(SigmaForced)';
% Radiation factor for Free bending waves
Sigma1 = 1 ./ sqrt(1-fc./f);
Sigma2 = 4 * L1 * L2 .* ((f ./ c0).^2);
Sigma3 = sqrt((2 * pi * f * (L1 + L2))./(16 * c0));
F11 = ((c0.^2) ./ (4 * fc)) .* ((1 / L1.^2) + (1 / L2.^2));
SigmaFW = zeros(1, length(f)); % Radiation factor for Free bending waves
for i = 1:length(f)
    if F11 <= fc / 2
        if f(i) >= fc
            SigmaFW(i) = Sigma1(i);
        elseif f(i) < fc
            Lemda = sqrt(f(i)./fc);
            Delta1 = (((1 - Lemda.^2) .* log((1 + Lemda)./(1 - Lemda))) + 2 * Lemda) ./ ((4 * pi.^2) .* (1 - Lemda.^2).^1.5);
            if f(i) > fc / 2
                Delta2 = 0;
            elseif f(i) <= fc / 2
                Delta2 = (8 * c0^2 .* (1 - 2 * Lemda.^2)) ./ (fc.^2 * pi.^4 * L1 * L2 * Lemda .* (sqrt(1-Lemda.^2)));
            end
            %             SigmaFW(i) = (2*(L1+L2)*c0*Delta1)./(L1*L2*fc) + Delta2;
            SigmaFW(i) = ((2 * (L1 + L2)) ./ (L1 * L2)) .* (c0 ./ fc) .* Delta1 + Delta2;
        end
        if (F11 > f(i) && F11 < fc / 2 && SigmaFW(i) > Sigma2(i))
            SigmaFW(i) = Sigma2(i);
        end
    elseif F11 > fc / 2
        if (f(i) < fc) && (Sigma2(i) < Sigma3(i))
            SigmaFW(i) = Sigma2(i);
        elseif (f(i) > fc) && (Sigma1(i) < Sigma3(i))
            SigmaFW(i) = Sigma1(i);
        else
            SigmaFW(i) = Sigma3(i);
        end
    end
end
SigmaFW(SigmaFW >= 2) = 2;

%% Vibration transmission over junctions: Case of heavy buildings Kij
Junctions = {'CrossJunction', 'TJunction', 'WallJunctionFlexibleInterLayer', ...
    'LightDoubleLeafWallHomoX', 'LightDoubleLeafWallHomoL', 'Corner', 'Thinkness'};
Type = Junctions{1};
Mip = MEle;
mi = MSWall1;
MRatio = abs(log10(Mip./mi));
switch Type
    case 'CrossJunction'
        K13 = 8.7 + 17.1 * MRatio + 5.7 * MRatio.^2;
        K12 = 8.7 + 5.7 * MRatio.^2;
        K23 = 8.7 + 5.7 * MRatio.^2;
        K14 = 8.7 + 5.7 * MRatio.^2;
        K34 = 8.7 + 5.7 * MRatio.^2;
    case 'TJunction'
        K13 = 5.7 + 14.1 * MRatio + 5.7 * MRatio.^2;
        K12 = 5.7 + 5.7 * MRatio.^2;
        K23 = 5.7 + 5.7 * MRatio.^2;
    case 'WallJunctionFlexibleInterLayer'
        K24 = 3.7 + 14.1 * MRatio + 5.7 * MRatio.^2;
        k23 = 5.7 + 14.1 * MRatio + 5.7 * MRatio.^2;
        k12 = k23;
        k34 = k23;
    case 'LightDoubleLeafWallHomoX'
        fk = 500;
        K13 = 10 + 20 * MRatio - 3.3 * Log10(f./fk);
        K24 = 3.0 + 14.1 * MRatio + 5.7 * MRatio.^2;
        K12 = 10 + 10 * abs(MRatio) + 3.3 * log10(f./fk);
        K14 = K12;
        K23 = K12;
        K34 = K12;
    case 'LightDoubleLeafWallHomoL'
        fk = 500;
        K12 = 10 + 10 * abs(MRatio) + 3.3 * log10(f./fk);
        K14 = K12;
    case 'Corner'
        K12 = 15 * abs(MRatio) - 3;
        K21 = K12;
    case 'Thinkness'
        K12 = 5 * MRatio.^2 - 5;
        K21 = K12;
    otherwise
end

% Data from simulations Structure-borne power transmission loss expressions for L, T and X-junctions as a function of PC
% fcc = (c0.^2/pi).*sqrt((3*M*(1-v.^2))./(E*Th.^3));
fcc = (c0.^2 * sqrt(3)) ./ (pi * Th * cL);
fccP = fcc;
PCRatio = (Mip / MEle) ./ (fcc ./ fccP).^3 / 2;
% PCRatio = (Mp/MEle)./((ThP*cL)./(Th*cL)).^3/2;
PC = log10(PCRatio);
Junction1 = {'L', 'T', 'X'};
Type1 = Junction1{1};
for i = 1:length(f)
    switch Type1
        case 'L'
            if (f(i) >= 50 && f(i) <= 200)
                GamaFact12(i) = -0.8 * PC.^3 + 5 * PC.^2 + 1.5 * PC + 5.9;
            elseif (f(i) >= 250 && f(i) <= 1000)
                GamaFact12(i) = -0.24 * PC.^3 + 3 * PC.^2 + 1 * PC + 9.5;
            elseif (f(i) >= 1250 && f(i) <= 5000)
            end
        case 'T'
            if (f(i) >= 50 && f(i) <= 200)
                GamaFact12(i) = -0.4 * PC.^3 + 4.8 * PC.^2 + 1.4 * PC + 9.4;
                GamaFact13(i) = -0.3 * PC.^3 + 4.5 * PC.^2 + 7.5 * PC + 8.9;
                GamaFact23 = GamaFact12;
            elseif (f(i) >= 250 && f(i) <= 1000)
                GamaFact12(i) = -0.43 * PC.^3 + 3.8 * PC.^2 + 0.3 * PC + 11.5;
                GamaFact13(i) = -0.2 * PC.^3 + 1.3 * PC.^2 + 6.9 * PC + 9.1;
                GamaFact23 = GamaFact12;
            elseif (f(i) >= 1250 && f(i) <= 5000)
                GamaFact12(i) = -0.43 * PC.^3 + 3.8 * PC.^2 + 0.3 * PC + 11.5;
                GamaFact13(i) = -0.04 * PC.^3 + 1 * PC.^2 + 4.5 * PC + 5;
                GamaFact23 = GamaFact12;
            end
        case 'X'
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

% Kij = (GamaFact34)+(5*log10(fcc./fref));
%

%% Vibration transmission over junctions: Case of lightweight buildings
% Type-I: Empirical data for junctions characterized by Kij
Junction2 = {'T', 'X'};
Type2 = Junction2{1};
switch Type2
    case 'T'
        fk = 500;
        K13 = 22 + 3.3 * log10(f./fk);
        K23 = 15 + 3.3 * log10(f./fk);
        K12 = K23;
    case 'X'
        fk = 500;
        K13 = 10 - 3.3 * log10(f./fk) + 10 * MRatio;
        K24 = 23 + 3.3 * log10(f./fk);
        K14 = 18 + 3.3 * log10(f./fk);
        K34 = K14;
        K23 = K14;
        K12 = K14;
    otherwise
end
% Type-II: Empirical data for junctions characterized by Dv,ij,n
% Sub-Type-I: Timber frame lightweight building elements; inner leaf transmission
% a) floors in the range 30 kg/m2 to 70 kg/m2;
% b) façades in the range 25 kg/m2 to 45 kg/m2;
% c) double frame wall in the range 35 kg/m2 to 75 kg/m2;
% d) single frame partition in the range 20 kg/m2 to 40 kg/m2.
% Solid wood and CLT elements are excluded.
Junction3 = {'TJunctionFloor:Faced', 'XJunctionFloorDouble', 'TJunctionFloor:Double', 'XJunctionFloor:Countinuous'};
Type3 = Junction2{1};
switch Type2
    case 'TJunctionFloor:Faced'
        fk = 500; % Slope 3dB
        Dv12n = 30 + log10(f./fk);
        Dv13n = Dv12n;
    case 'XJunctionFloorDouble'
        fk = 500;
        Dvijn = 38 + 13.3 * log10(f./fk); % Any horizontal path through the cavity (except floor-floor)
        Dv13n = 36 + 3.3 * log10(f./fk); % Floor-floor path
        Dv12n = 18 + 3.3 * log10(f./fk); % Floor-separating wall
        Dv24n = 22 + 3.3 * log10(f./fk); % Separating wall-separating wall
    case 'TJunctionFloor:Double' % Any path through the cavity
        fk = 500;
        Dv12n = 38 + 13.3 * log10(f./fk);
        Dv13n = Dv12n;
    case 'XJunctionFloor:Countinuous'
        % Floor-floor or floor-wall path
        Dv13n = 20 - 3.3 * log10(f./fk);
        Dv34n = Dv13n;
        % Wall-wall path
        Dv24n = 30 + 3.3 * log10(f./fk);
    otherwise
        % Sub-Type-II: Timber frame lightweight building elements; double elements as a whole
        Dv13n = 15 + 20 * MRatio - 3.3 * log10(f./fk);
        Dv12n = 15 + 10 * abs(MRatio) - 3.3 * log10(f./fk);
        Dv23n = Dv12n;
end
%

%% Absorption Coefficient (Alpha)
%  Case-I: Average Absorption Coefficient (for heavy constructions (around 400 kg/m2))
AlphAvg = 0.15;
%  Case-II: Average Absorption Coefficient for Laboratory (for a heavy frame of 600 mm concrete around the test opening)
Chi = sqrt(31.1/fc);
Psy = 44.3 * (fc ./ MEle);
Alph = (1 / 3) .* ((2 * sqrt(Chi.*Psy) .* (1 + Chi) .* (1 + Psy)) ./ (Chi .* (1 + Psy).^2 + 2 * Psy * (1 + Chi.^2))).^2;
Alpha = Alph .* (1 - 0.9999 * Alph);
%  Case-III: Absorption Coefficient for in-Situ (between 0.05 and 0.5)
fref = 1000;
Kij = [1, 1, 1; 1, 1, 1; 1, 1, 1; 1, 1, 1];
fcj = [1, 1, 1; 1, 1, 1; 1, 1, 1; 1, 1, 1];
for perimeter = 1:4
    for j = 1:3
        Perimt(j) = sqrt(fcj(perimeter, j)./fref) .* 10.^(Kij(perimeter, j) / 10);
        %
    end
    Alphak(perimeter) = sum(Perimt);
end

%% Structural reverberation time and Total Loss Factor: Type A elements
% Laboratory situation (for heavy constructions (around 400kg/m2)) and (below 800kg/m2)
% if MEle >= 400 && MEle <= 800
EtaTotalLab1 = EtaInitial + MEle ./ (485 * sqrt(f));
EtaTotalLab2 = 0.01 + MEle ./ (485 * sqrt(f));
% end
% In-Situ
% 1. General
if MEle > 150 % Gereman Standard
    c = 0.5;
elseif strcmp(Material, 'Concerete')
    c = 1;
elseif MEle < 150 % Gereman Standard
    c = m / 300;
    EtaInitial = 0.005;
else
end
EtaTotalSituGeneral = EtaInitial + c ./ sqrt(f);
% Detailed including Kij
Lk = [L1, L2, L1, L2];
% AlphK = sum();
Alphak = Alpha;
Factor = sum(Lk.*Alphak);
EtaTotalSitu = EtaInitial + ((2 * Rho0 * c0 .* SigmaFW) ./ (2 * pi * f * MEle)) + (c0 ./ ((pi.^2) * S .* sqrt(f.*fc))) .* Factor;
% EtaTotal = EtaTotalG;
% Structural Reverberation Time
Ts = (2.2) ./ (f .* EtaTotalSitu);

%% Radiation Factors for Resonance Transmission
r = (pi * fc .* SigmaFW) ./ (4 * f .* EtaTotalSitu);
SigmaS = SigmaFW;
SigmaA = (SigmaForced + r .* SigmaFW) ./ (1 + r);

%% Tansmission Coefficient
% Based on Loss factor from Lab Situation
EtaTotalLab = EtaTotalLab1;
% SigmaFW = 1/0.71;
for i = 1:length(f)
    if f(i) > fc * 1.4
        TauLab(i) = (((2 * Rho0 * c0) ./ (2 * pi .* f(i) .* MEle)).^2) .* ((pi * fc .* SigmaFW(i).^2) ./ (2 * f(i) .* EtaTotalLab(i)));
    elseif f(i) <= fc * 1.4 && f(i) >= fc / 1.12
        TauLab(i) = (((2 * Rho0 * c0) ./ (2 * pi * fc .* MEle)).^2) .* ((pi .* SigmaFW(i).^2) ./ (2 * EtaTotalLab(i)));
    elseif f(i) < fc / 1.12
        TauLab(i) = (((2 * Rho0 * c0) ./ (2 * pi * f(i) .* MEle)).^2) .* ((2 * SigmaForced(i) .* ((1 - f(i).^2) ./ (fc.^2)).^-2) + ((2 * pi * fc * SigmaFW(i).^2) ./ (4 * f(i) .* EtaTotalLab(i))));
    end
end

% Based on In-Situ Total Loss factor Genral
for i = 1:length(f)
    if f(i) > fc * 1.4
        TauSituGen(i) = (((2 * Rho0 * c0) ./ (2 * pi .* f(i) .* MEle)).^2) .* ((pi * fc .* SigmaFW(i).^2) ./ (2 * f(i) .* EtaTotalSituGeneral(i)));
    elseif f(i) <= fc * 1.4 && f(i) >= fc / 1.12
        TauSituGen(i) = (((2 * Rho0 * c0) ./ (2 * pi * f(i) .* MEle)).^2) .* ((pi .* SigmaFW(i).^2) ./ (2 * EtaTotalSituGeneral(i)));
        %         Tau(i) = (((2*Rho0*c0)./(2*pi*fc.*M)).^2).*((pi.*1/0.71)./(2*EtaTotal(i)));
    elseif f(i) < fc / 1.12
        TauSituGen(i) = (((2 * Rho0 * c0) ./ (2 * pi * f(i) .* MEle)).^2) .* ((2 * SigmaForced(i) .* ((1 - f(i).^2) ./ (fc.^2)).^-2) + ((2 * pi * fc * SigmaFW(i).^2) ./ (4 * f(i) .* EtaTotalSituGeneral(i))));
    end
end

% Based on In-Situ Total Loss factor including Kij
for i = 1:length(f)
    if f(i) > fc * 1.4
        TauSitu(i) = (((2 * Rho0 * c0) ./ (2 * pi .* f(i) .* MEle)).^2) .* ((pi * fc .* SigmaFW(i).^2) ./ (2 * f(i) .* EtaTotalSitu(i)));
    elseif f(i) <= fc * 1.4 && f(i) >= fc / 1.12
        TauSitu(i) = (((2 * Rho0 * c0) ./ (2 * pi * f(i) .* MEle)).^2) .* ((pi .* SigmaFW(i).^2) ./ (2 * EtaTotalSitu(i)));
        %         Tau(i) = (((2*Rho0*c0)./(2*pi*fc.*M)).^2).*((pi.*1/0.71)./(2*EtaTotal(i)));
    elseif f(i) < fc / 1.12
        TauSitu(i) = (((2 * Rho0 * c0) ./ (2 * pi * f(i) .* MEle)).^2) .* ((2 * SigmaForced(i) .* ((1 - f(i).^2) ./ (fc.^2)).^-2) + ((2 * pi * fc * SigmaFW(i).^2) ./ (4 * f(i) .* EtaTotalSitu(i))));
    end
end

%% Sound Reduction Index
% Calculation Based
ReductionSitu = -10 * log10(TauSitu);
ReductionSituGen = -10 * log10(TauSituGen);
ReductionLab = -10 * log10(TauLab);
% ReductionLab(f<=fc) = ReductionLab(f<=fc)+8;
ReductionResonace = ReductionSituGen + 10 * log(SigmaA./SigmaS);

%% Measurment Based

%% Determination of normalized flanking level difference
% Dominant airborne transmission (Determination form Data)
AbsorbLining = 1;
ta = 1; % Thickness of the absorbing lining in the plenum, in metres
Scs = 0; % Area of the ceiling in the receiving room
ScsLab = 20; % Area of the ceiling source room for the laboratory
Scr = 0; % Area of the ceiling in the source room and receiving room
ScrLab = 20; % Area of the ceiling in receiving room for the laboratory
hpl = 0; % Free height of the plenum above the ceiling
hlab = 0;
%
if AbsorbLining == 0
    Ca = 0;
elseif AbsorbLining == 1
    for k = 1:length(f)
        if f(i) <= 0.015 * (c0 / ta)
            Ca(i) = 0;
        elseif f(i) > 0.015 * (c0 / ta) && f(i) < 0.3 * c0 / min(hlab, hpl)
            Ca(i) = 10 * log10(sqrt((Scs * Scr)./(ScsLab * ScrLab))) * (hlab ./ hpl);
        elseif f(i) > 0.3 * c0 / min(hlab, hpl)
            Ca(i) = 10 * log10(sqrt((Scs * Scr)./(ScsLab * ScrLab))) * (hlab ./ hpl).^2;
        end
    end
end
% Dnfsit = Dnflab + (10*log10((hpl*Lij)./(hLab*lLab)))+(10*log10((Scslab*Scrlab)./(Scs*Scr))+Ca);
% Determination from performance of the elements
% Dnfij = (Ri+Rj)/2 + DRi + DRj + Dvijn + (10*log10((A0)./(l0lijLab)));
%

%% Polts
figure;
semilogx(f, ReductionSituGen, '-*')
grid on; shg; hold on
semilogx(f, ReductionData, '-o')
semilogx(f, ReductionResonace, '.')
semilogx(f, ReductionLab, '--')
semilogx(f, ReductionSitu, '-.')

legend('ReductionSituGen', 'ReductionData', 'ReductionResonace', 'ReductionLab', 'ReductionSitu')

% plot(f,RadiEff,'.'); grid on; shg
% hold on
% plot(f,Data2,'o'); grid on; shg

%%

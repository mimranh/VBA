
%% Partion Properties
% Main Element or Prtioning between Source and Receiver Room
PartionName = Partion.Type;
Rho = Partion.Density;
cL = Partion.QuasiLongPhaseVelocity;
EtaInitial = Partion.InternalLossFactor;
MEle = Partion.Mass;
Th = Partion.Thickness;
L2 = Partion.Length;
L1 = Partion.Width;
S = Partion.Area; % or S = 10
fc = (c0.^2) ./ (1.8 * cL * Th); % Critical Frequency
fceff = fc * (4.05 * Th .* f ./ cL + sqrt(1+4.05*Th.*f./cL).^2);

% SWall1 Properties (Source Room Wall 1)
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
StifnessLayer = Layer.Stifness;
L2Layer = Layer.Length;
L1Layer = Layer.Width;
SLayer = L1Layer * L2Layer; % or S = 10
%

MassesData = [MEle, MSWall1, MSWall2, MSFloor, MSRoof, MRWall5, MRWall6, MRFloor, MRRoof];

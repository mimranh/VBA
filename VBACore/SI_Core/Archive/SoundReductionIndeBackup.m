
%% ISO: EN 12354-1
% Building acoustics Estimation of acoustic performance of buildings from the performance of elements
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017 (23.11.2017, Thursday)
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Airborne Sound Insulation between rooms
% Load Geometry Properties and the corrsponding Material Properties of the individual Elements of the Building by assigning the material
% charectristics from the material data
clear;
clc
Geometries

%% Weighted Sound Reduction
[Partion.Rw, Partion.C, Partion.Ctr] = SI_ReductionWeighted(Partion, M0);
[SWallR.Rw, SWallR.C, SWallR.Ctr] = SI_ReductionWeighted(SWallR, M0);
[SWallL.Rw, SWallL.C, SWallL.Ctr] = SI_ReductionWeighted(SWallL, M0);
[SWallB.Rw, SWallB.C, SWallB.Ctr] = SI_ReductionWeighted(SWallB, M0);
[SWallF.Rw, SWallF.C, SWallF.Ctr] = SI_ReductionWeighted(SWallF, M0);
[SWallC.Rw, SWallC.C, SWallC.Ctr] = SI_ReductionWeighted(SWallC, M0);
[RWallR.Rw, RWallR.C, RWallR.Ctr] = SI_ReductionWeighted(RWallR, M0);
[RWallL.Rw, RWallL.C, RWallL.Ctr] = SI_ReductionWeighted(RWallL, M0);
[RWallB.Rw, RWallB.C, RWallB.Ctr] = SI_ReductionWeighted(RWallB, M0);
[RWallF.Rw, RWallF.C, RWallF.Ctr] = SI_ReductionWeighted(RWallF, M0);
[RWallC.Rw, RWallC.C, RWallC.Ctr] = SI_ReductionWeighted(RWallC, M0);

%% Weighted Sound Reduction Improvement of Additional Layers
[Partion.DRwSitu, Partion.DeltaRw] = ReductionWeightedImprovement(Partion, LayerP, 1, 'Exterior', false, false, 40);
Partion.DeltaRwSitu = Partion.Rw + Partion.DRwSitu;

%% Radiation Factors
[Partion.SigmaForced, Partion.SigmaFW, Partion.RadiEfficiency] = SI_RadiationFactor(Partion, ko, f);
[SWallR.SigmaForced, SWallR.SigmaFW, SWallR.RadiEfficiency] = SI_RadiationFactor(SWallR, ko, f);
[SWallL.SigmaForced, SWallL.SigmaFW, SWallL.RadiEfficiency] = SI_RadiationFactor(SWallL, ko, f);
[SWallB.SigmaForced, SWallB.SigmaFW, SWallB.RadiEfficiency] = SI_RadiationFactor(SWallB, ko, f);
[SWallF.SigmaForced, SWallF.SigmaFW, SWallF.RadiEfficiency] = SI_RadiationFactor(SWallF, ko, f);
[SWallC.SigmaForced, SWallC.SigmaFW, SWallC.RadiEfficiency] = SI_RadiationFactor(SWallC, ko, f);
[RWallR.SigmaForced, RWallR.SigmaFW, RWallR.RadiEfficiency] = SI_RadiationFactor(RWallR, ko, f);
[RWallL.SigmaForced, RWallL.SigmaFW, RWallL.RadiEfficiency] = SI_RadiationFactor(RWallL, ko, f);
[RWallB.SigmaForced, RWallB.SigmaFW, RWallB.RadiEfficiency] = SI_RadiationFactor(RWallB, ko, f);
[RWallF.SigmaForced, RWallF.SigmaFW, RWallF.RadiEfficiency] = SI_RadiationFactor(RWallF, ko, f);
[RWallC.SigmaForced, RWallC.SigmaFW, RWallC.RadiEfficiency] = SI_RadiationFactor(RWallC, ko, f);

%% Vibration transmission over junctions: Case of heavy buildings Kij
[Partion.JunctionKij] = VibTranJunctionHeavysV1(Partion.ID, 'Empirical');
[SWallR.JunctionKij] = VibTranJunctionHeavysV1(SWallR.ID, 'Empirical');
[SWallL.JunctionKij] = VibTranJunctionHeavysV1(SWallL.ID, 'Empirical');
[SWallB.JunctionKij] = VibTranJunctionHeavysV1(SWallB.ID, 'Empirical');
[SWallF.JunctionKij] = VibTranJunctionHeavysV1(SWallF.ID, 'Empirical');
[SWallC.JunctionKij] = VibTranJunctionHeavysV1(SWallC.ID, 'Empirical');
[RWallR.JunctionKij] = VibTranJunctionHeavysV1(RWallR.ID, 'Empirical');
[RWallL.JunctionKij] = VibTranJunctionHeavysV1(RWallL.ID, 'Empirical');
[RWallB.JunctionKij] = VibTranJunctionHeavysV1(RWallB.ID, 'Empirical');
[RWallF.JunctionKij] = VibTranJunctionHeavysV1(RWallF.ID, 'Empirical');
[RWallC.JunctionKij] = VibTranJunctionHeavysV1(RWallC.ID, 'Empirical');

%% Absorption Coefficient (Alpha)
[Partion.AlphaKSitu, Partion.AlphakLab, Partion.AlphAvg] = AbsorptionCoefficient(Partion);
[SWallR.AlphaKSitu, SWallR.AlphakLab, SWallR.AlphAvg] = AbsorptionCoefficient(SWallR);
[SWallL.AlphaKSitu, SWallL.AlphakLab, SWallL.AlphAvg] = AbsorptionCoefficient(SWallL);
[SWallB.AlphaKSitu, SWallB.AlphakLab, SWallB.AlphAvg] = AbsorptionCoefficient(SWallB);
[SWallF.AlphaKSitu, SWallF.AlphakLab, SWallF.AlphAvg] = AbsorptionCoefficient(SWallF);
[SWallC.AlphaKSitu, SWallC.AlphakLab, SWallC.AlphAvg] = AbsorptionCoefficient(SWallC);
[RWallR.AlphaKSitu, RWallR.AlphakLab, RWallR.AlphAvg] = AbsorptionCoefficient(RWallR);
[RWallL.AlphaKSitu, RWallL.AlphakLab, RWallL.AlphAvg] = AbsorptionCoefficient(RWallL);
[RWallB.AlphaKSitu, RWallB.AlphakLab, RWallB.AlphAvg] = AbsorptionCoefficient(RWallB);
[RWallF.AlphaKSitu, RWallF.AlphakLab, RWallF.AlphAvg] = AbsorptionCoefficient(RWallF);
[RWallC.AlphaKSitu, RWallC.AlphakLab, RWallC.AlphAvg] = AbsorptionCoefficient(RWallC);

%% Structural reverberation time and Total Loss Factor: Type A elements
[Partion.EtaSituG, Partion.EtaSitu1, Partion.EtaSitu, Partion.EtaLabK, Partion.EtaLab1, Partion.EtaLab2, Partion.TsLab, Partion.TsSitu, Partion.TsLab2, Partion.TsLabK] = SI_TotalLossFactor(Partion);
[SWallR.EtaSituG, SWallR.EtaSitu1, SWallR.EtaSitu, SWallR.EtaLabK, SWallR.EtaLab1, SWallR.EtaLab2, SWallR.TsLab, SWallR.TsSitu, SWallR.TsLab2, SWallR.TsLabK] = SI_TotalLossFactor(SWallR);
[SWallL.EtaSituG, SWallL.EtaSitu1, SWallL.EtaSitu, SWallL.EtaLabK, SWallL.EtaLab1, SWallL.EtaLab2, SWallL.TsLab, SWallL.TsSitu, SWallL.TsLab2, SWallL.TsLabK] = SI_TotalLossFactor(SWallL);
[SWallB.EtaSituG, SWallB.EtaSitu1, SWallB.EtaSitu, SWallB.EtaLabK, SWallB.EtaLab1, SWallB.EtaLab2, SWallB.TsLab, SWallB.TsSitu, SWallB.TsLab2, SWallB.TsLabK] = SI_TotalLossFactor(SWallB);
[SWallF.EtaSituG, SWallF.EtaSitu1, SWallF.EtaSitu, SWallF.EtaLabK, SWallF.EtaLab1, SWallF.EtaLab2, SWallF.TsLab, SWallF.TsSitu, SWallF.TsLab2, SWallF.TsLabK] = SI_TotalLossFactor(SWallF);
[SWallC.EtaSituG, SWallC.EtaSitu1, SWallC.EtaSitu, SWallC.EtaLabK, SWallC.EtaLab1, SWallC.EtaLab2, SWallC.TsLab, SWallC.TsSitu, SWallC.TsLab2, SWallC.TsLabK] = SI_TotalLossFactor(SWallC);
[RWallR.EtaSituG, RWallR.EtaSitu1, RWallR.EtaSitu, RWallR.EtaLabK, RWallR.EtaLab1, RWallR.EtaLab2, RWallR.TsLab, RWallR.TsSitu, RWallR.TsLab2, RWallR.TsLabK] = SI_TotalLossFactor(RWallR);
[RWallL.EtaSituG, RWallL.EtaSitu1, RWallL.EtaSitu, RWallL.EtaLabK, RWallL.EtaLab1, RWallL.EtaLab2, RWallL.TsLab, RWallL.TsSitu, RWallL.TsLab2, RWallL.TsLabK] = SI_TotalLossFactor(RWallL);
[RWallB.EtaSituG, RWallB.EtaSitu1, RWallB.EtaSitu, RWallB.EtaLabK, RWallB.EtaLab1, RWallB.EtaLab2, RWallB.TsLab, RWallB.TsSitu, RWallB.TsLab2, RWallB.TsLabK] = SI_TotalLossFactor(RWallB);
[RWallF.EtaSituG, RWallF.EtaSitu1, RWallF.EtaSitu, RWallF.EtaLabK, RWallF.EtaLab1, RWallF.EtaLab2, RWallF.TsLab, RWallF.TsSitu, RWallF.TsLab2, RWallF.TsLabK] = SI_TotalLossFactor(RWallF);
[RWallC.EtaSituG, RWallC.EtaSitu1, RWallC.EtaSitu, RWallC.EtaLabK, RWallC.EtaLab1, RWallC.EtaLab2, RWallC.TsLab, RWallC.TsSitu, RWallC.TsLab2, RWallC.TsLabK] = SI_TotalLossFactor(RWallC);

%% The Equivalent Absorption Length
[Partion.EquAbsorptionLength] = SI_EquAbsorpLength(Partion, f);
[SWallR.EquAbsorptionLength] = SI_EquAbsorpLength(SWallR, f);
[SWallL.EquAbsorptionLength] = SI_EquAbsorpLength(SWallL, f);
[SWallB.EquAbsorptionLength] = SI_EquAbsorpLength(SWallB, f);
[SWallF.EquAbsorptionLength] = SI_EquAbsorpLength(SWallF, f);
[SWallC.EquAbsorptionLength] = SI_EquAbsorpLength(SWallC, f);
[RWallR.EquAbsorptionLength] = SI_EquAbsorpLength(RWallR, f);
[RWallL.EquAbsorptionLength] = SI_EquAbsorpLength(RWallL, f);
[RWallB.EquAbsorptionLength] = SI_EquAbsorpLength(RWallB, f);
[RWallF.EquAbsorptionLength] = SI_EquAbsorpLength(RWallF, f);
[RWallC.EquAbsorptionLength] = SI_EquAbsorpLength(RWallC, f);

%% Radiation Factors for Resonance Transmission
[Partion.SigmaS, Partion.SigmaA] = SI_RadiationFactorResonant(Partion, f);
[SWallR.SigmaS, SWallR.SigmaA] = SI_RadiationFactorResonant(SWallR, f);
[SWallL.SigmaS, SWallL.SigmaA] = SI_RadiationFactorResonant(SWallL, f);
[SWallB.SigmaS, SWallB.SigmaA] = SI_RadiationFactorResonant(SWallB, f);
[SWallF.SigmaS, SWallF.SigmaA] = SI_RadiationFactorResonant(SWallF, f);s
[SWallC.SigmaS, SWallC.SigmaA] = SI_RadiationFactorResonant(SWallC, f);
[RWallR.SigmaS, RWallR.SigmaA] = SI_RadiationFactorResonant(RWallR, f);
[RWallL.SigmaS, RWallL.SigmaA] = SI_RadiationFactorResonant(RWallL, f);
[RWallB.SigmaS, RWallB.SigmaA] = SI_RadiationFactorResonant(RWallB, f);
[RWallF.SigmaS, RWallF.SigmaA] = SI_RadiationFactorResonant(RWallF, f);
[RWallC.SigmaS, RWallC.SigmaA] = SI_RadiationFactorResonant(RWallC, f);

%% Tansmission Coefficient
[Partion.TauLab, Partion.TauSituGen, Partion.TauSitu] = TansmissionCoefficient(Partion, f);
[SWallR.TauLab, SWallR.TauSituGen, SWallR.TauSitu] = TansmissionCoefficient(SWallR, f);
[SWallL.TauLab, SWallL.TauSituGen, SWallL.TauSitu] = TansmissionCoefficient(SWallL, f);
[SWallB.TauLab, SWallB.TauSituGen, SWallB.TauSitu] = TansmissionCoefficient(SWallB, f);
[SWallF.TauLab, SWallF.TauSituGen, SWallF.TauSitu] = TansmissionCoefficient(SWallF, f);
[SWallC.TauLab, SWallC.TauSituGen, SWallC.TauSitu] = TansmissionCoefficient(SWallC, f);
[RWallR.TauLab, RWallR.TauSituGen, RWallR.TauSitu] = TansmissionCoefficient(RWallR, f);
[RWallL.TauLab, RWallL.TauSituGen, RWallL.TauSitu] = TansmissionCoefficient(RWallL, f);
[RWallB.TauLab, RWallB.TauSituGen, RWallB.TauSitu] = TansmissionCoefficient(RWallB, f);
[RWallF.TauLab, RWallF.TauSituGen, RWallF.TauSitu] = TansmissionCoefficient(RWallF, f);
[RWallC.TauLab, RWallC.TauSituGen, RWallC.TauSitu] = TansmissionCoefficient(RWallC, f);

%% Sound Reduction Index
% Calculation Based
Partion.ReductionSitu = -10 * log10(Partion.TauSitu);
SWallR.ReductionSitu = -10 * log10(SWallR.TauSitu);
SWallL.ReductionSitu = -10 * log10(SWallL.TauSitu);
SWallB.ReductionSitu = -10 * log10(SWallB.TauSitu);
SWallF.ReductionSitu = -10 * log10(SWallF.TauSitu);
SWallC.ReductionSitu = -10 * log10(SWallC.TauSitu);
RWallR.ReductionSitu = -10 * log10(RWallR.TauSitu);
RWallL.ReductionSitu = -10 * log10(RWallL.TauSitu);
RWallB.ReductionSitu = -10 * log10(RWallB.TauSitu);
RWallF.ReductionSitu = -10 * log10(RWallF.TauSitu);
RWallC.ReductionSitu = -10 * log10(RWallC.TauSitu);
%
% ReductionSitu1 = ReductionSitu + DeltaRwSitu;
Partion.ReductionSituGen = -10 * log10(Partion.TauSituGen);
SWallR.ReductionSituGen = -10 * log10(SWallR.TauSituGen);
SWallL.ReductionSituGen = -10 * log10(SWallL.TauSituGen);
SWallB.ReductionSituGen = -10 * log10(SWallB.TauSituGen);
SWallF.ReductionSituGen = -10 * log10(SWallF.TauSituGen);
SWallC.ReductionSituGen = -10 * log10(SWallC.TauSituGen);
RWallR.ReductionSituGen = -10 * log10(RWallR.TauSituGen);
RWallL.ReductionSituGen = -10 * log10(RWallL.TauSituGen);
RWallB.ReductionSituGen = -10 * log10(RWallB.TauSituGen);
RWallF.ReductionSituGen = -10 * log10(RWallF.TauSituGen);
RWallC.ReductionSituGen = -10 * log10(RWallC.TauSituGen);
%
Partion.ReductionLab = -10 * log10(Partion.TauLab);
SWallR.ReductionLab = -10 * log10(SWallR.TauLab);
SWallL.ReductionLab = -10 * log10(SWallL.TauLab);
SWallB.ReductionLab = -10 * log10(SWallB.TauLab);
SWallF.ReductionLab = -10 * log10(SWallF.TauLab);
SWallC.ReductionLab = -10 * log10(SWallC.TauLab);
RWallR.ReductionLab = -10 * log10(RWallR.TauLab);
RWallL.ReductionLab = -10 * log10(RWallL.TauLab);
RWallB.ReductionLab = -10 * log10(RWallB.TauLab);
RWallF.ReductionLab = -10 * log10(RWallF.TauLab);
RWallC.ReductionLab = -10 * log10(RWallC.TauLab);
%
% ReductionLab(f<=fc) = ReductionLab(f<=fc)+8;
Partion.ReductionResonace = Partion.ReductionSituGen + 10 * log(Partion.SigmaA./Partion.SigmaS);
SWallR.ReductionResonace = SWallR.ReductionSituGen + 10 * log(SWallR.SigmaA./SWallR.SigmaS);
SWallL.ReductionResonace = SWallL.ReductionSituGen + 10 * log(SWallL.SigmaA./SWallL.SigmaS);
SWallB.ReductionResonace = SWallB.ReductionSituGen + 10 * log(SWallB.SigmaA./SWallB.SigmaS);
SWallF.ReductionResonace = SWallF.ReductionSituGen + 10 * log(SWallF.SigmaA./SWallF.SigmaS);
SWallC.ReductionResonace = SWallC.ReductionSituGen + 10 * log(SWallC.SigmaA./SWallC.SigmaS);
RWallR.ReductionResonace = RWallR.ReductionSituGen + 10 * log(RWallR.SigmaA./RWallR.SigmaS);
RWallL.ReductionResonace = RWallL.ReductionSituGen + 10 * log(RWallL.SigmaA./RWallL.SigmaS);
RWallB.ReductionResonace = RWallB.ReductionSituGen + 10 * log(RWallB.SigmaA./RWallB.SigmaS);
RWallF.ReductionResonace = RWallF.ReductionSituGen + 10 * log(RWallF.SigmaA./RWallF.SigmaS);
RWallC.ReductionResonace = RWallC.ReductionSituGen + 10 * log(RWallC.SigmaA./RWallC.SigmaS);
%
Partion.RSitu = Partion.ReductionSitu - (10 * log10(Partion.TsSitu./Partion.TsLabK));
SWallR.RSitu = SWallR.ReductionSitu - (10 * log10(SWallR.TsSitu./SWallR.TsLabK));
SWallL.RSitu = SWallL.ReductionSitu - (10 * log10(SWallL.TsSitu./SWallL.TsLabK));
SWallB.RSitu = SWallB.ReductionSitu - (10 * log10(SWallB.TsSitu./SWallB.TsLabK));
SWallF.RSitu = SWallF.ReductionSitu - (10 * log10(SWallF.TsSitu./SWallF.TsLabK));
SWallC.RSitu = SWallC.ReductionSitu - (10 * log10(SWallC.TsSitu./SWallC.TsLabK));
RWallR.RSitu = RWallR.ReductionSitu - (10 * log10(RWallR.TsSitu./RWallR.TsLabK));
RWallL.RSitu = RWallL.ReductionSitu - (10 * log10(RWallL.TsSitu./RWallL.TsLabK));
RWallB.RSitu = RWallB.ReductionSitu - (10 * log10(RWallB.TsSitu./RWallB.TsLabK));
RWallF.RSitu = RWallF.ReductionSitu - (10 * log10(RWallF.TsSitu./RWallF.TsLabK));
RWallC.RSitu = RWallC.ReductionSitu - (10 * log10(RWallC.TsSitu./RWallC.TsLabK));

%% Save the Results for Building Transmission Paths
ElementsResults.Partion = Partion;
ElementsResults.SWallR = SWallR;
ElementsResults.SWallL = SWallL;
ElementsResults.SWallB = SWallB;
ElementsResults.SWallF = SWallF;
ElementsResults.SWallC = SWallC;
ElementsResults.RWallR = RWallR;
ElementsResults.RWallL = RWallL;
ElementsResults.RWallB = RWallB;
ElementsResults.RWallF = RWallF;
ElementsResults.RWallC = RWallC;

%% Determination of the direction-averaged junction velocity level difference
DirAvgJuncVel = SI_DirectAvgJunctionVelocity(ElementsResults); % Dv,ij,situ

%% Determination of normalized flanking level difference
% [Dnfsit] = SI_NormFlankLevelDiffMeasurement(Dnflab,ta,Scs,ScsLab,Scr,ScrLab,hpl,hlab,AbsorbLining,f,Flag1);
% % Determination from performance of the elements
[Dnfij] = SI_NormFlankLevelDiff(ElementsResults, DirAvgJuncVel);

%% Determination of indirect airborne transmission from performance of system elements
Dns = SI_IndirectTransmission(ElementsResults, 0);

%% Calculation of Direct and Flancking Transmission in-Situ
% Type A Elements
RijALL = SI_FlankTransmissionRij(ElementsResults, DirAvgJuncVel);

%% Calculation Transmission Factors
% Td = TDd+TFd and Tf = TDf+TFf
TDd = 10.^(-RijALL.D / 10);
TFd = [10.^(-RijALL.RiD / 10)] + [10.^(-RijALL.LiD / 10)] + [10.^(-RijALL.BiD / 10)] + [10.^(-RijALL.FiD / 10)];
TDf = [10.^(-RijALL.DRj / 10)] + [10.^(-RijALL.DLj / 10)] + [10.^(-RijALL.DBj / 10)] + [10.^(-RijALL.DFj / 10)];
TFf = [10.^(-RijALL.RiRj / 10)] + [10.^(-RijALL.LiLj / 10)] + [10.^(-RijALL.BiBj / 10)] + [10.^(-RijALL.FiFj / 10)];
Td = TDd + TFd;
Tf = TDf + TFf;
tau = Td + Tf;
SoundREductionIndexTotal = -(10 * log10(tau));

%% Polts Detiled Results and Compare with EN123454-1 Example Model
plotID = 1;
if plotID == 1
    ResulsEN12354(Partion, f) %
    ResulsEN12354(SWallR, f)
    ResulsEN12354(SWallL, f)
    ResulsEN12354(SWallB, f)
    ResulsEN12354(SWallF, f)
    ResulsEN12354(SWallC, f) %
    ResulsEN12354(RWallR, f)
    ResulsEN12354(RWallL, f)
    ResulsEN12354(RWallB, f)
    ResulsEN12354(RWallF, f)
    ResulsEN12354(RWallC, f) %
elseif plotID == 2
    ResultsSoundReduction
end

%%

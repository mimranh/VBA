
%% ISO: EN 12354-1
% Building acoustics Estimation of acoustic performance of buildings from the performance of elements
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        1.1
% First release:  2017
% Last revision:  2017 (27.11.2017, Thursday)
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Airborne Sound Insulation between rooms
% Load Geometry Properties and the corrsponding Material Properties of the individual Elements of the Building by assigning the material
% charectristics from the material data

GeoUnity34;
Decay = 0;

%SaveasFolder = 0;      % no plots
plotID = 2;
%SaveasFolder = 'D:\sciebo\hiwi\Sound Insulation\Unity\Unity Models\BuildingAcousticDemo\Log\ReductionIndexCampareToMatlab\';

% GeometriesFlat % When Using this Config File use VibTranJunctionHeavysFlat Function at Line 51-61


% clear;clc
% GeometriesFlat % When Using this Config File use VibTranJunctionHeavysFlatOrignal Function at Line 51-61

% Geometries % When Using this Config File use VibTranJunctionHeavysV1 Function at Line 51-61
% GeometriesLab % When Using this Config File use VibTranJunctionHeavysLab Function at Line 51-61

%% Weighted Sound Reduction
[Partion.Rw, Partion.C, Partion.Ctr] = SI_ReductionWeighted(Partion);
[SWallR.Rw, SWallR.C, SWallR.Ctr] = SI_ReductionWeighted(SWallR);
[SWallL.Rw, SWallL.C, SWallL.Ctr] = SI_ReductionWeighted(SWallL);
[SWallB.Rw, SWallB.C, SWallB.Ctr] = SI_ReductionWeighted(SWallB);
[SWallF.Rw, SWallF.C, SWallF.Ctr] = SI_ReductionWeighted(SWallF);
[SWallC.Rw, SWallC.C, SWallC.Ctr] = SI_ReductionWeighted(SWallC);
[RWallR.Rw, RWallR.C, RWallR.Ctr] = SI_ReductionWeighted(RWallR);
[RWallL.Rw, RWallL.C, RWallL.Ctr] = SI_ReductionWeighted(RWallL);
[RWallB.Rw, RWallB.C, RWallB.Ctr] = SI_ReductionWeighted(RWallB);
[RWallF.Rw, RWallF.C, RWallF.Ctr] = SI_ReductionWeighted(RWallF);
[RWallC.Rw, RWallC.C, RWallC.Ctr] = SI_ReductionWeighted(RWallC);

%% Weighted Sound Reduction Improvement of Additional Layers
%[Partion.DRwSitu,Partion.DeltaRw] = SI_ReductionWeightedImprovement(Partion,LayerP,1,'Exterior',false,false,40);
%Partion.DeltaRwSitu = Partion.Rw + Partion.DRwSitu;
Partion.DeltaReduction = 30 * log10(f./LayerP.fc);

%% Radiation Factors
[Partion.SigmaForced, Partion.SigmaFW, Partion.RadiEfficiency] = SI_RadiationFactor(Partion);
[SWallR.SigmaForced, SWallR.SigmaFW, SWallR.RadiEfficiency] = SI_RadiationFactor(SWallR);
[SWallL.SigmaForced, SWallL.SigmaFW, SWallL.RadiEfficiency] = SI_RadiationFactor(SWallL);
[SWallB.SigmaForced, SWallB.SigmaFW, SWallB.RadiEfficiency] = SI_RadiationFactor(SWallB);
[SWallF.SigmaForced, SWallF.SigmaFW, SWallF.RadiEfficiency] = SI_RadiationFactor(SWallF);
[SWallC.SigmaForced, SWallC.SigmaFW, SWallC.RadiEfficiency] = SI_RadiationFactor(SWallC);
[RWallR.SigmaForced, RWallR.SigmaFW, RWallR.RadiEfficiency] = SI_RadiationFactor(RWallR);
[RWallL.SigmaForced, RWallL.SigmaFW, RWallL.RadiEfficiency] = SI_RadiationFactor(RWallL);
[RWallB.SigmaForced, RWallB.SigmaFW, RWallB.RadiEfficiency] = SI_RadiationFactor(RWallB);
[RWallF.SigmaForced, RWallF.SigmaFW, RWallF.RadiEfficiency] = SI_RadiationFactor(RWallF);
[RWallC.SigmaForced, RWallC.SigmaFW, RWallC.RadiEfficiency] = SI_RadiationFactor(RWallC);

%% Vibration transmission over junctions: Case of heavy buildings Kij
% Use VibTranJunctionHeavysV1 Function for ISO Exmaple (Geometries)
% Use VibTranJunctionHeavysFlat Function for Flat Exmaple (GeometriesFlat)

[Partion.JunctionKij, Partion.PrepMass] = SI_VibTranJunctionHeavysFlat(Partion, 'Empirical', Geo);
[SWallR.JunctionKij, SWallR.PrepMass] = SI_VibTranJunctionHeavysFlat(SWallR, 'Empirical', Geo);
[SWallL.JunctionKij, SWallL.PrepMass] = SI_VibTranJunctionHeavysFlat(SWallL, 'Empirical', Geo);
[SWallB.JunctionKij, SWallB.PrepMass] = SI_VibTranJunctionHeavysFlat(SWallB, 'Empirical', Geo);
[SWallF.JunctionKij, SWallF.PrepMass] = SI_VibTranJunctionHeavysFlat(SWallF, 'Empirical', Geo);
[SWallC.JunctionKij, SWallC.PrepMass] = SI_VibTranJunctionHeavysFlat(SWallC, 'Empirical', Geo);
[RWallR.JunctionKij, RWallR.PrepMass] = SI_VibTranJunctionHeavysFlat(RWallR, 'Empirical', Geo);
[RWallL.JunctionKij, RWallL.PrepMass] = SI_VibTranJunctionHeavysFlat(RWallL, 'Empirical', Geo);
[RWallB.JunctionKij, RWallB.PrepMass] = SI_VibTranJunctionHeavysFlat(RWallB, 'Empirical', Geo);
[RWallF.JunctionKij, RWallF.PrepMass] = SI_VibTranJunctionHeavysFlat(RWallF, 'Empirical', Geo);
[RWallC.JunctionKij, RWallC.PrepMass] = SI_VibTranJunctionHeavysFlat(RWallC, 'Empirical', Geo);

% [Partion.JunctionKij] = VibTranJunctionHeavysV1(Partion.ID,'Empirical');
% [SWallR.JunctionKij] = VibTranJunctionHeavysV1(SWallR.ID,'Empirical');
% [SWallL.JunctionKij] = VibTranJunctionHeavysV1(SWallL.ID,'Empirical');
% [SWallB.JunctionKij] = VibTranJunctionHeavysV1(SWallB.ID,'Empirical');
% [SWallF.JunctionKij] = VibTranJunctionHeavysV1(SWallF.ID,'Empirical');
% [SWallC.JunctionKij] = VibTranJunctionHeavysV1(SWallC.ID,'Empirical');
% [RWallR.JunctionKij] = VibTranJunctionHeavysV1(RWallR.ID,'Empirical');
% [RWallL.JunctionKij] = VibTranJunctionHeavysV1(RWallL.ID,'Empirical');
% [RWallB.JunctionKij] = VibTranJunctionHeavysV1(RWallB.ID,'Empirical');
% [RWallF.JunctionKij] = VibTranJunctionHeavysV1(RWallF.ID,'Empirical');
% [RWallC.JunctionKij] = VibTranJunctionHeavysV1(RWallC.ID,'Empirical');
% Method = 'Empirical';
% ElementID = Partion.ID; SI_VibTranJunctionHeavysFlat; Partion.JunctionKij = KIJ;
% ElementID = SWallR.ID; VibTranJunctionHeavysFlat; SWallR.JunctionKij = KIJ;
% ElementID = SWallL.ID; VibTranJunctionHeavysFlat; SWallL.JunctionKij = KIJ;
% ElementID = SWallB.ID; VibTranJunctionHeavysFlat; SWallB.JunctionKij = KIJ;
% ElementID = SWallF.ID; VibTranJunctionHeavysFlat; SWallF.JunctionKij = KIJ;
% ElementID = SWallC.ID; VibTranJunctionHeavysFlat; SWallC.JunctionKij = KIJ;
% ElementID = RWallR.ID; VibTranJunctionHeavysFlat; RWallR.JunctionKij = KIJ;
% ElementID = RWallL.ID; VibTranJunctionHeavysFlat; RWallL.JunctionKij = KIJ;
% ElementID = RWallB.ID; VibTranJunctionHeavysFlat; RWallB.JunctionKij = KIJ;
% ElementID = RWallF.ID; VibTranJunctionHeavysFlat; RWallF.JunctionKij = KIJ;
% ElementID = RWallC.ID; VibTranJunctionHeavysFlat; RWallC.JunctionKij = KIJ;

%% Absorption Coefficient (Alpha)
% AbsorptionCoefficientV1 file is Used for the ISO Standard Example Handling
[Partion.AlphaKSitu, Partion.AlphakLab, Partion.AlphAvg, Partion.Kijs] = SI_AbsorptionCoefficientV1(Partion, Geo);
[SWallR.AlphaKSitu, SWallR.AlphakLab, SWallR.AlphAvg, SWallR.Kijs] = SI_AbsorptionCoefficientV1(SWallR, Geo);
[SWallL.AlphaKSitu, SWallL.AlphakLab, SWallL.AlphAvg, SWallL.Kijs] = SI_AbsorptionCoefficientV1(SWallL, Geo);
[SWallB.AlphaKSitu, SWallB.AlphakLab, SWallB.AlphAvg, SWallB.Kijs] = SI_AbsorptionCoefficientV1(SWallB, Geo);
[SWallF.AlphaKSitu, SWallF.AlphakLab, SWallF.AlphAvg, SWallF.Kijs] = SI_AbsorptionCoefficientV1(SWallF, Geo);
[SWallC.AlphaKSitu, SWallC.AlphakLab, SWallC.AlphAvg, SWallC.Kijs] = SI_AbsorptionCoefficientV1(SWallC, Geo);
[RWallR.AlphaKSitu, RWallR.AlphakLab, RWallR.AlphAvg, RWallR.Kijs] = SI_AbsorptionCoefficientV1(RWallR, Geo);
[RWallL.AlphaKSitu, RWallL.AlphakLab, RWallL.AlphAvg, RWallL.Kijs] = SI_AbsorptionCoefficientV1(RWallL, Geo);
[RWallB.AlphaKSitu, RWallB.AlphakLab, RWallB.AlphAvg, RWallB.Kijs] = SI_AbsorptionCoefficientV1(RWallB, Geo);
[RWallF.AlphaKSitu, RWallF.AlphakLab, RWallF.AlphAvg, RWallF.Kijs] = SI_AbsorptionCoefficientV1(RWallF, Geo);
[RWallC.AlphaKSitu, RWallC.AlphakLab, RWallC.AlphAvg, RWallC.Kijs] = SI_AbsorptionCoefficientV1(RWallC, Geo);

%% Structural reverberation time and Total Loss Factor: Type A elements
[Partion.EtaSituG, Partion.EtaSitu, Partion.EtaLabK, Partion.EtaLab1, Partion.EtaLab2, Partion.TsLab, Partion.TsSitu, Partion.TsLab2, Partion.TsLabK] = SI_TotalLossFactor(Partion);
[SWallR.EtaSituG, SWallR.EtaSitu, SWallR.EtaLabK, SWallR.EtaLab1, SWallR.EtaLab2, SWallR.TsLab, SWallR.TsSitu, SWallR.TsLab2, SWallR.TsLabK] = SI_TotalLossFactor(SWallR);
[SWallL.EtaSituG, SWallL.EtaSitu, SWallL.EtaLabK, SWallL.EtaLab1, SWallL.EtaLab2, SWallL.TsLab, SWallL.TsSitu, SWallL.TsLab2, SWallL.TsLabK] = SI_TotalLossFactor(SWallL);
[SWallB.EtaSituG, SWallB.EtaSitu, SWallB.EtaLabK, SWallB.EtaLab1, SWallB.EtaLab2, SWallB.TsLab, SWallB.TsSitu, SWallB.TsLab2, SWallB.TsLabK] = SI_TotalLossFactor(SWallB);
[SWallF.EtaSituG, SWallF.EtaSitu, SWallF.EtaLabK, SWallF.EtaLab1, SWallF.EtaLab2, SWallF.TsLab, SWallF.TsSitu, SWallF.TsLab2, SWallF.TsLabK] = SI_TotalLossFactor(SWallF);
[SWallC.EtaSituG, SWallC.EtaSitu, SWallC.EtaLabK, SWallC.EtaLab1, SWallC.EtaLab2, SWallC.TsLab, SWallC.TsSitu, SWallC.TsLab2, SWallC.TsLabK] = SI_TotalLossFactor(SWallC);
[RWallR.EtaSituG, RWallR.EtaSitu, RWallR.EtaLabK, RWallR.EtaLab1, RWallR.EtaLab2, RWallR.TsLab, RWallR.TsSitu, RWallR.TsLab2, RWallR.TsLabK] = SI_TotalLossFactor(RWallR);
[RWallL.EtaSituG, RWallL.EtaSitu, RWallL.EtaLabK, RWallL.EtaLab1, RWallL.EtaLab2, RWallL.TsLab, RWallL.TsSitu, RWallL.TsLab2, RWallL.TsLabK] = SI_TotalLossFactor(RWallL);
[RWallB.EtaSituG, RWallB.EtaSitu, RWallB.EtaLabK, RWallB.EtaLab1, RWallB.EtaLab2, RWallB.TsLab, RWallB.TsSitu, RWallB.TsLab2, RWallB.TsLabK] = SI_TotalLossFactor(RWallB);
[RWallF.EtaSituG, RWallF.EtaSitu, RWallF.EtaLabK, RWallF.EtaLab1, RWallF.EtaLab2, RWallF.TsLab, RWallF.TsSitu, RWallF.TsLab2, RWallF.TsLabK] = SI_TotalLossFactor(RWallF);
[RWallC.EtaSituG, RWallC.EtaSitu, RWallC.EtaLabK, RWallC.EtaLab1, RWallC.EtaLab2, RWallC.TsLab, RWallC.TsSitu, RWallC.TsLab2, RWallC.TsLabK] = SI_TotalLossFactor(RWallC);

%% The Equivalent Absorption Length
[Partion.EquAbsorptionLength] = SI_EquAbsorpLength(Partion);
[SWallR.EquAbsorptionLength] = SI_EquAbsorpLength(SWallR);
[SWallL.EquAbsorptionLength] = SI_EquAbsorpLength(SWallL);
[SWallB.EquAbsorptionLength] = SI_EquAbsorpLength(SWallB);
[SWallF.EquAbsorptionLength] = SI_EquAbsorpLength(SWallF);
[SWallC.EquAbsorptionLength] = SI_EquAbsorpLength(SWallC);
[RWallR.EquAbsorptionLength] = SI_EquAbsorpLength(RWallR);
[RWallL.EquAbsorptionLength] = SI_EquAbsorpLength(RWallL);
[RWallB.EquAbsorptionLength] = SI_EquAbsorpLength(RWallB);
[RWallF.EquAbsorptionLength] = SI_EquAbsorpLength(RWallF);
[RWallC.EquAbsorptionLength] = SI_EquAbsorpLength(RWallC);

%% Radiation Factors for Resonance Transmission
[Partion.SigmaS, Partion.SigmaA] = SI_RadiationFactorResonant(Partion);
[SWallR.SigmaS, SWallR.SigmaA] = SI_RadiationFactorResonant(SWallR);
[SWallL.SigmaS, SWallL.SigmaA] = SI_RadiationFactorResonant(SWallL);
[SWallB.SigmaS, SWallB.SigmaA] = SI_RadiationFactorResonant(SWallB);
[SWallF.SigmaS, SWallF.SigmaA] = SI_RadiationFactorResonant(SWallF);
[SWallC.SigmaS, SWallC.SigmaA] = SI_RadiationFactorResonant(SWallC);
[RWallR.SigmaS, RWallR.SigmaA] = SI_RadiationFactorResonant(RWallR);
[RWallL.SigmaS, RWallL.SigmaA] = SI_RadiationFactorResonant(RWallL);
[RWallB.SigmaS, RWallB.SigmaA] = SI_RadiationFactorResonant(RWallB);
[RWallF.SigmaS, RWallF.SigmaA] = SI_RadiationFactorResonant(RWallF);
[RWallC.SigmaS, RWallC.SigmaA] = SI_RadiationFactorResonant(RWallC);

%% Tansmission Coefficient
[Partion.TauLab, Partion.TauSituGen, Partion.TauSitu] = SI_TansmissionCoefficient(Partion);
[SWallR.TauLab, SWallR.TauSituGen, SWallR.TauSitu] = SI_TansmissionCoefficient(SWallR);
[SWallL.TauLab, SWallL.TauSituGen, SWallL.TauSitu] = SI_TansmissionCoefficient(SWallL);
[SWallB.TauLab, SWallB.TauSituGen, SWallB.TauSitu] = SI_TansmissionCoefficient(SWallB);
[SWallF.TauLab, SWallF.TauSituGen, SWallF.TauSitu] = SI_TansmissionCoefficient(SWallF);
[SWallC.TauLab, SWallC.TauSituGen, SWallC.TauSitu] = SI_TansmissionCoefficient(SWallC);
[RWallR.TauLab, RWallR.TauSituGen, RWallR.TauSitu] = SI_TansmissionCoefficient(RWallR);
[RWallL.TauLab, RWallL.TauSituGen, RWallL.TauSitu] = SI_TansmissionCoefficient(RWallL);
[RWallB.TauLab, RWallB.TauSituGen, RWallB.TauSitu] = SI_TansmissionCoefficient(RWallB);
[RWallF.TauLab, RWallF.TauSituGen, RWallF.TauSitu] = SI_TansmissionCoefficient(RWallF);
[RWallC.TauLab, RWallC.TauSituGen, RWallC.TauSitu] = SI_TansmissionCoefficient(RWallC);

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
Dnfij = SI_NormFlankLevelDiff(ElementsResults, DirAvgJuncVel);

%% Determination of indirect airborne transmission from performance of system elements
Dns = SI_IndirectTransmission(ElementsResults, 0);

%% Calculation of Direct and Flancking Transmission in-Situ
% Type A Elements
RijALL = SI_FlankTransmissionRij(ElementsResults, DirAvgJuncVel, false);

if Decay == 1
    SI_ApplyDecay;
else
end

%% Calculation Transmission Factors
TDd = 10.^(-RijALL.D / 10);
TFd = 10.^(-RijALL.RiD / 10) + 10.^(-RijALL.LiD / 10) + 10.^(-RijALL.BiD / 10) + 10.^(-RijALL.FiD / 10);
% TDf = 10.^(-RijALL.DRj/10) + 10.^(-RijALL.DLj/10) + 10.^(-RijALL.DBj/10) + 10.^(-RijALL.DFj/10);
% TFf = 10.^(-RijALL.RiRj/10) + 10.^(-RijALL.LiLj/10) + 10.^(-RijALL.BiBj/10) + 10.^(-RijALL.FiFj/10);

%%%%%%%%%%%%% Secondary Sources %%%%%%%%%
Td = TDd + TFd; % OK
Tf1 = 10.^(-RijALL.DRj / 10) + 10.^(-RijALL.RiRj / 10);
Tf2 = 10.^(-RijALL.DLj / 10) + 10.^(-RijALL.LiLj / 10);
Tf3 = 10.^(-RijALL.DBj / 10) + 10.^(-RijALL.BiBj / 10);
Tf4 = 10.^(-RijALL.DFj / 10) + 10.^(-RijALL.FiFj / 10);
TT = Td + Tf1 + Tf2 + Tf3 + Tf4;

%% Plots Detiled Results and Compare with EN123454-1 Example Model

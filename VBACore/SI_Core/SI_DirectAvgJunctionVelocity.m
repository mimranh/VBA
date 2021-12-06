function [DirAvgJuncVel] = SI_DirectAvgJunctionVelocity(ElementsResults)

%%
Kij = ElementsResults.Partion.JunctionKij;
J1 = Kij{1, 1};
J2 = Kij{2, 1};
J3 = Kij{3, 1};
J4 = Kij{4, 1};
KDRj = J1(1, 1);
KDLj = J2(1, 1);
KDCj = J3(1, 1);
KDFj = J4(1, 1);
KRiD = J1(2, 2);
KLiD = J2(2, 2);
KCiD = J3(2, 2);
KFiD = J4(2, 2);
KRiRj = J1(3, 1);
KLiLj = J2(3, 1);
KCiCj = J3(3, 1);
KFiFj = J4(3, 1);
ALD = ElementsResults.Partion.EquAbsorptionLength;
ALRi = ElementsResults.SWallR.EquAbsorptionLength;
ALLi = ElementsResults.SWallL.EquAbsorptionLength;
ALCi = ElementsResults.SWallC.EquAbsorptionLength;
ALFi = ElementsResults.SWallF.EquAbsorptionLength;
ALRj = ElementsResults.RWallR.EquAbsorptionLength;
ALLj = ElementsResults.RWallL.EquAbsorptionLength;
ALCj = ElementsResults.RWallC.EquAbsorptionLength;
ALFj = ElementsResults.RWallF.EquAbsorptionLength;
LDRj = ElementsResults.Partion.Length;
LDLj = ElementsResults.Partion.Width;
LDCj = ElementsResults.Partion.Length;
LDFj = ElementsResults.Partion.Width;
LRiD = ElementsResults.Partion.Length;
LLiD = ElementsResults.Partion.Width;
LCiD = ElementsResults.Partion.Length;
LFiD = ElementsResults.Partion.Width;
LRiRj = ElementsResults.Partion.Length;
LLiLj = ElementsResults.Partion.Width;
LCiCj = ElementsResults.Partion.Length;
LFiFj = ElementsResults.Partion.Width;
%
DirAvgJuncVel.DRj = KDRj - 10 * log10(LDRj./sqrt(ALD.*ALRj));
DirAvgJuncVel.DLj = KDLj - 10 * log10(LDLj./sqrt(ALD.*ALLj));
DirAvgJuncVel.DCj = KDCj - 10 * log10(LDCj./sqrt(ALD.*ALCj));
DirAvgJuncVel.DFj = KDFj - 10 * log10(LDFj./sqrt(ALD.*ALFj));
DirAvgJuncVel.RiD = KRiD - 10 * log10(LRiD./sqrt(ALRi.*ALD));
DirAvgJuncVel.LiD = KLiD - 10 * log10(LLiD./sqrt(ALLi.*ALD));
DirAvgJuncVel.CiD = KCiD - 10 * log10(LCiD./sqrt(ALCi.*ALD));
DirAvgJuncVel.FiD = KFiD - 10 * log10(LFiD./sqrt(ALFi.*ALD));
DirAvgJuncVel.RiRj = KRiRj - 10 * log10(LRiRj./sqrt(ALRi.*ALRj));
DirAvgJuncVel.LiLj = KLiLj - 10 * log10(LLiLj./sqrt(ALLi.*ALLj));
DirAvgJuncVel.CiCj = KCiCj - 10 * log10(LCiCj./sqrt(ALCi.*ALCj));
DirAvgJuncVel.FiFj = KFiFj - 10 * log10(LFiFj./sqrt(ALFi.*ALFj));

%%

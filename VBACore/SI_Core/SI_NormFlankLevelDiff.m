function [Dnfij] = SI_NormFlankLevelDiff(ElementsResults, DirAvgJuncVel)
%
% This Function Calculates the normalized flanking level difference
%
% INPUTS:
%   Dnflab = Measured Flanking Level Difference
%   ta = Thickness of the absorbing lining in the plenum, in metres
%   Scs = Area of the ceiling in the receiving room
%   ScsLab = Area of the ceiling source room for the laboratory
%   Scr = Area of the ceiling in the source room and receiving room
%   ScrLab = Area of the ceiling in receiving room for the laboratory
%   hpl = Free height of the plenum above the ceiling
%   hlab = Free height of the plenum above the ceiling for the laboratory
%   Flag1 = true if Determination from performance of the elements
%         = flase if Determination from Measured Flanking Level Difference
%   Flag2 = ture if the structure-borne transmission is Dominant
%         = false if the structure-borne transmission is Dominant
%
% OUTPUTS:
%   Dnfsit = is normalized flanking level difference from Measurements
%   Dnfij = is normalized flanking level difference from the performance of elements
%
% USAGE Example:
%   [Dnfsit,Dnfij] = NormFlankLevelDiff(Dnflab,ta,Scs,ScsLab,Scr,ScrLab,hpl,hlab,AbsorbLining,f,Flag1,Flag2);
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Determination of normalized flanking level difference
% Determination from performance of the elements

A0 = 10;
RedD = ElementsResults.Partion.RSitu;
RedRi = ElementsResults.SWallR.RSitu;
RedRj = ElementsResults.RWallR.RSitu;
RedLi = ElementsResults.SWallL.RSitu;
RedLj = ElementsResults.RWallL.RSitu;
RedCi = ElementsResults.SWallC.RSitu;
RedCj = ElementsResults.RWallC.RSitu;
RedFi = ElementsResults.SWallF.RSitu;
RedFj = ElementsResults.RWallF.RSitu;
LDRj = ElementsResults.Partion.Length;
LDLj = ElementsResults.Partion.Width;
LDBj = ElementsResults.Partion.Length;
LDFj = ElementsResults.Partion.Width;
LRiD = ElementsResults.Partion.Length;
LLiD = ElementsResults.Partion.Width;
LBiD = ElementsResults.Partion.Length;
LFiD = ElementsResults.Partion.Width;
LRiRj = ElementsResults.Partion.Length;
LLiLj = ElementsResults.Partion.Width;
LBiBj = ElementsResults.Partion.Length;
LFiFj = ElementsResults.Partion.Width;

Dnfij.D = RedD;
Dnfij.DRj = RedD / 2 + RedRj / 2 + DirAvgJuncVel.DRj + 10 * log(A0./LDRj);
Dnfij.DLj = RedD / 2 + RedLj / 2 + DirAvgJuncVel.DLj + 10 * log(A0./LDLj);
Dnfij.DCj = RedD / 2 + RedCj / 2 + DirAvgJuncVel.DCj + 10 * log(A0./LDBj);
Dnfij.DFj = RedD / 2 + RedFj / 2 + DirAvgJuncVel.DFj + 10 * log(A0./LDFj);
Dnfij.RiD = RedRi / 2 + RedD / 2 + DirAvgJuncVel.RiD + 10 * log(A0./LRiD);
Dnfij.LiD = RedLi / 2 + RedD / 2 + DirAvgJuncVel.LiD + 10 * log(A0./LLiD);
Dnfij.BiD = RedCi / 2 + RedD / 2 + DirAvgJuncVel.CiD + 10 * log(A0./LBiD);
Dnfij.FiD = RedFi / 2 + RedD / 2 + DirAvgJuncVel.FiD + 10 * log(A0./LFiD);
Dnfij.RiRj = RedRi / 2 + RedRj / 2 + DirAvgJuncVel.RiRj + 10 * log(A0./LRiRj);
Dnfij.LiLj = RedLi / 2 + RedLj / 2 + DirAvgJuncVel.LiLj + 10 * log(A0./LLiLj);
Dnfij.BiBj = RedCi / 2 + RedCj / 2 + DirAvgJuncVel.CiCj + 10 * log(A0./LBiBj);
Dnfij.FiFj = RedFi / 2 + RedFj / 2 + DirAvgJuncVel.FiFj + 10 * log(A0./LFiFj);

%%
%

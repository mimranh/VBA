function Rij = SI_FlankTransmissionRij(ElementsResults, DirAvgJuncVel, Value)
%

%%
SD = ElementsResults.Partion.Area;
SRi = ElementsResults.SWallR.Area;
SLi = ElementsResults.SWallL.Area;
SCi = ElementsResults.SWallC.Area;
SFi = ElementsResults.SWallF.Area;
SRj = ElementsResults.RWallR.Area;
SLj = ElementsResults.RWallL.Area;
SCj = ElementsResults.RWallC.Area;
SFj = ElementsResults.RWallF.Area;
RedD = ElementsResults.Partion.RSitu;
RedRi = ElementsResults.SWallR.RSitu;
RedRj = ElementsResults.RWallR.RSitu;
RedLi = ElementsResults.SWallL.RSitu;
RedLj = ElementsResults.RWallL.RSitu;
RedCi = ElementsResults.SWallC.RSitu;
RedCj = ElementsResults.RWallC.RSitu;
RedFi = ElementsResults.SWallF.RSitu;
RedFj = ElementsResults.RWallF.RSitu;
%
if Value == false
    Rij.D = RedD;
    Rij.DRj = RedD / 2 + RedRj / 2 + DirAvgJuncVel.DRj + 10 * log((SD)./sqrt(SD.*SRj));
    Rij.DLj = RedD / 2 + RedLj / 2 + DirAvgJuncVel.DLj + 10 * log((SD)./sqrt(SD.*SLj));
    Rij.DCj = RedD / 2 + RedCj / 2 + DirAvgJuncVel.DCj + 10 * log((SD)./sqrt(SD.*SCj));
    Rij.DFj = RedD / 2 + RedFj / 2 + DirAvgJuncVel.DFj + 10 * log((SD)./sqrt(SD.*SFj));
elseif Value == true
    Rij.D = RedD + ElementsResults.Partion.DeltaReduction;
    Rij.DRj = RedD / 2 + RedRj / 2 + DirAvgJuncVel.DRj + 10 * log((SD)./sqrt(SD.*SRj)) + ElementsResults.Partion.DeltaReduction;
    Rij.DLj = RedD / 2 + RedLj / 2 + DirAvgJuncVel.DLj + 10 * log((SD)./sqrt(SD.*SLj)) + ElementsResults.Partion.DeltaReduction;
    Rij.DCj = RedD / 2 + RedCj / 2 + DirAvgJuncVel.DCj + 10 * log((SD)./sqrt(SD.*SCj)) + ElementsResults.Partion.DeltaReduction;
    Rij.DFj = RedD / 2 + RedFj / 2 + DirAvgJuncVel.DFj + 10 * log((SD)./sqrt(SD.*SFj)) + ElementsResults.Partion.DeltaReduction;
end

Rij.RiD = RedRi / 2 + RedD / 2 + DirAvgJuncVel.RiD + 10 * log((SD)./sqrt(SRi.*SD));

Rij.LiD = RedLi / 2 + RedD / 2 + DirAvgJuncVel.LiD + 10 * log((SD)./sqrt(SLi.*SD));
Rij.CiD = RedCi / 2 + RedD / 2 + DirAvgJuncVel.CiD + 10 * log((SD)./sqrt(SCi.*SD));
Rij.FiD = RedFi / 2 + RedD / 2 + DirAvgJuncVel.FiD + 10 * log((SD)./sqrt(SFi.*SD));
Rij.RiRj = RedRi / 2 + RedRj / 2 + DirAvgJuncVel.RiRj + 10 * log((SD)./sqrt(SRi.*SRj));
Rij.LiLj = RedLi / 2 + RedLj / 2 + DirAvgJuncVel.LiLj + 10 * log((SD)./sqrt(SLi.*SLj));
Rij.CiCj = RedCi / 2 + RedCj / 2 + DirAvgJuncVel.CiCj + 10 * log((SD)./sqrt(SCi.*SCj));
Rij.FiFj = RedFi / 2 + RedFj / 2 + DirAvgJuncVel.FiFj + 10 * log((SD)./sqrt(SFi.*SFj));

%%

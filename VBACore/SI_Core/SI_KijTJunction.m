function [Kij] = SI_KijTJunction(AttachedMass)
MK12Ratio = (log10(AttachedMass(2)./AttachedMass(1)));
K12 = 5.7 + 5.7 * MK12Ratio.^2;
MK13Ratio = (log10(AttachedMass(2)./AttachedMass(1)));
%                 if strcmp(ElementID,'SWallB') || strcmp(ElementID,'SWallF')
%                     MK13Ratio = abs(MK13Ratio);
%                 else
%                 end
K13 = 5.7 + 14.1 * MK13Ratio + 5.7 * MK13Ratio.^2;
K21 = K12;
K23 = K12;
K31 = K13;
K32 = K23;
Kij = [0, K21, K31; ...
    K12, 0, K32; ...
    K13, K23,0];
end

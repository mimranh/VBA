function [Kij] = SI_KijCrossJunction(AttachedMass)

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



Kij = [0, K21, K31, K41; ...
    K12, 0, K32, K42; ...
    K13, K23,0, K43; ...
    K14, K24, K34, 0];

end


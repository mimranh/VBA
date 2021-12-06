function [Kij] = JunctionSol(Junction, NumberofJunctions)

for J = 1:NumberofJunctions
    Jun = Junction{J};
    [Kij] = VibTranJunctionHeavys(Jun.Elements(2:end), Jun.Elements(1), Jun.Type, 'Empirical');
    
end

function [TauLab, TauSituGen, TauSitu] = SI_TansmissionCoefficient(Elements)
%
% This Function Calculates the Tansmission Coefficient
%
% INPUTS:
%   MEle = is the mass per unit area, in kilograms per square metres
%   EtaTotalLab1 = is the total loss factor (for the laboratory situation)
%   SigmaFW = is the radiation factor for free bending waves
%   SigmaForced = is the radiation factor for forced transmission
%   EtaTotalSituGeneral = is the total loss factor (from Empirical Formula)
%   EtaTotalSitu = is the total loss factor in-Situ
%   Alphak = is the absorption coefficient for bending waves at the perimeter k
%   f = is the frequency in Hertz
%   fc = is the critical frequency
%   c0 = is Specd of Sound in air
%   Rho0 = is density of air
%
% OUTPUTS:
%   TauLab = Transmission factor
%   TauSituGen = Transmission factor in-Situ Genaral (from Empirical Formula)
%   TauSitu = Transmission factor in-Situ
%
% USAGE Example:
%   [TauLab,TauSituGen,TauSitu] = TansmissionCoefficient(MassElement,EtaTotalLab1,SigmaFW,SigmaForced,EtaTotalSituGeneral,EtaTotalSitu,f,fc,c0,Rho0,cL,Rho);
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Tansmission Coefficient
SI_constants;
MassElement = Elements.Mass;
EtaTotalLab1 = Elements.EtaLab1;
SigmaFW = Elements.SigmaFW;
SigmaForced = Elements.SigmaForced;
EtaTotalSituGeneral = Elements.EtaSituG;
EtaTotalSitu = Elements.EtaSitu;
fc = Elements.fc;
cL = Elements.QuasiLongPhaseVelocity;
Rho = Elements.Density;

% Based on Loss factor from Lab Situation
EtaTotalLab = EtaTotalLab1;
TauLab = nan(1, length(f));
% SigmaFW = 1/0.71;
for i = 1:length(f)
    TauPlateau = (((4 * Rho0 .* c0) ./ (1.1 * cL .* Rho)).^2) .* (0.02 ./ EtaTotalLab(i));
    if f(i) < fc / 1.12
        TauLab(i) = (((2 * Rho0 * c0) ./ (2 * pi * f(i) .* MassElement)).^2) .* ((2 * SigmaForced(i) .* ((1 - f(i).^2) ./ (fc.^2)).^-2) + ((2 * pi * fc * SigmaFW(i).^2) ./ (4 * f(i) .* EtaTotalLab(i))));
    elseif f(i) >= fc / 1.12 && f(i) <= fc * 1.4
        TauLab(i) = (((2 * Rho0 * c0) ./ (2 * pi * fc .* MassElement)).^2) .* ((pi .* SigmaFW(i).^2) ./ (2 * EtaTotalLab(i)));
    elseif f(i) > fc * 1.4 && f(i) < 3000
        TauLab(i) = (((2 * Rho0 * c0) ./ (2 * pi .* f(i) .* MassElement)).^2) .* ((pi * fc .* SigmaFW(i).^2) ./ (2 * f(i) .* EtaTotalLab(i)));
        if TauLab(i) < TauPlateau
            TauLab(i) = TauPlateau;
        else
        end
    end
end

% Based on In-Situ Total Loss factor Genral
TauSituGen = nan(1, length(f));
for i = 1:length(f)
    TauPlateau = (((4 * Rho0 .* c0) ./ (1.1 * cL .* Rho)).^2) .* (0.02 ./ EtaTotalSituGeneral(i));
    if f(i) < fc / 1.12
        TauSituGen(i) = (((2 * Rho0 * c0) ./ (2 * pi * f(i) .* MassElement)).^2) .* ((2 * SigmaForced(i) .* ((1 - f(i).^2) ./ (fc.^2)).^-2) + ((2 * pi * fc * SigmaFW(i).^2) ./ (4 * f(i) .* EtaTotalSituGeneral(i))));
    elseif f(i) >= fc / 1.12 && f(i) <= fc * 1.4
        TauSituGen(i) = (((2 * Rho0 * c0) ./ (2 * pi * f(i) .* MassElement)).^2) .* ((pi .* SigmaFW(i).^2) ./ (2 * EtaTotalSituGeneral(i)));
    elseif f(i) > fc * 1.4
        TauSituGen(i) = (((2 * Rho0 * c0) ./ (2 * pi .* f(i) .* MassElement)).^2) .* ((pi * fc .* SigmaFW(i).^2) ./ (2 * f(i) .* EtaTotalSituGeneral(i)));
        if TauSituGen(i) < TauPlateau
            TauSituGen(i) = TauPlateau;
        else
        end
    end
end

% Based on In-Situ Total Loss factor including Kij
% This COndition is only for Calculations of EN: 12354-1 Building Situation
% (Problem to Select th eHigher Frequency Limit)

for i = 1:length(f)
    TauPlateau = (((4*Rho0.*c0)./(1.1*cL.*Rho)).^2).*(0.02./EtaTotalSitu(i));
    if f(i)<fc/1.12
        TauSitu(i) = (((2*Rho0*c0)./(2*pi*f(i).*MassElement)).^2).*((2*SigmaForced(i).*((1-f(i).^2)./(fc.^2)).^-2)+((2*pi*fc*SigmaFW(i).^2)./(4*f(i).*EtaTotalSitu(i))));
    elseif f(i)>=fc/1.12 && f(i)<=fc*1.4
        TauSitu(i) = (((2*Rho0*c0)./(2*pi*f(i).*MassElement)).^2).*((pi.*SigmaFW(i).^2)./(2*EtaTotalSitu(i)));
    elseif f(i)>fc*1.4
        TauSitu(i) = (((2*Rho0*c0)./(2*pi.*f(i).*MassElement)).^2).*((pi*fc.*SigmaFW(i).^2)./(2*f(i).*EtaTotalSitu(i)));
        if TauSitu(i) < TauPlateau
            TauSitu(i) = TauPlateau;
        else
        end
    end
end

% TauSitu = zeros(size(f));
% for i = 1:length(f)
%     TauPlateau = (((4 * Rho0 .* c0) ./ (1.1 * cL .* Rho)).^2) .* (0.02 ./ EtaTotalSitu(i));
%     if f(i) < fc
%         TauSitu(i) = (((2 * Rho0 * c0) ./ (2 * pi * f(i) .* MassElement)).^2) .* ((2 * SigmaForced(i) .* ((1 - f(i).^2) ./ (fc.^2)).^-2) + ((2 * pi * fc * SigmaFW(i).^2) ./ (4 * f(i) .* EtaTotalSitu(i))));
%         TauSituF(i) = (((2 * Rho0 * c0) ./ (2 * pi * f(i) .* MassElement)).^2) .* ((2 * pi * fc * SigmaFW(i).^2) ./ (4 * f(i) .* EtaTotalSitu(i))));
%         TauSituT(i) = (((2 * Rho0 * c0) ./ (2 * pi * f(i) .* MassElement)).^2) .* ((2 * SigmaForced(i) .* ((1 - f(i).^2) ./ (fc.^2)).^-2) + ((2 * pi * fc * SigmaFW(i).^2) ./ (4 * f(i) .* EtaTotalSitu(i))));
%     elseif f(i) > fc
%         TauSitu(i) = (((2 * Rho0 * c0) ./ (2 * pi .* f(i) .* MassElement)).^2) .* ((pi * fc .* SigmaFW(i).^2) ./ (2 * f(i) .* EtaTotalSitu(i)));
%         if TauSitu(i) < TauPlateau
%             TauSitu(i) = TauPlateau;
%         end
%     end
% end
%

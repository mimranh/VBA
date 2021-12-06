function [TauSitu, TauFW, TauForced, TauPlateau] = GetTauSitu(Wall, EtaTotalSitu)
SI_constants;
MassElement = Wall.Mass;
SigmaFW = Wall.SigmaFW;
SigmaForced = Wall.SigmaForced;
fc = Wall.fc;
cL = Wall.QuasiLongPhaseVelocity;
Rho = Wall.Density;
TauSitu = zeros(size(f));
for i = 1:length(f)
    TauPlateaui = (((4 * Rho0 .* c0) ./ (1.1 * cL .* Rho)).^2) .* (0.02 ./ EtaTotalSitu(i));
    if f(i) < fc
        TauSitu(i) = (((2 * Rho0 * c0) ./ (2 * pi * f(i) .* MassElement)).^2) .* ((2 * SigmaForced(i) .* ((1 - f(i).^2) ./ (fc.^2)).^-2) + ((2 * pi * fc * SigmaFW(i).^2) ./ (4 * f(i) .* EtaTotalSitu(i))));
    elseif f(i) > fc
        TauSitu(i) = (((2 * Rho0 * c0) ./ (2 * pi .* f(i) .* MassElement)).^2) .* ((pi * fc .* SigmaFW(i).^2) ./ (2 * f(i) .* EtaTotalSitu(i)));
        if TauSitu(i) < TauPlateaui
            TauSitu(i) = TauPlateaui;
        end
    end
end

tau0 = (((2 * Rho0 * c0) ./ (2 * pi * f .* MassElement)).^2);
TauPlateau = (((4 * Rho0 .* c0) ./ (1.1 * cL .* Rho)).^2) .* (0.02 ./ EtaTotalSitu);

TauFW = tau0 .* (((2 * pi * fc * SigmaFW.^2) ./ (4 * f .* EtaTotalSitu)));
TauForced = tau0 .* ((2 * SigmaForced .* ((1 - f.^2) ./ (fc.^2)).^-2));
TauForced(f > fc) = zeros(sum(f > fc), 1);
TauFW(TauFW < TauPlateau) = TauPlateau(TauFW < TauPlateau);

%%
% figure;
% semilogx(f, -10*log10(TauSitu));
% hold on; grid on;
% semilogx(f, -10*log10(TauFW+TauForced));
% semilogx(f, -10*log10(TauForced), '--');
% semilogx(f, -10*log10(TauFW), '--');
% semilogx(f, -10*log10(TauPlateau), '--');

end
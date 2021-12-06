function [EtaTotalSituGeneral, EtaTotalSitu, EtaTotalLabK, EtaTotalLab1, EtaTotalLab2, TsLab, TsSitu, TsLab2, TsLabK, EtaElementRoom, EtaJunction] ...
    = SI_TotalLossFactorSingle(ElementMass ,EtaInitial ,Material ,S ,fc ,SigmaFeeWave,Factor)
%
% This Function Calculates the Structural reverberation time and Total Loss Factor: Type A elements
%
% INPUTS:
%   ElementMass = Mass of the Element in Kg/m2 (e.g.: 460)
%   EtaInitial = The internal loss factor of the material (Constant)
%   Material = Type of the Material of Element
%   Lk = The length of the junction at the perimeter k, in metres
%   AlphaK = The absorption coefficient for bending waves at the perimeter k
%   S = Area of the element, in square metres
%   f = Octave Frequency
%   fc = Critical Frequency
%   c0 = Speed of Sound in air, in metres per second; co = 340 m/s;
%   Rho0 = The density of air, in kilogram per cubic metres
%
% OUTPUTS:
%   EtaTotalLab1 = Total Loss Factor for Lab Formula 1
%   EtaTotalLab2 = Total Loss Factor for Lab Formula 2
%   EtaTotalSituGeneral = Total Loss Factor for In Situ from General Formula
%   EtaTotalSitu = Total Loss Factor for In Situ
%   Ts = Structural reverberation
%   TsSitu = Structural reverberation In Situ
%
% USAGE Example:
%   [EtaTotalLab1,EtaTotalLab2,EtaTotalSituGeneral,EtaTotalSitu,Ts] = TotalLossFactor(MEle,EtaInitial,'Concerete',Lk,Alphak,S,f,fc,c0,Rho0);
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Structural reverberation time and Total Loss Factor: Type A elements
SI_constants

% Laboratory situation (for heavy constructions (around 400kg/m2)) and (below 800kg/m2)
if ElementMass >= 400 && ElementMass <= 800
    EtaTotalLab1 = EtaInitial + ElementMass ./ (485 * sqrt(f));
    EtaTotalLab2 = 0.01 + ElementMass ./ (485 * sqrt(f));
else
    %     Temporary
    EtaTotalLab1 = EtaInitial + ElementMass ./ (485 * sqrt(f));
    EtaTotalLab2 = 0.01 + ElementMass ./ (485 * sqrt(f));
end
Factor1 = sum(Factor);

%fc = 76.8;
EtaTotalLabK = EtaInitial + ((2 * Rho0 * c0 .* SigmaFeeWave) ./ (2 * pi * f * ElementMass)) + (c0 ./ ((pi.^2) * S .* sqrt(f.*fc))) .* Factor1;
%
% In-Situ
% 1. General
if ElementMass > 150 && ElementMass < 800 % Gereman Standard
    c = 0.5;
elseif ElementMass > 800
    c = 0.005;
elseif strcmp(Material, 'Concerete')
    c = 1;
elseif ElementMass < 150 % Gereman Standard
    c = ElementMass / 300;
    EtaInitial = 0.005;
else
end
EtaTotalSituGeneral = EtaInitial + c ./ sqrt(f);
%
% 2. Detailed including Kij (AlphK = sum())
EtaTotalSitu = EtaInitial + ((2 * Rho0 * c0 .* SigmaFeeWave) ./ (2 * pi * f * ElementMass)) + (c0 ./ ((pi.^2) * S .* sqrt(f.*fc))) .* Factor1;
EtaElementRoom = ((2 * Rho0 * c0 .* SigmaFeeWave) ./ (2 * pi * f * ElementMass));
EtaJunction = (c0 ./ ((pi.^2) * S .* sqrt(f.*fc))) .* Factor1;
% EtaTotal = EtaTotalG;
% Structural Reverberation Time
TsSitu = (2.2) ./ (f .* EtaTotalSitu);
TsLab = (2.2) ./ (f .* EtaTotalLab1);
TsLab2 = (2.2) ./ (f .* EtaTotalLab2);
TsLabK = (2.2) ./ (f .* EtaTotalLabK);

%%
% [TauSitu,TauSituFW,TauSituForced,TauSituPlateau] = GetTauSitu(Elements, EtaTotalSitu);
% [TauInternal,TauInternalFW,TauInternalForced] = GetTauSitu(Elements, zeros(size(f)) + Elements.InternalLossFactor);
% [TauElementRoom,TauElementRoomFW,TauElementRoomForced] = GetTauSitu(Elements, EtaElementRoom);
% [TauJunction(1, :),TauJunctionFW(1, :),TauJunctionForced(1, :)] = GetTauSitu(Elements, EtaJunction(1, :));
% [TauJunction(2, :),TauJunctionFW(2, :),TauJunctionForced(2, :)]  = GetTauSitu(Elements, EtaJunction(2, :));
% [TauJunction(3, :),TauJunctionFW(3, :),TauJunctionForced(3, :)]  = GetTauSitu(Elements, EtaJunction(3, :));
% [TauJunction(4, :),TauJunctionFW(4, :),TauJunctionForced(4, :)]   = GetTauSitu(Elements, EtaJunction(4, :));
%%
% figure;
% semilogx(f,EtaTotalSitu); hold on;
% etaRoom = ((2 * Rho0 * c0 .* SigmaFeeWave) ./ (2 * pi * f * ElementMass));
% etaJunc = (c0 ./ ((pi.^2) * S .* sqrt(f.*fc))) .* Factor;
% semilogx(f, zeros(size(etaRoom))+EtaInitial);
% semilogx(f,etaRoom);
% semilogx(f,etaJunc);
% legend('EtaTotalSitu','etaInit','etaRoom','etaJunc')

%%
% figure('units', 'normalized', 'outerposition', [0, 0, 1, 1]);
% Plot_FreqFromFreq(-10*log10(TauInternalFW), false, f, '-o')
% % semilogx(f, 10*log10(TauInternal), '-o');
% hold on;
% semilogx(f, -10*log10(TauElementRoomFW), '-*');
% semilogx(f, -10*log10(TauJunctionFW), '--x');
% semilogx(f, -10*log10(sum(TauJunctionFW, 1)), '-x');
% semilogx(f, -10*log10(TauSituFW), '*r-');
% semilogx(f, -10*log10(TauSituForced), '*b-');
% semilogx(f, -10*log10(TauSituPlateau), '*g-');
% TauTot =(1./(sum(1./TauJunctionFW, 1) + 1 ./ TauElementRoomFW + 1 ./ TauInternalFW)) ...
%     +TauSituForced;
% %     + ((sum(TauJunctionForced, 1) + TauElementRoomForced + TauInternalForced));
% semilogx(f, -10*log10(TauSitu), '.-', 'LineWidth',2);
% semilogx(f, -10*log10(TauTot), '.--', 'LineWidth',2);
% xlim([20, 20000]);
% ylim([0, 100]);
% plot([Elements.fc, Elements.fc], ylim, 'Color', [0, 0, 0])
% legend({'internal losses FW', 'Element2Room FW', 'Junction1 FW', 'Junction2 FW', 'Junction3 FW', 'Junction4 FW', 'Junction all FW', 'Total ISO FW', 'Total ISO Forced','Total ISO Plateau',  'Total ISO total', 'Total reconstructedTau'}, 'Location', 'northwest')
% 
% title([Elements.ID, ' (', Elements.Name, ', f_c = ', num2str(round(Elements.fc, 2)), ' Hz)']);
% %

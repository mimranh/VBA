
%% Configuration for plots

% PlotID = 1 Plot all paths

% PlotID = 2 Plot Interpolated Spectra Secondary Sources Transmission Coefficent

% PlotID = 31 Plot Spectra with HRTF for SS 1 with Reverberation
% PlotID = 32 Plot Spectra with HRTF for SS 2 with Reverberation
% PlotID = 33 Plot Spectra with HRTF for SS 3 with Reverberation
% PlotID = 34 Plot Spectra with HRTF for SS 4 with Reverberation
% PlotID = 35 Plot Spectra with HRTF for SS 5 with Reverberation
% PlotID = 36 Plot Spectra with HRTF for all with Reverberation

% PlotID = 41 Plot Signal in Time with HRTF for SS 1
% PlotID = 42 Plot Signal in Time with HRTF for SS 2
% PlotID = 43 Plot Signal in Time with HRTF for SS 3
% PlotID = 44 Plot Signal in Time with HRTF for SS 4
% PlotID = 45 Plot Signal in Time with HRTF for SS 5
% PlotID = 46 Plot Signal in Time with HRTF for all

%clear; clc
startFreq = 0;
Geo23;
InterploatePathsV1;
PlotId = [31, 32, 33, 34, 35, 36];
subplotsize = [3, 2];

%% Plot Interpolated Spectra Secondary Sources
figure
for id = [1:size(PlotId, 2)]
    subplot(subplotsize(1), subplotsize(2), id)
    
    if PlotId(id) == 1
        ResultsPaths;
        set(gca, 'FontSize', 14)
        legend('FontSize', 12)
    elseif PlotId(id) == 2
        % Plot Interpolated Spectra Secondary Sources Transmission Coefficent
        semilogx(freqplot, 10*log10(SBBTplot), '-.', 'LineWidth', 1.5)
        grid on;
        hold on;
        shg
        semilogx(freqplot, 10*log10(SBBDplot), 'LineWidth', 1.5)
        semilogx(freqplot, 10*log10(SBB1plot), 'LineWidth', 1.5)
        semilogx(freqplot, 10*log10(SBB2plot), 'LineWidth', 1.5)
        semilogx(freqplot, 10*log10(SBB3plot), 'LineWidth', 1.5)
        semilogx(freqplot, 10*log10(SBB4plot), 'LineWidth', 1.5)
        xlabel('Frequency (Hz)');
        ylabel('Transmission Coefficent (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([0, 22000])
        set(gca, 'FontSize', 14)
        legend({'Total', 'SS1', 'SS2', 'SS3', 'SS4', 'SS5'}, 'Location', 'southwest', 'FontSize', 12)
        hold off
        
    elseif PlotId(id) == 5
        % Plot Interpolated Spectra Secondary Sources Transmission
        % Coefficent with freq cut and
        semilogx(SBBT.freqVector, 10*log10(real(SBBT.freqData)), '-.', 'LineWidth', 1.5)
        grid on;
        hold on;
        shg
        semilogx(SBBD.freqVector, 10*log10(real(SBBD.freqData)), 'LineWidth', 1.5)
        semilogx(SBB1.freqVector, 10*log10(real(SBB1.freqData)), 'LineWidth', 1.5)
        semilogx(SBB2.freqVector, 10*log10(real(SBB2.freqData)), 'LineWidth', 1.5)
        semilogx(SBB3.freqVector, 10*log10(real(SBB3.freqData)), 'LineWidth', 1.5)
        semilogx(SBB4.freqVector, 10*log10(real(SBB4.freqData)), 'LineWidth', 1.5)
        xlabel('Frequency (Hz)');
        ylabel('Transmission Coefficent (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([0, 22000])
        set(gca, 'FontSize', 14)
        legend({'Total', 'SS1', 'SS2', 'SS3', 'SS4', 'SS5'}, 'Location', 'southwest', 'FontSize', 12)
        hold off
        
    elseif PlotId(id) == 6
        % Plot Interpolated Spectra Secondary Sources Transmission
        % with Reverberation
        % Coefficent with freq cut and
        semilogx(SR1.freqVector, 10*log10(real(SR1.freqData)), '-.', 'LineWidth', 1.5)
        grid on;
        hold on;
        shg
        semilogx(SR2.freqVector, 10*log10(real(SR2.freqData)), 'LineWidth', 1.5)
        semilogx(SR3.freqVector, 10*log10(real(SR3.freqData)), 'LineWidth', 1.5)
        semilogx(SR4.freqVector, 10*log10(real(SR4.freqData)), 'LineWidth', 1.5)
        semilogx(SR5.freqVector, 10*log10(real(SR5.freqData)), 'LineWidth', 1.5)
        xlabel('Frequency (Hz)');
        ylabel('Transmission Coefficent (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([0, 22000])
        set(gca, 'FontSize', 14)
        legend({'Total', 'SS1', 'SS2', 'SS3', 'SS4', 'SS5'}, 'Location', 'southwest', 'FontSize', 12)
        hold off
        
    elseif PlotId(id) == 31
        semilogx(SRH1.freqVector, 10*log10(real(SRH1.freqData(:, 1))), 'b')
        hold on;
        grid on
        semilogx(SRH1.freqVector, 10*log10(real(SRH1.freqData(:, 2))), 'r')
        shg
        xlabel('Frequency (Hz)');
        ylabel('Magnitude (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([0, 22000])
        ylim([-120, -20])
        set(gca, 'FontSize', 14)
        legend({'SS1 left with Reverberation', 'SS1 right with Reverberation'}, 'Location', 'southwest', 'FontSize', 12)
        hold off
        
    elseif PlotId(id) == 32
        semilogx(SRH2.freqVector, 10*log10(real(SRH2.freqData(:, 1))), 'b')
        hold on;
        grid on
        semilogx(SRH2.freqVector, 10*log10(real(SRH2.freqData(:, 2))), 'r')
        shg
        xlabel('Frequency (Hz)');
        ylabel('Magnitude (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([0, 22000])
        ylim([-120, -20])
        set(gca, 'FontSize', 14)
        legend({'SS2 left with Reverberation', 'SS2 right with Reverberation'}, 'Location', 'southwest', 'FontSize', 12)
        hold off
        
    elseif PlotId(id) == 33
        semilogx(SRH3.freqVector, 10*log10(real(SRH3.freqData(:, 1))), 'b')
        hold on;
        grid on
        semilogx(SRH3.freqVector, 10*log10(real(SRH3.freqData(:, 2))), 'r')
        shg
        xlabel('Frequency (Hz)');
        ylabel('Magnitude (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([0, 22000])
        ylim([-120, -20])
        set(gca, 'FontSize', 14)
        legend({'SS3 left with Reverberation', 'SS3 right with Reverberation'}, 'Location', 'southwest', 'FontSize', 12)
        hold off
        
    elseif PlotId(id) == 34
        semilogx(SRH4.freqVector, 10*log10(real(SRH4.freqData(:, 1))), 'b')
        hold on;
        grid on
        semilogx(SRH4.freqVector, 10*log10(real(SRH4.freqData(:, 2))), 'r')
        shg
        xlabel('Frequency (Hz)');
        ylabel('Magnitude (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([0, 22000])
        ylim([-120, -20])
        set(gca, 'FontSize', 14)
        legend({'SS4 left with Reverberation', 'SS4 right with Reverberation'}, 'Location', 'southwest', 'FontSize', 12)
        hold off
        
    elseif PlotId(id) == 35
        semilogx(SRH5.freqVector, 10*log10(real(SRH5.freqData(:, 1))), 'b')
        hold on;
        grid on
        semilogx(SRH5.freqVector, 10*log10(real(SRH5.freqData(:, 2))), 'r')
        shg
        xlabel('Frequency (Hz)');
        ylabel('Magnitude (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([0, 22000])
        ylim([-120, -20])
        set(gca, 'FontSize', 14)
        legend({'SS5 left with Reverberation', 'SS5 right with Reverberation'}, 'Location', 'southwest', 'FontSize', 12)
        hold off
        
    elseif PlotId(id) == 36
        semilogx(SRH_T.freqVector, 10*log10(real(SRH_T.freqData(:, 1))), '--b')
        hold on;
        grid on
        semilogx(SRH_T.freqVector, 10*log10(real(SRH_T.freqData(:, 2))), '--r')
        shg
        xlabel('Frequency (Hz)');
        ylabel('Magnitude (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([0, 22000])
        ylim([-120, -20])
        set(gca, 'FontSize', 14)
        legend({'Total left with Reverberation', 'Total right with Reverberation'}, 'Location', 'southwest', 'FontSize', 12)
        hold off
        
    elseif PlotId(id) == 41
        figure
        plot(real(R_timeR1))
        hold on;
        grid on
        plot(real(R_timeR2))
        plot(real(R_timeR3))
        plot(real(R_timeR4))
        plot(real(R_timeR5))
        plot(real(R_timeL1))
        plot(real(R_timeL2))
        plot(real(R_timeL3))
        plot(real(R_timeL4))
        plot(real(R_timeL5))
        shg
        figure
        plot(real(R_Total_R))
        hold on;
        grid on
        plot(real(R_Total_L))
        shg
    end
    
end

%%
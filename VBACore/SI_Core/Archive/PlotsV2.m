
%% Configuration for plots
% + Freqency Domain
% - Time Domain
%
% PlotID = 2 Plot Interpolated Spectra Secondary Sources Transmission Coefficent
%
% PlotID = 4   Freq All Plot with Reverberation
% PlotID = -4  Time All Plot with Reverberation
%
% PlotID = 7   Freq HRTF + SI Total
%
% PlotID = 8   Freq + Audio
% PlotID = -8  Time  + Audio

SaveasFolder = 'D:\sciebo\hiwi\Sound Insulation\Conference Papers\Euro Noise 2018\GeneratedFigures\';

%clear; clc
startFreq = 0;
Geo34;
%InterploatePathsV1;
PlotId = [8];
subplotsize = [1, 1];
figureFontSize = 14;
legendFontSize = 12;

%% Plot Interpolated Spectra Secondary Sources

for id = [1:size(PlotId, 2)]
    %subplot(subplotsize(1),subplotsize(2),id)
    
    figure
    if PlotId(id) == 2
        
        %% Plot Interpolated Spectra Secondary Sources Transmission Coefficent
        semilogx(freqplot, 10*log10(real(SBBTplot)), '-.', 'LineWidth', 1.5)
        grid on;
        hold on;
        shg
        semilogx(freqplot, 10*log10(real(SBBDplot)), 'LineWidth', 1.5)
        semilogx(freqplot, 10*log10(real(SBB1plot)), 'LineWidth', 1.5)
        semilogx(freqplot, 10*log10(real(SBB2plot)), 'LineWidth', 1.5)
        semilogx(freqplot, 10*log10(real(SBB3plot)), 'LineWidth', 1.5)
        semilogx(freqplot, 10*log10(real(SBB4plot)), 'LineWidth', 1.5)
        xlabel('Frequency (Hz)');
        ylabel('Transmission Coefficent (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([20, 10000])
        set(gca, 'FontSize', figureFontSize)
        legend({'Total', 'SS1', 'SS2', 'SS3', 'SS4', 'SS5'}, 'Location', 'southwest', 'FontSize', legendFontSize)
        FigureName = 'Freq_SI';
        hold off
        
        
    elseif PlotId(id) == 4
        
        %% Freq Plot Interpolated Spectra Secondary Sources Transmission Coefficent with Reverberation
        semilogx(Total.Freq, 10*log10(real(Total.FreqL)), 'LineWidth', 1)
        grid on;
        hold on;
        shg
        semilogx(Total.Freq, 10*log10(real(Total.FreqR)), 'LineWidth', 1)
        xlabel('Frequency (Hz)');
        ylabel('Transmission Coefficent (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([50, 20000])
        set(gca, 'FontSize', figureFontSize)
        legend({'Left', 'Right'}, 'Location', 'southwest', 'FontSize', legendFontSize)
        FigureName = 'Freq_SI_Rev_HRTF';
        hold off
        
    elseif PlotId(id) == -4
        
        %% Time Plot Interpolated Spectra Secondary Sources Transmission Coefficent with Reverberation
        plot(Total.Time, Total.L, 'LineWidth', 1)
        grid on;
        hold on;
        shg
        plot(Total.Time, Total.R, 'LineWidth', 1)
        xlabel('Time (s)');
        ylabel('Amplitude (dB)');
        set(gca, 'FontSize', figureFontSize)
        yl = max(abs(ylim))
        ylim([-yl, yl])
        legend({'Left', 'Right'}, 'Location', 'southeast', 'FontSize', legendFontSize)
        FigureName = 'Time_SI_Rev_HRTF';
        hold off
        
        
    elseif PlotId(id) == 8
        
        %% Freq Plot Interpolated Spectra Secondary Sources Transmission Coefficent with Reverberation
        semilogx(AudioOrgFreq, 10*log10(real(AudioOrgFreqData)), 'g', 'LineWidth', 1)
        grid on;
        hold on;
        shg
        semilogx(AudioFreq, 10*log10(real(AudioFreqL)), 'b', 'LineWidth', 1)
        semilogx(AudioFreq, 10*log10(real(AudioFreqR)), 'r', 'LineWidth', 1)
        xlabel('Frequency (Hz)');
        ylabel('Transmission Coefficent (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([50, 10000])
        set(gca, 'FontSize', figureFontSize)
        legend({'Orginal', 'Left', 'Right'}, 'Location', 'southwest', 'FontSize', legendFontSize)
        FigureName = 'Freq_SI_Rev_HRTF_Audio';
        hold off
        
    elseif PlotId(id) == -8
        
        %% Time Plot Interpolated Spectra Secondary Sources Transmission Coefficent with Reverberation
        plot(AudioOrgTime, AudioOrg, 'g', 'LineWidth', 1)
        grid on;
        hold on;
        shg
        plot(AudioTime, AudioTimeL, 'b', 'LineWidth', 1)
        plot(AudioTime, AudioTimeR, 'r', 'LineWidth', 1)
        xlabel('Time (s)');
        ylabel('Amplitude (dB)');
        set(gca, 'FontSize', figureFontSize)
        yl = max(abs(ylim))
        ylim([-yl, yl])
        xlim([0, 4])
        legend({'Orginal', 'Left', 'Right'}, 'Location', 'southeast', 'FontSize', legendFontSize)
        FigureName = 'Time_SI_Rev_HRTF_Audio';
        hold off
        
        
    elseif PlotId(id) == 7
        
        %% Freq Plot Interpolated Spectra Secondary Sources Transmission Coefficent without Reverberation
        semilogx(SH.Freq, 10*log10(real(SH.FreqL)), 'LineWidth', 1)
        grid on;
        hold on;
        shg
        semilogx(SH.Freq, 10*log10(real(SH.FreqR)), 'LineWidth', 1)
        xlabel('Frequency (Hz)');
        ylabel('Transmission Coefficent (dB)');
        xticks([0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
        xticklabels({'.1', '.2', '.5', '1', '2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
        xlim([0, 22000])
        set(gca, 'FontSize', figureFontSize)
        legend({'Left', 'Right'}, 'Location', 'southwest', 'FontSize', legendFontSize)
        FigureName = 'Freq_SI_HRTF';
        hold off
    end
    
    if SaveasFolder ~= 0
        saveas(gcf, [SaveasFolder, Geo, '_', FigureName, '.png']);
    end
    
end

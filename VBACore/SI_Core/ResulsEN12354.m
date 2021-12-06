function ResulsEN12354(Elements, SaveasFolder)

constants
ElementID = Elements.ID;

%% Polts

figure('units', 'normalized', 'outerposition', [0, 0, 1, 1]);

subplot(2, 2, 1)
semilogx(f, Elements.RSitu, '-o')
grid on
xlabel('Frequency (Hz)')
xlim([30, 10000])
xticks([f([2:3:end])])
ylabel('Sound Reduction Index (dB)')
title(['Sound Reduction Index of ', ElementID])
legend('Calculated', 'Location', 'southeast');


subplot(2, 2, 2)
semilogx(f, Elements.EtaSitu, '-o')
grid on
xlabel('Frequency (Hz)')
xlim([30, 10000])
xticks([f([2:3:end])])
ylabel('Total Loss Factor')
title(['Total Loss Factor of ', ElementID])
legend('Calculated', 'Location', 'southeast');

subplot(2, 2, 3)
semilogx(f, Elements.SigmaFW, '-o')
grid on
xlabel('Frequency (Hz)')
xlim([30, 10000])
xticks([f([2:3:end])])
ylabel('Radiation Factor')
title(['Radiation Factor (Free Bending Wave) of ', ElementID])
legend('Calculated', 'Location', 'southeast');

subplot(2, 2, 4)
semilogx(f, Elements.SigmaForced, '-o')
grid on
xlabel('Frequency (Hz)')
xlim([30, 10000])
xticks([f([2:3:end])])
ylabel('Radiation Factor')
title(['Radiation Factor (Forced Wave) of ', ElementID])
legend('Calculated', 'Location', 'southeast');
shg

if SaveasFolder ~= 0
    saveas(gcf, [SaveasFolder, 'ResultsDetailed-', ElementID, '-', '.png'])
end

%%
%

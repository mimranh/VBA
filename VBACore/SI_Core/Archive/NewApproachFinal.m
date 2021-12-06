
%% Configuration
clearvars -except Receiver; clc;

plotTime = true;
plotFreq = false;
ReverberationBinaural = false;
PlaySound = 1;
% viewDirection = 'Direct';   % looking to direct wall      (az 27 degree)
viewDirection = 'Left'; % looking to window           (az -65 degree)
% viewDirection = 'Right';    % looking to door (korridor)  (az 132 degree)

%%
logPath = '.\..\UnityData\';
if (~exist('Receiver'))
    Receiver = readReceiver(logPath, 'Receiver3DirectionsFRL');
end
% Read Data Unity
tauFreqInterpOrg = Receiver.Unity.TauInterpolatedSecondarySources;
if strcmp(viewDirection, 'Direct')
    HrirLeft = Receiver.Unity.hrir.pos1(:, 1:2:end);
    HrirRight = Receiver.Unity.hrir.pos1(:, 2:2:end);
elseif strcmp(viewDirection, 'Left')
    HrirLeft = Receiver.Unity.hrir.pos2(:, 1:2:end);
    HrirRight = Receiver.Unity.hrir.pos2(:, 2:2:end);
elseif strcmp(viewDirection, 'Right')
    HrirLeft = Receiver.Unity.hrir.pos3(:, 1:2:end);
    HrirRight = Receiver.Unity.hrir.pos3(:, 2:2:end);
end
distanceWalls2Receiver = Receiver.Unity.Distance';

%%
SD = 4.3 * 2.5;
T = 1;
V = SD * 3;
fs = 44100;
c = 343;

%% Calulate Reverberation Tail
samplesRir = floor(1.5*T*44100);
whiteNoise = wgn(samplesRir, 1, 1, 'real');
factor = -6.9078;
ShapeFunctionExp = exp((factor / (44100 * T))*(1:samplesRir))';
ShapeWhiteNoise = whiteNoise .* ShapeFunctionExp;
rev = ShapeWhiteNoise ./ sqrt(sum(ShapeWhiteNoise.^2));

%% Create Linear Phase
N = (2 * length(tauFreqInterpOrg) - 1); % with mirroing
M = (N - 1) / 2;
k = [0:N - 1]';
tauPhase = exp(-1j*M*2*pi*k/fs); % - Unity checked

%%
% Mirror Freq Signal
tauFreqMirrored = [tauFreqInterpOrg; flipud(tauFreqInterpOrg(1:end-1, :))]; % with mirroing
Signal1Freq = (tauFreqMirrored(:, 1)) .* tauPhase; % Working

%% add Overlap direct and Reverberation
distanceWalls2Receiver = Receiver.Unity.Distance';
az = Receiver.Unity.azimuth.pos1;
el = Receiver.Unity.elevation.pos1;
for i = 1:5
    r = distanceWalls2Receiver(:, i);
    tau = Receiver.Unity.tauTime.pos0(:, i);
    hrir(:, 1) = HrirLeft(:, i);
    hrir(:, 2) = HrirRight(:, i);
    
    % Cut tau
    tau = tau(0.2*44100:end, :);
    
    % Convolve direct Part
    tauhrir(:, 1) = conv(tau, hrir(:, 1));
    tauhrir(:, 2) = conv(tau, hrir(:, 2));
    
    revTau = conv(tau, rev);
    revTauHrir(:, 1) = conv(revTau, hrir(:, 1));
    revTauHrir(:, 2) = conv(revTau, hrir(:, 2));
    
    % readjust energies
    A = 0.163 * V / T;
    r1 = 16 * pi * r * r;
    EdiffByEdir = (r1 / A);
    if ReverberationBinaural
        EtauByrev = min(sum(tau.^2)/sum(revTau.^2)); % rev with hrir
        revTau = sqrt(EtauByrev) .* revTauHrir; % rev with hrir
    else
        EtauByrev = min(sum(tauhrir.^2)/sum(revTau.^2)); % rev without hrir
        revTau = sqrt(EtauByrev) .* [revTau, revTau]; % rev without hrir
    end
    tauhrir = tauhrir * sqrt(1/EdiffByEdir);
    
    % Add direct and Reverberation
    directLength = floor(40*44.1);
    
    irPathsLeft(:, i) = [tauhrir(1:directLength, 1); ...
        tauhrir(directLength+1:end, 1) + revTau(1:length(tauhrir(directLength+1:end, 1)), 1); ...
        revTau(length(tauhrir(directLength+1:end, 1))+1:end, 1)];
    irPathsRight(:, i) = [tauhrir(1:directLength, 2); ...
        tauhrir(directLength+1:end, 2) + revTau(1:length(tauhrir(directLength+1:end, 2)), 2); ...
        revTau(length(tauhrir(directLength+1:end, 2))+1:end, 2)];
end

ir(:, 1) = sum(irPathsLeft, 2);
ir(:, 2) = sum(irPathsRight, 2);

%%
if (PlaySound)
    clear AudioSi;
    % Audio = audioread('DirectSoundAnechoic.wav');
    Audio = audioread('mono_guitar.wav');
    % Audio = rand(44100*5,1);
    sig = ir;
    AudioSi(:, 1) = conv(Audio(:, 1), sig(:, 1));
    AudioSi(:, 2) = conv(Audio(:, 1), sig(:, 2));
    maxFo = max(max(abs(AudioSi)));
    AudioSiNorm = AudioSi / maxFo;
    % soundsc(AudioSi, 44100);
end

%% PlotTime Impuse Response
if (plotTime)
    figure;
    t = [1:length(ir)] / 44.1;
    plot(t, ir);
    hold on;
    maximum = max(max(abs(ir)));
    ylim([-maximum, maximum])
    % plot([tau(1:directLength,:); ...
    %     tau(directLength+1:end,:) + revTau(1:length(tau(directLength+1:end,:)),:)]);
    % plot(tau(1:directLength,:));
end

%% PlotTime One chanel
if (plotTime)
    figure;
    t = [1:length(tau)] / 44.1;
    plot(t, tau);
    hold on;
    t = [1:length(tauhrir)] / 44.1;
    plot(t, tauhrir);
    hold on;
    grid on;
    legend({'tau', 'tau + Hrir Left', 'tau + Hrir Right'})
end

%%
if plotFreq
    signal = (ir);
    figure;
    freqData = fft(signal);
    freqData = freqData(1:end/2, :);
    f = [0:length(freqData) - 1] * 22050 / length(freqData);
    semilogx(f, 10*log10(abs(freqData)), 'LineWidth', 1)
    hold on;
    xticks([2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
    xticklabels({'2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
    xlim([10, 22050])
    grid on;
    
    freqData = tauFreqInterpOrg(:, 1);
    f = [0:length(freqData) - 1] * 22050 / length(freqData);
    semilogx(f, 10*log10(abs(freqData)), 'LineWidth', 1)
    hold on;
    
    hrir(:, 1) = HrirLeft(:, 1);
    hrir(:, 2) = HrirRight(:, 1);
    freqData = fft(hrir, length(tauFreqInterpOrg));
    freqData = freqData(1:end/2, :);
    f = [0:length(freqData) - 1] * 22050 / length(freqData);
    semilogx(f, 10*log10(abs(freqData)), 'LineWidth', 1)
end
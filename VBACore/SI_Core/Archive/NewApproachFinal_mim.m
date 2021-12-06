
%% Configuration
clear;
clc;
close all

MyPC = getenv('computername');
if strcmp(MyPC, 'VR-OCULUS')
    logPath = 'M:\_sciebo\ITA Dream Team\Coding\_Unity\BuildingAcousticUnity\BuildingAcousticUnityVS\Log\';
elseif strcmp(MyPC, 'PC-MIM')
    logPath = 'H:\Sciebo\ITA Dream Team\Coding\_Unity\BuildingAcousticUnity\DemoInterNoise\Log\';
elseif strcmp(MyPC, 'MIM')
    logPath = 'E:\Sciebo\ITA Dream Team\Coding\_Unity\BuildingAcousticUnity\BuildingAcousticUnityVS\Log\';
    % elseif strcmp(MyPC,'VR-OCULUS')
    %     logPath = 'E:\Sciebo\ITA Dream Team\Coding\_Unity\BuildingAcousticUnity\DemoInterNoise\Log\';
end
PlaySound = 1;
Receiver = readReceiver(logPath, 'Receiver');

%% Read Data Unity
tau.FreqOrg(:, 1) = Receiver.Unity.tauInterpolatedSecondarySources.id0'; % W15   Partition
tau.FreqOrg(:, 2) = Receiver.Unity.tauInterpolatedSecondarySources.id1'; % F4    Ceiling
tau.FreqOrg(:, 3) = Receiver.Unity.tauInterpolatedSecondarySources.id2'; % F101  Floor
tau.FreqOrg(:, 4) = Receiver.Unity.tauInterpolatedSecondarySources.id3'; % W28   Right Wall
tau.FreqOrg(:, 5) = Receiver.Unity.tauInterpolatedSecondarySources.id4'; % W19   Left Wall

for i = 1:5
    tau.FreqOrg(:, i) = tau.FreqOrg(:, i) - min(tau.FreqOrg(:, i)) + 1e-10; % Interpolation Issue during dB per Oct Decay
end

HrirLeft(:, 1) = Receiver.Unity.hrir.pos1.id1;
HrirLeft(:, 2) = Receiver.Unity.hrir.pos1.id3;
HrirLeft(:, 3) = Receiver.Unity.hrir.pos1.id5;
HrirLeft(:, 4) = Receiver.Unity.hrir.pos1.id7;
HrirLeft(:, 5) = Receiver.Unity.hrir.pos1.id9;
HrirRight(:, 1) = Receiver.Unity.hrir.pos1.id2;
HrirRight(:, 2) = Receiver.Unity.hrir.pos1.id4;
HrirRight(:, 3) = Receiver.Unity.hrir.pos1.id6;
HrirRight(:, 4) = Receiver.Unity.hrir.pos1.id8;
HrirRight(:, 5) = Receiver.Unity.hrir.pos1.id10;
distanceWalls2Receiver = Receiver.Unity.Distance';

%%
N = 8193;
directImpuls = audioread('DirectSoundAnechoic.wav');
directImpuls = [directImpuls; zeros(N-length(directImpuls), 1)];

SD = 4.3 * 2.5;
T = 1.5;
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
N = (2 * length(tau.FreqOrg) - 1); % with mirroing
L = 44100;
M = (N - 1) / 2;
k = [0:N - 1]';
tauPhase = exp(-1j*M*2*pi*k/L); % - Unity checked

%%
clear Signal1 result1 Signal2 tauHrir;
for i = 1:1
    % Mirror Freq Signal
    tauFreqMirrored(:, i) = [tau.FreqOrg(:, i); flipud(tau.FreqOrg(1:end-1, i))]; % with mirroing
    
    r = distanceWalls2Receiver(:, i) / 2;
    A = 0.163 * V / T;
    r1 = 16 * pi * r * r;
    factor1 = (sqrt((SD .* T)./(0.32 .* V .* 0.5 .* (r1 + A))));
    %     Signal1Freq(:,i) = ((abs(tauFreqMirrored(:,i)))); % Working
    Signal1Freq(:, i) = ((abs(tauFreqMirrored(:, i)))) .* tauPhase; % Working
    %         Signal1Freq(:,i) = sqrt(tauFreqMirrored(:,i)) .* tauPhase .* (fft(directImpuls./max(abs(directImpuls)))); % Working
    %         Signal1Freq(:,i) = (((tauFreqMirrored(:,i)))) .* (fft(directImpuls./max(abs(directImpuls)))); % Working
    %         Signal1Freq(:,i) = (sqrt(abs(tauFreqMirrored(:,i)))) .* exp(j*phase(fft(directImpuls./max(abs(directImpuls))))); % Working
    temp = (ifft(Signal1Freq(:, i)));
    Signal1(:, i) = factor1 .* real(temp(1:end/2));
    
    hrir(:, 1) = HrirLeft(:, 5);
    hrir(:, 2) = HrirRight(:, 5);
    
    tauHrir(:, 1) = conv(Signal1, hrir(:, 1));
    tauHrir(:, 2) = conv(Signal1, hrir(:, 2));
    %     energyHrir = max(sum(hrir.^2));
    %     hrir = hrir / sqrt(energyHrir);
    
    Signal2(:, 1) = [sqrt(A) * hrir(:, 1); sqrt(r1) * rev];
    Signal2(:, 2) = [sqrt(A) * hrir(:, 2); sqrt(r1) * rev];
    
    result1(:, 1) = conv(Signal1(:, i), Signal2(:, 1));
    result1(:, 2) = conv(Signal1(:, i), Signal2(:, 2));
    
    Prij{1, i} = result1;
end

%%
clear AudioSi;
% Audio = audioread('DirectSoundAnechoic.wav');
Audio = audioread('mono_guitar.wav');
% Audio = rand(44100*5,1);
sig = result1;
AudioSi(:, 1) = conv(Audio(:, 1), sig(:, 1));
AudioSi(:, 2) = conv(Audio(:, 1), sig(:, 2));
maxFo = max(max(abs(AudioSi)));
AudioSiNorm = AudioSi / maxFo;
soundsc(AudioSi, 44100);

%% plot
plot(Signal1);
grid on;

%%
plot(result1);
grid on;

%%
% signal = result1(:,1);
signal = (Signal1);
for i = 1:1
    freqData = fft(signal);
    freqData = freqData(1:end/2, :);
    f = [0:length(freqData) - 1] * 22050 / length(freqData);
    semilogx(f, 10*log10(abs(freqData)), 'LineWidth', 1)
    hold on;
    xticks([2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000]);
    xticklabels({'2', '5', '10', '20', '50', '100', '200', '500', '1k', '2k', '5k', '10k', '20k'});
    xlim([0, 22000])
    grid on;
end

f = [0:length(tau.FreqOrg(:, 1)) - 1] * 22050 / length(tau.FreqOrg(:, 1));
semilogx(f, 10*log10(abs(tau.FreqOrg(:, 1))), 'LineWidth', 1)

%%

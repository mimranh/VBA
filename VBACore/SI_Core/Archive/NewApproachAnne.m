
%% Configuration
clear;
clc;
close all

MyPC = getenv('computername');
if strcmp(MyPC, 'VR-OCULUS')
    logPath = 'M:\_sciebo\ITA Dream Team\Coding\_Unity\BuildingAcousticUnity\BuildingAcousticUnityVS\Log\';
elseif strcmp(MyPC, 'PC-MIM')
    logPath = 'H:\Sciebo\ITA Dream Team\Coding\_Unity\BuildingAcousticUnity\BuildingAcousticUnityVS\Log\';
elseif strcmp(MyPC, 'MIM')
    logPath = 'E:\Sciebo\ITA Dream Team\Coding\_Unity\BuildingAcousticUnity\BuildingAcousticUnityVS\Log\';
    % elseif strcmp(MyPC,'VR-OCULUS')
    %     logPath = 'E:\Sciebo\ITA Dream Team\Coding\_Unity\BuildingAcousticUnity\DemoInterNoise\Log\';
end
PlaySound = 1;
Receiver = readReceiver(logPath, 'Receiver');

%%
HrirLeft = Receiver.Unity.hrir{1, 2}(:, 1:2:end);
HrirRight = Receiver.Unity.hrir{1, 2}(:, 2:2:end);
tauFreqInterpOrg = Receiver.Unity.TauInterpolatedSecondarySources;
figure;
plot(Receiver.Unity.directBianuralTime{1, 2});
hold on;

%%
irMono = Receiver.Unity.irTime.pos1;
irBi = Receiver.Unity.irTime.pos2;
irDir = irMono(1:13390, :);

Audio = audioread('mono_guitar.wav');
% Audio = rand(44100*5,1);

AudioSiDir(:, 1) = conv(Audio(:, 1), irDir(:, 1));
AudioSiDir(:, 2) = conv(Audio(:, 1), irDir(:, 2));
AudioSiMono(:, 1) = conv(Audio(:, 1), irMono(:, 1));
AudioSiMono(:, 2) = conv(Audio(:, 1), irMono(:, 2));
AudioSiBi(:, 1) = conv(Audio(:, 1), irBi(:, 1));
AudioSiBi(:, 2) = conv(Audio(:, 1), irBi(:, 2));

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
rev = audioread('reverb.wav');
directImpuls = audioread('DirectSoundAnechoic.wav');

SD = 4.3 * 2.5;
T = 0.5;
V = SD * 3;
fs = 44100;
c = 343;

%% Create Linear Phase
N = (2 * length(tau.FreqOrg) - 1); % with mirroing
directImpuls = [directImpuls; zeros(N-length(directImpuls), 1)];
L = 44100;
M = (N - 1) / 2;
k = [0:N - 1]';
tauPhase = exp(-1j*M*2*pi*k/L); % - Unity checked
clear result tauTime result2 result1 ResultPart1 resultBinaural ResultPart2Binaural reverb direct resultTestBinaural resultTest;
f = [0:N - 1]' * 22050 / (N - 1);

for i = 1:5
    % Mirror Freq Signal
    tauFreqMirrored(:, i) = [tau.FreqOrg(:, i); flipud(tau.FreqOrg(1:end-1, i))]; % with mirroing
    tauFreqMirrored(:, i) = tauFreqMirrored(:, i) .* tauPhase;
    r = distanceWalls2Receiver(:, i) / 2;
    A = 0.163 * V / T;
    r1 = 16 * pi * r * r;
    factor1 = (sqrt((SD .* T)./(0.32 .* V .* 0.5 .* (r1 + A))));
    %     Signal1(:,i) = (factor1 .* sqrt(abs(tauFreqMirrored(:,i)))).* tauPhase .* fft(directImpuls./max(abs(directImpuls))); % Working
    Signal1(:, i) = sqrt(abs((tauFreqMirrored(:, i)))) .* tauPhase .* fft([1; zeros(N-1, 1)]); % Working
    %     Signal1(:,i) = factor1 .* sqrt((tauFreqMirrored(:,i))) .* fft([1; zeros(N-1,1)]);
    %     Signal1(:,i) = factor1 .* sqrt(abs(tauFreqMirrored(:,i))) .* fft(directImpuls./max(abs(directImpuls)));
    tempTau = real(ifft(Signal1(:, i)));
    tauTime(:, i) = tempTau(1:1500, 1);
    %
    zeroSamples = floor(fs*max(distanceWalls2Receiver)./c);
    rev = rev ./ sqrt(sum(rev.^2));
    
    %     Signal2(:,1) = [ sqrt(A) * HrirLeft(:,1)];
    %     Signal2(:,2) = [ sqrt(A) * HrirRight(:,1)];
    hrir(:, 1) = HrirLeft(:, i);
    hrir(:, 2) = HrirRight(:, i);
    %     energyHrir = max(sum(hrir.^2));
    energyHrir = 1;
    hrir = hrir / sqrt(energyHrir);
    Etau = sum(tauTime(:, i).^2);
    ResultPart1(:, 1) = conv(tauTime(:, i), sqrt(A)*hrir(:, 1), 'valid');
    ResultPart1(:, 2) = conv(tauTime(:, i), sqrt(A)*hrir(:, 2), 'valid');
    ResultPart1 = sqrt(Etau) .* sqrt(A) .* ResultPart1 ./ sqrt((sum(ResultPart1.^2)));
    
    
    ResultPart2 = conv(sqrt(r1)*rev, tauTime(:, i));
    ResultPart2Binaural(:, 1) = conv(ResultPart2, hrir(:, 1), 'valid');
    ResultPart2Binaural(:, 2) = conv(ResultPart2, hrir(:, 2), 'valid');
    ResultPart2 = sqrt(Etau) .* sqrt(r1) .* ResultPart2 ./ sqrt((sum(ResultPart2.^2)));
    ResultPart2Binaural = sqrt(Etau) .* sqrt(r1) .* ResultPart2Binaural ./ sqrt(max((sum(ResultPart2Binaural.^2))));
    %     ResultPart2 = conv(  sqrt(r1) * rev , tauTime(:,i), 'valid');
    %     cutRev = floor(length(tauTime)/2);
    %     ResultPart2 = ResultPart2a(cutRev:cutRev);
    
    result(:, 1) = factor1 .* [ResultPart1(:, 1); ResultPart2];
    result(:, 2) = factor1 .* [ResultPart1(:, 2); ResultPart2];
    resultBinaural = factor1 .* [ResultPart1(500-zeroSamples:1000, :); ResultPart2Binaural(500:end, :)];
    
    reverb = sqrt(Etau) .* sqrt(r1) .* rev ./ sqrt(max((sum(rev.^2))));
    direct = sqrt(Etau) .* sqrt(r1) .* [zeros(0, 1); 1; zeros(300, 1)];
    
    resultTest = conv([direct; reverb], tauTime(:, i));
    
    resultTestBinaural(:, 1) = conv(resultTest, hrir(:, 1), 'valid');
    resultTestBinaural(:, 2) = conv(resultTest, hrir(:, 2), 'valid');
    %     irPart1(:,1) = conv(tauTime(:,i), sqrt(A) * HrirLeft(:,i), 'valid');
    %     irPart1(:,2) = conv(tauTime(:,i), sqrt(A) * HrirRight(:,i), 'valid');
    %     overlapSamples = length(irPart1)-800;
    %
    %     irPart2(:,1) = conv(tauTime(:,i), sqrt(r1) * rev);
    %     irPart2(:,2) = conv(tauTime(:,i), sqrt(r1) * rev);
    % %     result = [irPart1(1:end-overlapSamples,:);irPart1(end-overlapSamples+1:end,:)+irPart2(1:overlapSamples,:); irPart2(overlapSamples+1:end,:)];
    %     result = [irPart1(1:end-overlapSamples,:); irPart2(:,:)];
    
    Prij{1, i} = resultTestBinaural;
    
    %     result(:,1) = conv(tauTime(1:end/2), Signal2(:,1));
    %     result(:,2) = conv(tauTime(1:end/2), Signal2(:,2));
    %     Prij{1,i} = result;
end

%%
resulttotal = zeros(length(Prij{1, 1}), 2);
for i = 1:5
    resulttotal = resulttotal + Prij{1, i};
end

%% Plot
for i = 1:1
    figure;
    t = [0:length(Prij{1, i}) - 1] / 44.1;
    sig = Prij{1, i};
    plot(sig(:, :));
    hold on;
    %     plot([zeros(length(tauTime),2); Prij2{1,1}]);
end

%%

plot(result);
hold on;
plot(result(:, 1)-result(:, 2));

%%
if PlaySound == 1
    clear AudioSi;
    %     Audio = audioread('DirectSoundAnechoic.wav');
    Audio = audioread('Football_orginal.wav');
    %         [Audio,ffs] = audioread('mono_guitar.wav');
    %     Audio = rand(44100*5,1);
    sig = resultBinaural;
    AudioSi(:, 1) = conv(Audio(:, 1), sig(:, 1));
    AudioSi(:, 2) = conv(Audio(:, 1), sig(:, 2));
    maxFo = max(max(abs(AudioSi)));
    AudioSiNorm = AudioSi / maxFo;
    sound(AudioSiNorm, 44100);
end

%%
figure;
t = [0:length(Signal1) - 1] / 44.1;
plot(t, real(ifft(Signal1)));

%%
%     figure;
%     plot(conv(tauTime(:,1), HrirLeft(:,1), 'full')); hold on;
%     plot(conv(tauTime(:,1), HrirLeft(:,1), 'same'));
%     plot(conv(tauTime(:,1), HrirLeft(:,1), 'valid'));

%%
% for i = 1:5
%     freq = fft(Signal1);
%     freq = freq(1:end/2,:);
%     f = [0:length(freq)-1]' * 22050 / (length(freq)-1);
%
%     figure;
%     semilogx(f, 10*log10(abs(freq)), 'LineWidth',1)
%
% end
%

%%

signal = resultTestBinaural;
% signal = result;
for i = 1:1
    freqData = fft(signal);
    freqData = freqData(1:end/2, :);
    f = [0:length(freqData) - 1] * 22050 / length(freqData);
    semilogx(f, 10*log10(abs(freqData)), 'y', 'LineWidth', 1)
    hold on;
end

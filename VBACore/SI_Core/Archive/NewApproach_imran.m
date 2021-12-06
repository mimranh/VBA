
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
rev = audioread('reverb.wav');
directImpuls = audioread('DirectSoundAnechoic.wav');

SD = 4.3 * 2.5;
T = .5;
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
clear result;
f = [0:N - 1]' * 22050 / (N - 1);

for i = 1:5
    % Mirror Freq Signal
    tauFreqMirrored(:, i) = [tau.FreqOrg(:, i); flipud(tau.FreqOrg(1:end-1, i))]; % with mirroing
    tauFreqMirrored(:, i) = tauFreqMirrored(:, i) .* tauPhase;
    tauTime(:, i) = real(ifft(tauFreqMirrored(:, i)));
    r = distanceWalls2Receiver(:, i);
    A = 0.163 * V / T;
    r1 = 16 * pi * r * r;
    factor1 = (sqrt((SD .* T)./(0.32 .* V .* 0.5 .* (r1 + A))));
    %     Signal1(:,i) = (factor1 .* sqrt(abs(tauFreqMirrored(:,i)))).* tauPhase .* fft(directImpuls./max(abs(directImpuls))); % Working
    Signal1(:, i) = factor1 .* sqrt(abs((tauFreqMirrored(:, i)))) .* tauPhase .* fft([1; zeros(N-1, 1)]); % Working
    %     Signal1(:,i) = factor1 .* sqrt(abs(tauFreqMirrored(:,i))) .* fft([1; zeros(N-1,1)]);
    %     Signal1(:,i) = factor1 .* sqrt(abs(tauFreqMirrored(:,i))) .* fft(directImpuls./max(abs(directImpuls)));
    tauTime(:, i) = real(ifft(Signal1(:, i)));
    %
    zeroSamples = floor(fs*max(distanceWalls2Receiver)./c);
    rev = rev ./ sqrt(sum(rev.^2));
    
    %     Signal2(:,1) = [ sqrt(A) * HrirLeft(:,1)];
    %     Signal2(:,2) = [ sqrt(A) * HrirRight(:,1)];
    
    Signal2(:, 1) = [sqrt(A) * HrirLeft(:, i); sqrt(r1) * rev];
    Signal2(:, 2) = [sqrt(A) * HrirRight(:, i); sqrt(r1) * rev];
    
    result2(:, 1) = conv(Signal2(:, 1), tauTime(1:end, i), 'valid');
    result2(:, 2) = conv(Signal2(:, 2), tauTime(1:end, i), 'valid');
    result1(:, 1) = conv(tauTime(:, i), Signal2(:, 1));
    result1(:, 2) = conv(tauTime(:, i), Signal2(:, 2));
    % %
    %     irPart1(:,1) = conv(tauTime(:,i), sqrt(A) * HrirLeft(:,i), 'valid');
    %     irPart1(:,2) = conv(tauTime(:,i), sqrt(A) * HrirRight(:,i), 'valid');
    %     overlapSamples = length(irPart1)-800;
    %
    %     irPart2(:,1) = conv(tauTime(:,i), sqrt(r1) * rev);
    %     irPart2(:,2) = conv(tauTime(:,i), sqrt(r1) * rev);
    % %     result = [irPart1(1:end-overlapSamples,:);irPart1(end-overlapSamples+1:end,:)+irPart2(1:overlapSamples,:); irPart2(overlapSamples+1:end,:)];
    %     result = [irPart1(1:end-overlapSamples,:); irPart2(:,:)];
    
    
    Prij1{1, i} = result1;
    Prij2{1, i} = result2;
    
    
    %     result(:,1) = conv(tauTime(1:end/2), Signal2(:,1));
    %     result(:,2) = conv(tauTime(1:end/2), Signal2(:,2));
    %     Prij{1,i} = result;
end

%% Plot
for i = 1:1
    figure;
    t = [0:length(Prij1{1, i}) - 1] / 44.1;
    sig = Prij1{1, i};
    plot(sig(:, :));
    hold on;
    %     plot([zeros(length(tauTime),2); Prij2{1,1}]);
    plot([Prij2{1, 1}]);
    plot((Prij2{1, 1}(:, 1) - Prij2{1, 1}(:, 2)));
    plot(sig(128:end, :));
    plot((sig(:, 1) - sig(:, 2)));
    title({'dirac impuse'});
    legend({'full Left', 'full Right', 'valid Left', 'valid Right', 'diff valid left Right', 'full Left Manual cut', 'full Right Manual cut', 'diff full left Right'})
end

%%
sig = Prij1{1, 1};

plot(tauTime(:, 1));
hold on;
plot(sig(:, :));
plot(sig(:, 1)-sig(:, 2));

%%
if PlaySound == 1
    clear footballSi;
    direct = audioread('DirectSoundAnechoic.wav');
    %    football = audioread('Football_orginal.wav');
    guitar = audioread('mono_guitar.wav');
    %  Nois = rand(44100*5,1);
    sig = Prij{1, 1};
    footballSi(:, 1) = conv(guitar(:, 1), sig(:, 1));
    footballSi(:, 2) = conv(guitar(:, 1), sig(:, 2));
    maxFo = max(max(abs(footballSi)));
    guitarNorm = footballSi / maxFo;
    sound(guitarNorm, 44100);
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
% % %%
% for i = 1:1
%     freq = fft(Prij{1,i});
%     freq = freq(1:end/2,:);
%
%     figure;
%     semilogx(f, 10*log10(abs(freq)),'b', 'LineWidth',1)
%
% end

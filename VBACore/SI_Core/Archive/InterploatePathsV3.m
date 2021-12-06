
%% Transmission Coefficients
% This Code Interpolates acording to HRTF
% For Convolution Audio
clear;
clc
Decay = 0;
Geo34
tic;
SI_SoundReductionIndex;
toc;
TDd = 10.^(-RijALL.D / 10);
TFd = 10.^(-RijALL.RiD / 10) + 10.^(-RijALL.LiD / 10) + 10.^(-RijALL.BiD / 10) + 10.^(-RijALL.FiD / 10);
% TDf = 10.^(-RijALL.DRj/10) + 10.^(-RijALL.DLj/10) + 10.^(-RijALL.DBj/10) + 10.^(-RijALL.DFj/10);
% TFf = 10.^(-RijALL.RiRj/10) + 10.^(-RijALL.LiLj/10) + 10.^(-RijALL.BiBj/10) + 10.^(-RijALL.FiFj/10);

%%%%%%%%%%%%% Secondary Sources %%%%%%%%%
Td = TDd + TFd; % OK
Tf1 = 10.^(-RijALL.DRj / 10) + 10.^(-RijALL.RiRj / 10);
Tf2 = 10.^(-RijALL.DLj / 10) + 10.^(-RijALL.LiLj / 10);
Tf3 = 10.^(-RijALL.DBj / 10) + 10.^(-RijALL.BiBj / 10);
Tf4 = 10.^(-RijALL.DFj / 10) + 10.^(-RijALL.FiFj / 10);
% Vector = [100:100:22000]';
freqplot = [0:100:22000];

TT = Td + Tf1 + Tf2 + Tf3 + Tf4;
SBBT = (interp1(f, TT, freqplot, 'pchip', 'extrap')');
SBBD = (interp1(f, Td, freqplot, 'pchip', 'extrap')');
SBB1 = (interp1(f, Tf1, freqplot, 'pchip', 'extrap')');
SBB2 = (interp1(f, Tf2, freqplot, 'pchip', 'extrap')');
SBB3 = (interp1(f, Tf3, freqplot, 'pchip', 'extrap')');
SBB4 = (interp1(f, Tf4, freqplot, 'pchip', 'extrap')');
%
Signal = itaAudio;
Signal.freqData = SBBT;
% Signal.pt
SignalPhase = ita_minimumphase(Signal);
SignalPhase.pt
SignalPhase.pf
axis auto

% SBBT = SBBT(Vector);

%%
SBBD_TimeData = ifft(ifft(SBBT, 'nonsymmetric'));
figure
plot(real(SBBD_TimeData))

%%
semilogx(freqplot, 10*log10(SBBT), 'b');
hold on
semilogx(freqplot, 10*log10(SBBD));
semilogx(freqplot, 10*log10(SBB1));
semilogx(freqplot, 10*log10(SBB2));
semilogx(freqplot, 10*log10(SBB3));
semilogx(freqplot, 10*log10(SBB4));
grid on
xlabel('Frequency (KHz)')
ylabel('Transmission Coefficients (dB)')
title('Flanking Paths for Room 1 and Room 2')
% xticks([])
shg

%% Find HRTF
hrtf = ita_read('ITA_Artificial_Head_5x5_44kHz.ita');
a1 = hrtf.findnearestHRTF(0, 90);
a2 = hrtf.findnearestHRTF(90, 90);
a3 = hrtf.findnearestHRTF(270, 90);
a4 = hrtf.findnearestHRTF(0, 0);
a5 = hrtf.findnearestHRTF(0, 180);
HRTF_T_Freq = a1.freq + a2.freq + a2.freq + a3.freq + a4.freq + a5.freq;
HRTF_L_Freq = HRTF_T_Freq(:, 1);
HRTF_R_Freq = HRTF_T_Freq(:, 2);
HRTF_T_time = a1.timeData + a2.timeData + a2.timeData + a3.timeData + a4.timeData + a5.timeData;
HRTF_L_time = HRTF_T_time(:, 1);
HRTF_R_time = HRTF_T_time(:, 2);

%% Convolution HRIR with SI
%
HRTF_SI_L_Time = conv(SBBD_TimeData, HRTF_L_time);
HRTF_SI_R_Time = conv(SBBD_TimeData, HRTF_R_time);

% figure
% plot(HRTF_SI_L_Time)

%% Convolution HRTF without Rev
HRTF_SID(:, 1) = SBBD .* a1.freq(:, 1);
HRTF_SID(:, 2) = SBBD .* a1.freq(:, 2);
HRTF_SI1(:, 1) = SBB1 .* a2.freq(:, 1);
HRTF_SI1(:, 2) = SBB1 .* a2.freq(:, 2);
HRTF_SI2(:, 1) = SBB2 .* a3.freq(:, 1);
HRTF_SI2(:, 2) = SBB2 .* a3.freq(:, 2);
HRTF_SI3(:, 1) = SBB3 .* a4.freq(:, 1);
HRTF_SI3(:, 2) = SBB3 .* a4.freq(:, 2);
HRTF_SI4(:, 1) = SBB4 .* a5.freq(:, 1);
HRTF_SI4(:, 2) = SBB4 .* a5.freq(:, 2);

HRTFSSDtimeData = real(ifftshift(HRTF_SID));
HRTFSS1timeData = real(ifftshift(HRTF_SI1));
HRTFSS2timeData = real(ifftshift(HRTF_SI2));
HRTFSS3timeData = real(ifftshift(HRTF_SI3));
HRTFSS4timeData = real(ifftshift(HRTF_SI4));

%
HRTFSSD1timeDataL = HRTFSSDtimeData(:, 1) + HRTFSS1timeData(:, 1) + HRTFSS2timeData(:, 1) + HRTFSS3timeData(:, 1) + HRTFSS4timeData(:, 1);
HRTFSSD1timeDataR = HRTFSSDtimeData(:, 2) + HRTFSS1timeData(:, 2) + HRTFSS2timeData(:, 2) + HRTFSS3timeData(:, 2) + HRTFSS4timeData(:, 2);

%
HRTF_SI_Freq_L = HRTF_SID(:, 1) + HRTF_SI1(:, 1) + HRTF_SI2(:, 1) + HRTF_SI3(:, 1) + HRTF_SI4(:, 1);
HRTF_SI_Freq_R = HRTF_SID(:, 2) + HRTF_SI1(:, 2) + HRTF_SI2(:, 2) + HRTF_SI3(:, 2) + HRTF_SI4(:, 2);
%
figure
semilogx(freqplot, 10*log10(HRTF_SI_Freq_L), 'b')
hold on; grid on
semilogx(freqplot, 10*log10(HRTF_SI_Freq_R), 'r')
xlabel('Frequency (kHz)')
ylabel('Magnitude(dB)')
title('Sound Transmission with Binaural HRTF')
shg

figure
plot(HRTFSSD1timeDataL)
hold on; grid on
plot(HRTFSSD1timeDataR)

%

%% Add Audio
[Signal, Fs] = audioread('mono_guitar.wav');
Signal = Signal(:, 1);
Audio_HRIR_L = conv(HRTF_L_time, Signal);
Audio_HRIR_R = conv(HRTF_R_time, Signal);
Audio_HRIR_L = Audio_HRIR_L(1:length(Signal));
Audio_HRIR_R = Audio_HRIR_R(1:length(Signal));

Audio_HRTF_L = fft(Audio_HRIR_L);
Audio_HRTF_R = fft(Audio_HRIR_R);

Len = length(Audio_HRTF_R);
freqplot1 = linspace(10, 20000, Len);

SBBT_Freq = (interp1(f, TT, freqplot1, 'pchip', 'extrap')');

Audio_HRTF_SI_L = Audio_HRTF_L .* SBBT_Freq;
Audio_HRTF_SI_R = Audio_HRTF_R .* SBBT_Freq;
%
Audio_HRIR_SI_L = real(ifft(Audio_HRTF_SI_L));
Audio_HRIR_SI_R = real(ifft(Audio_HRTF_SI_R));

figure
semilogx(freqplot1, 10*log10(Audio_HRTF_SI_L))
hold on; grid on
semilogx(freqplot1, 10*log10(Audio_HRTF_SI_R))
semilogx(freqplot1, 10*log10(Audio_HRTF_L))
% semilogx(freqplot1,10*log10(Audio_HRTF_R))
xlabel('Frequency (KHz)')
ylabel('Magnitude(dB)')
shg

%% Experiment
% freqplot1 = linspace(10,10000,Len);
% freqplot = [0:100:22000];
% SBBT_Freq = (interp1(f,TT,freqplot1,'pchip','extrap')');
% % SBBT_TimeData = ifftshift(SBBT);
% HRTF_T_FreqExtra = (interp1(freqplot,HRTF_T_Freq,freqplot1,'pchip','extrap'))';
% % HRTF_T_TimeExtra = ifftshift(HRTF_T_FreqExtra);
% HRTF_SITT_Freq = SBBT_Freq'.*HRTF_T_FreqExtra(:,1);
% semilogx(freqplot1,10*log10(SBBT_Freq))
% hold on; grid on
% semilogx(freqplot1,10*log10(HRTF_SITT_Freq))
% semilogx(freqplot1,10*log10(HRTF_T_FreqExtra))
% semilogx(freqplot,10*log10(HRTF_T_Freq))

%%
% Result = SBBTplot.*SignalFFT;
% ResultWav = ifft(Result);
% ResultsNorm = ResultWav./max(real(ResultWav));
% ResultsReal = real(ResultWav);
% audiowrite('FAudio.wav',real(ResultsNorm),Fs);
% sound(Signal,44100)
% pause(6)
% sound(real(ResultsNorm),44100)

%%

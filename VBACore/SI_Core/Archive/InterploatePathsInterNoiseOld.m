
%% Transmission Coefficients
% This Code Interpolates acording to HRTF

% clear; clc
Decay = 0;
tic;
Geo34
Latency.GeoLoad = toc * 1000;

tic;
hrtf = ita_read('ITA_Artificial_Head_5x5_44kHz.ita');
Latency.HRTFLoad = toc * 1000;

tic;

Geo23;
SoundReductionIndex;
Latency.InsulationMetrics = toc * 1000;


% freqplot = [0:1:22000];


tic;
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
TT = Td + Tf1 + Tf2 + Tf3 + Tf4;

freqplot = hrtf.freqVector;
EuroNoiseInterpolate;
Latency.FilterConstructionOffline = toc * 1000;

%% RealTimePart

RealtimeConv;

freqplot = [0:1:20000];
% hrtf = ita_read('ITA_Artificial_Head_5x5_44kHz.ita');
% freqplot = hrtf.freqVector;
TT = Td + Tf1 + Tf2 + Tf3 + Tf4;

SBBT = interp1(f, TT, freqplot, 'pchip', 'extrap')';
SBBD = interp1(f, Td, freqplot, 'pchip', 'extrap')';
SBB1 = interp1(f, Tf1, freqplot, 'pchip', 'extrap')';
SBB2 = interp1(f, Tf2, freqplot, 'pchip', 'extrap')';
SBB3 = interp1(f, Tf3, freqplot, 'pchip', 'extrap')';
SBB4 = interp1(f, Tf4, freqplot, 'pchip', 'extrap')';
%
% cs = spline(f,[0 TT 0], freqplot);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Volm = Partion.Length*SWallR.Length*Partion.Width;
% Ps = 80;
% T = 1;
% SD = Partion.Area;
% rij = Partion.Length/2;
% A = Partion.Area + SWallR.Area + SWallL.Area + SWallF.Area + SWallC.Area + SWallB.Area;

% Pr = Ps.*(SD./(0.32*Volm)).*(T./0.5).*Td;
% PrInt = interp1(f,Pr,freqplot,'pchip','extrap')';

% figure
% semilogx(freqplot,10*log10(PrInt))
% hold on
% semilogx(freqplot,10*log10(SBBD))
% hrtf = ita_read('ITA_Artificial_Head_5x5_44kHz.ita');
% a1 = hrtf.findnearestHRTF(0,90);
% HRTF = a1.timeData;
%
% PartA = sqrt((SD./(0.32*Volm)).*(T/0.5).*(TT./(16*pi*rij.^2 + A))).*(Ps_t);
% PartB = sqrt(A).*HRTF + sqrt(16*pi*rij.^2).*h_RIR;
%
% Pr_ij = conv(PartA,PartB);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Phase Information
SBBTITA = itaAudio(PrInt, 44100, 'freq');
SBBTPhase = ita_minimumphase(SBBTITA);
SBBTPhase.pf

%%
SBBTITA1 = itaAudio(SBBT, 44100, 'freq');
SBBTITA1.freqData(1) = 0;
SBBTPhase1 = ita_minimumphase(SBBTITA1);
SBBTPhase1.pt

%% Plotting Interpolat1ed Tau in dB in Frequency Domain
figure
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
legend('SBBT', 'SBBD', 'SBB1', 'SBB2', 'SBB3', 'SBB4')
shg

%% Plotting Interpolat1ed Tau in Time Domain
% SBBT_time = abs(ifftshift(SBBT));
SBBT_time = abs(ifft(SBBT));
SBBD_time = abs(ifft(SBBD));
SBB1_time = abs(ifft(SBB1));
SBB2_time = abs(ifft(SBB2));
SBB3_time = abs(ifft(SBB3));
SBB4_time = abs(ifft(SBB4));
%
t = [0:1 / 44100:(length(SBBT_time) - 1) / 44100];
figure
plot(t, SBBT_time);
grid on;
hold on
plot(t, SBBD_time);
plot(t, SBB1_time);
plot(t, SBB2_time);
plot(t, SBB3_time);
plot(t, SBB4_time);
shg

%% Sound Reduction Index Plotting
% DnT = -10*log10(SBBT)+10*log10((0.32*30)./(20));
fig1 = figure;
semilogx(freqplot, -10*log10(SBBT), 'b');
hold on;
grid on
% semilogx(freqplot,DnT,'.');
semilogx(freqplot, -10*log10(SBBD));
semilogx(freqplot, -10*log10(SBB1));
semilogx(freqplot, -10*log10(SBB2));
semilogx(freqplot, -10*log10(SBB3));
semilogx(freqplot, -10*log10(SBB4));
xlabel('Frequency (KHz)')
ylabel('Sound Reduction Index(dB)')
legend('SBBT', 'SBBD', 'SBB1', 'SBB2', 'SBB3', 'SBB4')
shg

%% Find HRTF
% hrtf = ita_read('H:\Projects\Sound Insulation\HRTF Database\ITA_Artificial_Head_5x5_44kHz_444.v17.ir.daff');
hrtf = ita_read('ITA_Artificial_Head_5x5_44kHz.ita');
a1 = hrtf.findnearestHRTF(0, 90);
a2 = hrtf.findnearestHRTF(89, 90);
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
HRTF_SIT(:, 1) = SBBT .* a1.freq(:, 1);
HRTF_SIT(:, 2) = SBBT .* a1.freq(:, 2);

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

HRTF_SI_Total = HRTF_SID + HRTF_SI1 + HRTF_SI2 + HRTF_SI3 + HRTF_SI4;

%% Plotting HRTF and SI
figure
semilogx(freqplot, 10*log10(HRTF_SI_Total), '-b');
semilogx(freqplot, 10*log10(HRTF_SIT), '--b');
hold on
semilogx(freqplot, 10*log10(HRTF_SID));
semilogx(freqplot, 10*log10(HRTF_SI1));
semilogx(freqplot, 10*log10(HRTF_SI2));
semilogx(freqplot, 10*log10(HRTF_SI3));
semilogx(freqplot, 10*log10(HRTF_SI4));
grid on
xlabel('Frequency (KHz)')
ylabel('Magnitude (dB)')
title('Inclusion of HRTF with Interploated Spectra')
shg

%% Time Domain HRTF and SI
HRTF_SIT_L = HRTF_SIT(:, 1);
HRTF_SIT_R = HRTF_SIT(:, 2);

% HRTF_SIT_L_Flip = flipud(HRTF_SIT_L);
% HRTF_SIT_R_Flip =flipud(HRTF_SIT_R);
% HRTF_SIT_L_C = [HRTF_SIT_L; HRTF_SIT_L_Flip];
% HRTF_SIT_R_C = [HRTF_SIT_R; HRTF_SIT_R_Flip];

HRTF_SIT_L_Time = ifft(HRTF_SIT_L);
HRTF_SIT_R_Time = ifft(HRTF_SIT_R);

figure
semilogx(freqplot, 10*log10(HRTF_SIT));
grid on

figure
t = [0:1 / 44100:(length(HRTF_SIT_L_Time) - 1) / 44100];
plot(t, abs(HRTF_SIT_L_Time));
grid on;
hold on
plot(t, abs(HRTF_SIT_R_Time))
%

%% Add Audio in time Domain Convolution
[Signal, Fs] = audioread('mono_sprache.wav');
Signal = Signal(:, 1);
Audio_HRIR_L = conv(HRTF_SIT_L_Time, Signal);
Audio_HRIR_R = conv(HRTF_SIT_R_Time, Signal);
Audio_HRIR_L = real(Audio_HRIR_L(1:length(Signal)));
Audio_HRIR_R = real(Audio_HRIR_R(1:length(Signal)));
% Normalized
Audio_HRIR_L_Norm = Audio_HRIR_L ./ max(abs(Audio_HRIR_L));
Audio_HRIR_R_Norm = Audio_HRIR_R ./ max(abs(Audio_HRIR_R));
Audio_HRIR_Total_Norm = [Audio_HRIR_L_Norm, Audio_HRIR_R_Norm];

%% Add Audio in Frequency Domain Convolution

Audio_Freq = fft(Signal, 2*length(Signal));
Audio_HRTF_L = fft(Audio_HRIR_L, 2*length(Signal));
Audio_HRTF_R = fft(Audio_HRIR_R, 2*length(Signal));


% Audio_HRTF_L = Audio_Freq.*HRTF_SIT_L;
% Audio_HRTF_R = Audio_Freq.*HRTF_SIT_R;
Len = floor(length(Audio_HRTF_R)/2);
freqplot1 = linspace(10, 20000, Len);
% SBBT_Freq = (interp1(f,TT,freqplot1,'pchip','extrap')');
% Audio_HRTF_SI_L = Audio_HRTF_L.*SBBT_Freq;
% Audio_HRTF_SI_R = Audio_HRTF_R.*SBBT_Freq;
% %
% Audio_HRIR_SI_L = real(ifft(Audio_HRTF_SI_L));
% Audio_HRIR_SI_R = real(ifft(Audio_HRTF_SI_R));


figure
semilogx(freqplot1, 10*log10(Audio_Freq(1:end/2)))
hold on; grid on
semilogx(freqplot1, 10*log10(Audio_HRTF_L(1:end/2)))
semilogx(freqplot1, 10*log10(Audio_HRTF_R(1:end/2)))
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

% Erev/Edir
Geo34

r = Partion.Length ./ 2;
A = Partion.Area;
RatioErev2Edir = (16 * pi .* (r).^2) ./ (A);
RatioErev2Edir

%%
%
% x = -1:0.1:1;
% x1 = x-10;
% y = dirac(x1);
% idx = y == Inf; % find Inf
% y(idx) = 1;     % set Inf to finite value
% stem(y)
% shg
% hold on
%
%

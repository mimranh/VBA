
%% Transmission Coefficients

%% Transmission Coefficients
% For Convolution Audio

[Signal, Fs] = audioread('Audio.wav');
Signal = Signal(:, 1);
% y = wgn(2*44100,1,0); White Noise
% Signal = y;
SignalFFT = fft(Signal);
Len = length(SignalFFT);

tic;
SoundReductionIndex;
toc

freqplot = linspace(0, 20000, Len);
%freq = (0:100:22000);
% ff = (0:100:22000);

TT = Td + Tf1 + Tf2 + Tf3 + Tf4;
SBBTplot = (interp1(f, TT, freqplot, 'pchip', 'extrap')');
SBBDplot = (interp1(f, Td, freqplot, 'pchip', 'extrap')');
SBB1plot = (interp1(f, Tf1, freqplot, 'pchip', 'extrap')');
SBB2plot = (interp1(f, Tf2, freqplot, 'pchip', 'extrap')');
SBB3plot = (interp1(f, Tf3, freqplot, 'pchip', 'extrap')');
SBB4plot = (interp1(f, Tf4, freqplot, 'pchip', 'extrap')');

Result = SBBTplot .* SignalFFT;
ResultWav = ifft(Result);
ResultsNorm = ResultWav ./ max(real(ResultWav));
ResultsReal = real(ResultWav);
% audiowrite('FAudio.wav',real(ResultsNorm),Fs);
% sound(Signal,44100)
% pause(6)
% sound(real(ResultsNorm),44100)


SoundReductionIndex
freq = [0:100:22000];
TT = Td + Tf1 + Tf2 + Tf3 + Tf4;
BBT = 20 * log10(interp1(f, TT, freq, 'pchip', 'extrap'));
BBD = 20 * log10(interp1(f, Td, freq, 'pchip', 'extrap'));
BB1 = 20 * log10(interp1(f, Tf1, freq, 'pchip', 'extrap'));
BB2 = 20 * log10(interp1(f, Tf2, freq, 'pchip', 'extrap'));
BB3 = 20 * log10(interp1(f, Tf3, freq, 'pchip', 'extrap'));
BB4 = 20 * log10(interp1(f, Tf4, freq, 'pchip', 'extrap'));
figure
semilogx(freq, BBT, '-.')
grid on; hold on; shg
semilogx(freq, BBD, '--')
semilogx(freq, BB1)
semilogx(freq, BB2)
semilogx(freq, BB3)
semilogx(freq, BB4)

%% Sound Reduction
SoundReductionIndex

BBD = -(10 * log10(Td));
BB1 = -(10 * log10(Tf1));
BB2 = -(10 * log10(Tf2));
BB3 = -(10 * log10(Tf3));
BB4 = -(10 * log10(Tf4));

% freq1 = [0:100:22000];
% freq = [0:1:22000];

freq = [0:100:22000];

SBBD = (interp1(f, BBD, freq, 'pchip', 'extrap'));
SBB1 = (interp1(f, BB1, freq, 'pchip', 'extrap'));
SBB2 = (interp1(f, BB2, freq, 'pchip', 'extrap'));
SBB3 = (interp1(f, BB3, freq, 'pchip', 'extrap'));
SBB4 = (interp1(f, BB4, freq, 'pchip', 'extrap'));

figure
semilogx(freq, -SBBD, '-.')
grid on; hold on; shg
semilogx(freq, -SBB1)
% grid on; hold on; shg
semilogx(freq, -SBB2)
semilogx(freq, -SBB3)
semilogx(freq, -SBB4)

%% HRTF
% hrtf = ita_read('ITA_Artificial_Head_5x5_44kHz.ita');
ita_hrtf;
a1 = hrtf.findnearestHRTF(0, 90);
a2 = hrtf.findnearestHRTF(90, 90);
a3 = hrtf.findnearestHRTF(270, 90);
a4 = hrtf.findnearestHRTF(0, 0);
a5 = hrtf.findnearestHRTF(0, 180);
A1 = a1.freqData_dB;
A2 = a2.freqData_dB;
A3 = a3.freqData_dB;
A4 = a4.freqData_dB;
A5 = a5.freqData_dB;

LeftCHS1 = A1(:, 1);
LeftCHS2 = A2(:, 1);
LeftCHS3 = A3(:, 1);
LeftCHS4 = A4(:, 1);
LeftCHS5 = A5(:, 1);
RightCHS1 = A1(:, 2);
RightCHS2 = A2(:, 2);
RightCHS3 = A3(:, 2);
RightCHS4 = A4(:, 2);
RightCHS5 = A5(:, 2);

% LeftCHS1 = (interp1(freq1,LeftCHS1,freq,'pchip','extrap'));
% LeftCHS2 = (interp1(freq1,LeftCHS2,freq,'pchip','extrap'));
% LeftCHS3 = (interp1(freq1,LeftCHS3,freq,'pchip','extrap'));
% LeftCHS4 = (interp1(freq1,LeftCHS4,freq,'pchip','extrap'));
% LeftCHS5 = (interp1(freq1,LeftCHS5,freq,'pchip','extrap'));
% RightCHS1 = (interp1(freq1,RightCHS1,freq,'pchip','extrap'));
% RightCHS2 = (interp1(freq1,RightCHS2,freq,'pchip','extrap'));
% RightCHS3 = (interp1(freq1,RightCHS3,freq,'pchip','extrap'));
% RightCHS4 = (interp1(freq1,RightCHS4,freq,'pchip','extrap'));
% RightCHS5 = (interp1(freq1,RightCHS5,freq,'pchip','extrap'));

SBBD_L = -SBBD' + LeftCHS1;
SBB1_L = -SBB1' + LeftCHS2;
SBB2_L = -SBB2' + LeftCHS3;
SBB3_L = -SBB3' + LeftCHS4;
SBB4_L = -SBB4' + LeftCHS5;
SBBT_L = SBBD_L + SBB1_L + SBB2_L + SBB3_L + SBB4_L;

SBBD_R = -SBBD' + RightCHS1;
SBB1_R = -SBB1' + RightCHS2;
SBB2_R = -SBB2' + RightCHS3;
SBB3_R = -SBB3' + RightCHS4;
SBB4_R = -SBB4' + RightCHS5;
SBBT_R = SBBD_R + SBB1_R + SBB2_R + SBB3_R + SBB4_R;


semilogx(freq, SBBD_L)
hold on; grid on
semilogx(freq, SBB1_L)
semilogx(freq, SBB2_L)
semilogx(freq, SBB3_L)
semilogx(freq, SBB4_L)
semilogx(freq, SBBD_R)
semilogx(freq, SBB1_R)
semilogx(freq, SBB2_R)
semilogx(freq, SBB3_R)
semilogx(freq, SBB4_R)

semilogx(freq, LeftCHS1)
semilogx(freq, LeftCHS2)
semilogx(freq, LeftCHS3)
semilogx(freq, LeftCHS4)
semilogx(freq, LeftCHS5)
semilogx(freq, RightCHS1)
semilogx(freq, RightCHS2)
semilogx(freq, RightCHS3)
semilogx(freq, RightCHS4)
semilogx(freq, RightCHS5)
shg

% figure
% semilogx(freq,SBBT_L)
% hold on; grid on
% semilogx(freq,SBBT_R)

%%
R_timeR1 = real(ifft(RightCHS1));
R_timeR2 = real(ifft(RightCHS2));
R_timeR3 = real(ifft(RightCHS3));
R_timeR4 = real(ifft(RightCHS4));
R_timeR5 = real(ifft(RightCHS5));
R_Total_R = R_timeR1 + R_timeR2 + R_timeR3 + R_timeR4 + R_timeR5;
R_Total_R = R_Total_R ./ max(abs(R_Total_R));

R_timeL1 = real(ifft(LeftCHS1));
R_timeL2 = real(ifft(LeftCHS2));
R_timeL3 = real(ifft(LeftCHS3));
R_timeL4 = real(ifft(LeftCHS4));
R_timeL5 = real(ifft(LeftCHS5));
R_Total_L = R_timeL1 + R_timeL2 + R_timeL3 + R_timeL4 + R_timeL5;
R_Total_L = R_Total_L ./ max(abs(R_Total_L));

figure
plot(real(R_Total_L))
hold on; grid on
plot(real(R_Total_R))
shg

HRTF_T_L = real(fft(R_Total_L));
HRTF_T_R = real(fft(R_Total_R));

% plot(real(R_time3))
% plot(real(R_time4))
% plot(real(R_time5))
%

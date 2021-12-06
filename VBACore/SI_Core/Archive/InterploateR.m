Octave20 = [20, 25, 31.5, 40, 50, 63, 80, 100, 125, 160, 200, 250, 315, 400, 500, 630, 800, 1000, 1250, 1600, 2000, 2500, 3150, 4000, 5000, 6300, 8000, 10000, 12500, 16000, 20000];

BiBj = [zeros(1, 4), ElementsResults.RijALL.BiBj, zeros(1, 6)];
BiD = ElementsResults.RijALL.BiD;
D = ElementsResults.RijALL.D;
DBj = ElementsResults.RijALL.DBj;
DFj = ElementsResults.RijALL.DFj;
DLj = ElementsResults.RijALL.DLj;
DRj = ElementsResults.RijALL.DRj;
FiD = ElementsResults.RijALL.FiD;
FiFj = ElementsResults.RijALL.FiFj;
LiD = ElementsResults.RijALL.LiD;
LiLj = ElementsResults.RijALL.LiLj;
RiD = ElementsResults.RijALL.RiD;
RiRj = ElementsResults.RijALL.RiRj;

k = 6;
for i = 1:31
    if i < 4
        if BiBj(k-i) < 30
        else
            BiBj(k-i-1) = BiBj(k-i) - 3.6;
            
        end
    else
    end
    
    
    if i > 25
        %         if BiBj(i-1) < 30
        %             BiBj(i) = 0;
        %         else
        BiBj(i) = BiBj(i-1) - 3.6;
        %         end
    end
end

%%
% freq = linspace(0,2200,4097);
freq = [0:22000];

% Path1 = interp1(f,ElementsResults.TDf,freq,'pchip','extrap');
AA = ElementsResults.RijALL.LiLj;
% AA = Mic(:,2);
BB = interp1(f, AA, freq, 'pchip', 'extrap');
BB = -BB;
figure
semilogx(freq, BB)
grid on
hold on
shg

%%
freq = [0:22000];
soundInsulation1 = interp1(f, ElementsResults.RijALL.BiBj, freq, 'pchip', 'extrap');
soundInsulation2 = interp1(f, ElementsResults.RijALL.BiD, freq, 'pchip', 'extrap');
soundInsulation3 = interp1(f, ElementsResults.RijALL.D, freq, 'pchip', 'extrap');
soundInsulation4 = interp1(f, ElementsResults.RijALL.DBj, freq, 'pchip', 'extrap');
soundInsulation5 = interp1(f, ElementsResults.RijALL.DFj, freq, 'pchip', 'extrap');
soundInsulation6 = interp1(f, ElementsResults.RijALL.DLj, freq, 'pchip', 'extrap');
soundInsulation7 = interp1(f, ElementsResults.RijALL.DRj, freq, 'pchip', 'extrap');
soundInsulation8 = interp1(f, ElementsResults.RijALL.FiD, freq, 'pchip', 'extrap');
soundInsulation9 = interp1(f, ElementsResults.RijALL.FiFj, freq, 'pchip', 'extrap');
soundInsulation10 = interp1(f, ElementsResults.RijALL.LiD, freq, 'pchip', 'extrap');
soundInsulation11 = interp1(f, ElementsResults.RijALL.LiLj, freq, 'pchip', 'extrap');
soundInsulation12 = interp1(f, ElementsResults.RijALL.RiD, freq, 'pchip', 'extrap');
soundInsulation13 = interp1(f, ElementsResults.RijALL.RiRj, freq, 'pchip', 'extrap');

%%
figure
semilogx(freq, -soundInsulation1)
hold on
semilogx(freq, -soundInsulation2)
semilogx(freq, -soundInsulation3)
semilogx(freq, -soundInsulation4)
semilogx(freq, -soundInsulation5)
semilogx(freq, -soundInsulation6)
semilogx(freq, -soundInsulation7)
semilogx(freq, -soundInsulation8)
semilogx(freq, -soundInsulation9)
semilogx(freq, -soundInsulation10)
semilogx(freq, -soundInsulation11)
semilogx(freq, -soundInsulation12)
semilogx(freq, -soundInsulation13)

% R_time = ifft(soundInsulation1);
% figure
% plot(real(R_time))

%%
% TDd = ElementsResults.TDd;
% TFd = ElementsResults.TFd;
% TDf = ElementsResults.TDf;
% TFf = ElementsResults.TFf;
% Td = TDd + TFd;
% Tf = TDf + TFf;
% tau = Td + Tf;
%
% T1 = TDd+TFD;
%
% SoundREductionIndexTotal = -(10*log10(tau));
% SoundD = -(10*log10(T1));

%% Transmission Coefficients
freq = [0:0.1:20000];
TT = Td + Tf1 + Tf2 + Tf3 + Tf4;
BBT = 20 * log10(interp1(f, TT, freq, 'pchip', 'extrap'));
% semilogx(freq,BBT, '-.'); grid on; shg
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
BBT = -(10 * log10(Td));
BB1 = -(10 * log10(Tf1));
BB2 = -(10 * log10(Tf2));
BB3 = -(10 * log10(Tf3));
BB4 = -(10 * log10(Tf4));

freq = [0:100:22000];
SBBT = (interp1(f, BBT, freq, 'pchip', 'extrap'));
SBB1 = (interp1(f, BB1, freq, 'pchip', 'extrap'));
SBB2 = (interp1(f, BB2, freq, 'pchip', 'extrap'));
SBB3 = (interp1(f, BB3, freq, 'pchip', 'extrap'));
SBB4 = (interp1(f, BB4, freq, 'pchip', 'extrap'));

figure
semilogx(freq, -SBBT, '-.')
grid on; hold on; shg
semilogx(freq, -SBB1)
% grid on; hold on; shg
semilogx(freq, -SBB2)
semilogx(freq, -SBB3)
semilogx(freq, -SBB4)

%% HRTF
hrtf = ita_read('ITA_Artificial_Head_5x5_44kHz.ita');
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

SBBT_L = -SBBT' + LeftCHS1;
SBB1_L = -SBB1' + LeftCHS2;
SBB2_L = -SBB2' + LeftCHS3;
SBB3_L = -SBB3' + LeftCHS4;
SBB4_L = -SBB4' + LeftCHS5;

SBBT_R = -SBBT' + RightCHS1;
SBB1_R = -SBB1' + RightCHS2;
SBB2_R = -SBB2' + RightCHS3;
SBB3_R = -SBB3' + RightCHS4;
SBB4_R = -SBB4' + RightCHS5;


semilogx(freq, SBBT_L)
hold on; grid on
semilogx(freq, SBB1_L)
semilogx(freq, SBB2_L)
semilogx(freq, SBB3_L)
semilogx(freq, SBB4_L)
semilogx(freq, SBBT_R)
semilogx(freq, SBB1_R)
semilogx(freq, SBB2_R)
semilogx(freq, SBB3_R)
semilogx(freq, SBB4_R)
shg


semilogx(freq, LeftCHS1)
hold on; grid on
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

R_time1 = ifft(LeftCHS1);
R_time2 = ifft(LeftCHS2);
R_time3 = ifft(LeftCHS3);
R_time4 = ifft(LeftCHS4);
R_time5 = ifft(LeftCHS5);

figure
plot(real(R_time1))
hold on
plot(real(R_time2))
plot(real(R_time3))
plot(real(R_time4))
plot(real(R_time5))

%%
semilog(f, Td)
hold on; grid on
semilogx(f, Tf1)
semilogx(f, Tf2)
semilogx(f, Tf3)
semilogx(f, Tf4)
shg

%%

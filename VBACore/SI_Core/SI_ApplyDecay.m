
% % Fill All remaining Band
Octave20 = [20, 25, 31.5, 40, 50, 63, 80, 100, 125, 160, 200, 250, 315, 400, 500, 630, 800, 1000, 1250, 1600, 2000, 2500, 3150, 4000, 5000, 6300, 8000, 10000, 12500, 16000, 20000];
f = Octave20;

RijALL.D = [0, 0, 0, 0, RijALL.D, 0, 0, 0, 0, 0, 0];
RijALL.DRj = [0, 0, 0, 0, RijALL.DRj, 0, 0, 0, 0, 0, 0];
RijALL.DLj = [0, 0, 0, 0, RijALL.DLj, 0, 0, 0, 0, 0, 0];
RijALL.DBj = [0, 0, 0, 0, RijALL.DBj, 0, 0, 0, 0, 0, 0];
RijALL.DFj = [0, 0, 0, 0, RijALL.DFj, 0, 0, 0, 0, 0, 0];
RijALL.RiD = [0, 0, 0, 0, RijALL.RiD, 0, 0, 0, 0, 0, 0];
RijALL.LiD = [0, 0, 0, 0, RijALL.LiD, 0, 0, 0, 0, 0, 0];
RijALL.BiD = [0, 0, 0, 0, RijALL.BiD, 0, 0, 0, 0, 0, 0];
RijALL.FiD = [0, 0, 0, 0, RijALL.FiD, 0, 0, 0, 0, 0, 0];
RijALL.RiRj = [0, 0, 0, 0, RijALL.RiRj, 0, 0, 0, 0, 0, 0];
RijALL.LiLj = [0, 0, 0, 0, RijALL.LiLj, 0, 0, 0, 0, 0, 0];
RijALL.BiBj = [0, 0, 0, 0, RijALL.BiBj, 0, 0, 0, 0, 0, 0];
RijALL.FiFj = [0, 0, 0, 0, RijALL.FiFj, 0, 0, 0, 0, 0, 0];

% RijALL.D = [RijALL.D,0,0,0,0,0,0];
% RijALL.DRj = [RijALL.DRj,0,0,0,0,0,0];
% RijALL.DLj = [RijALL.DLj,0,0,0,0,0,0];
% RijALL.DBj = [RijALL.DBj,0,0,0,0,0,0];
% RijALL.DFj = [RijALL.DFj,0,0,0,0,0,0];
% RijALL.RiD = [RijALL.RiD,0,0,0,0,0,0];
% RijALL.LiD = [RijALL.LiD,0,0,0,0,0,0];
% RijALL.BiD = [RijALL.BiD,0,0,0,0,0,0];
% RijALL.FiD = [RijALL.FiD,0,0,0,0,0,0];
% RijALL.RiRj = [RijALL.RiRj,0,0,0,0,0,0];
% RijALL.LiLj = [RijALL.LiLj,0,0,0,0,0,0];
% RijALL.BiBj = [RijALL.BiBj,0,0,0,0,0,0];
% RijALL.FiFj = [RijALL.FiFj,0,0,0,0,0,0];

%% For Low Frequencies
k = 5;
for m = 1:4
    RijALL.D(k-1) = RijALL.D(k) - DecayLow;
    RijALL.DRj(k-1) = RijALL.DRj(k) - DecayLow;
    RijALL.DLj(k-1) = RijALL.DLj(k) - DecayLow;
    RijALL.DBj(k-1) = RijALL.DBj(k) - DecayLow;
    RijALL.DFj(k-1) = RijALL.DFj(k) - DecayLow;
    RijALL.RiD(k-1) = RijALL.RiD(k) - DecayLow;
    RijALL.LiD(k-1) = RijALL.LiD(k) - DecayLow;
    RijALL.BiD(k-1) = RijALL.BiD(k) - DecayLow;
    RijALL.FiD(k-1) = RijALL.FiD(k) - DecayLow;
    RijALL.RiRj(k-1) = RijALL.RiRj(k) - DecayLow;
    RijALL.LiLj(k-1) = RijALL.LiLj(k) - DecayLow;
    RijALL.BiBj(k-1) = RijALL.BiBj(k) - DecayLow;
    RijALL.FiFj(k-1) = RijALL.FiFj(k) - DecayLow;
    k = k - 1;
end

%% For High Frequencies
kk = 26;
for m = 1:6
    if kk <= 28
        DecayHigh = DecayHigh1;
    else
        DecayHigh = DecayHigh2;
    end
    RijALL.D(kk) = RijALL.D(kk-1) - DecayHigh;
    RijALL.DRj(kk) = RijALL.DRj(kk-1) - DecayHigh;
    RijALL.DLj(kk) = RijALL.DLj(kk-1) - DecayHigh;
    RijALL.DBj(kk) = RijALL.DBj(kk-1) - DecayHigh;
    RijALL.DFj(kk) = RijALL.DFj(kk-1) - DecayHigh;
    RijALL.RiD(kk) = RijALL.RiD(kk-1) - DecayHigh;
    RijALL.LiD(kk) = RijALL.LiD(kk-1) - DecayHigh;
    RijALL.BiD(kk) = RijALL.BiD(kk-1) - DecayHigh;
    RijALL.FiD(kk) = RijALL.FiD(kk-1) - DecayHigh;
    RijALL.RiRj(kk) = RijALL.RiRj(kk-1) - DecayHigh;
    RijALL.LiLj(kk) = RijALL.LiLj(kk-1) - DecayHigh;
    RijALL.BiBj(kk) = RijALL.BiBj(kk-1) - DecayHigh;
    RijALL.FiFj(kk) = RijALL.FiFj(kk-1) - DecayHigh;
    kk = kk + 1;
end

RijALL.D(RijALL.D < 0) = 0;
RijALL.DRj(RijALL.DRj < 0) = 0;
RijALL.DLj(RijALL.DLj < 0) = 0;
RijALL.DBj(RijALL.DBj < 0) = 0;
RijALL.DFj(RijALL.DFj < 0) = 0;
RijALL.RiD(RijALL.RiD < 0) = 0;
RijALL.LiD(RijALL.LiD < 0) = 0;
RijALL.BiD(RijALL.BiD < 0) = 0;
RijALL.FiD(RijALL.FiD < 0) = 0;
RijALL.RiRj(RijALL.RiRj < 0) = 0;
RijALL.LiLj(RijALL.LiLj < 0) = 0;
RijALL.BiBj(RijALL.BiBj < 0) = 0;
RijALL.FiFj(RijALL.FiFj < 0) = 0;

figure
semilogx(f, RijALL.D);
grid on

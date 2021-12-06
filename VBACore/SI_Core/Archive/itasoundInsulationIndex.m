function varargout = itasoundInsulationIndex(varargin)
% soundInsulationIndex = ita_soundInsulationIndex(soundInsulation,['spectrum'],[spec],['frequencyVector'], [frequency Vector],['create plot'])
% soundInsulation must be an itaResult (to do for Markus: or itaAudio) or a vector in dB
% when soundIsulation is not an itaResult (Markus: or itaAudio) you will
% need a frequency vector of the same length
% First example:
% b = 0.115;mV = 1500;mF = mV*b;RW =61;c=343;rho = 1.2;R = itaResult; R.freqVector =20:5:2000; R.freqData= 2*pi*R.freqVector*mF/rho/c/2;
% soundInsulationIndex = ita_soundInsulationIndex(R)
% Second example:
% R = 1:30; freq = linspace(20,10000,length(R));
% soundInsulationIndex = ita_soundInsulationIndex(R,'spectrum','third','frequencyVector', freq,'create plot')

%% input
% Wen mein Englisch stört, der soll es bitte unkommentiert korrigieren.
msgIn = 'Wrong number of input parameter.';
msgMulti = 'Only the first vector of the sound insulation will be used.';
msgSpec = 'Pararmeter SPECTRUM is chosen as THIRD';
msgExtrap = 'Your sound insulation will be exprapolated.';
msgOut = 'Wrong number of output parameter';
if nargin > 0
    soundInsulationIn = varargin{1};
    if isa(soundInsulationIn, 'itaResult') % || isa(soundInsulationIn,'itaAudio') %to do for Markus
        if size(soundInsulationIn.freqData, 1) > 1 && size(soundInsulationIn.freqData, 2) > 1
            warning('ita_soundInsulationIndex:input', msgMulti)
        end
    elseif isreal(soundInsulationIn)
        if sum(strcmp(varargin, 'frequencyVector')) == 1
            pos = find(strcmp(varargin, 'frequencyVector') == 1);
            freqVector = varargin{pos+1};
            if length(freqVector) ~= length(soundInsulationIn)
                error('ita_soundInsulationIndex:input', 'Frequency vector and sound insulation must have the same length.')
            end
            if size(soundInsulationIn, 1) > 1 && size(soundInsulationIn, 2) > 1
                warning('ita_soundInsulationIndex:input', msgMulti);
            end
        end
    else
        error('ita_soundInsulationIndex:input', msgIn)
    end
    
    if nargin == 1
        spec = 'third';
        warning('ita_soundInsulationIndex:input', msgSpec);
    elseif nargin > 2
        if sum(strcmp(varargin, 'spectrum')) == 1
            pos = find(strcmp(varargin, 'spectrum') == 1);
            spec = varargin{pos+1};
            if ~strcmp(spec, 'third') && ~strcmp(spec, 'octave')
                spec = 'third';
                warning('ita_soundInsulationIndex:input', 'Pararmeter SPECTRUM is chosen as THIRD');
            end
        else
            spec = 'third';
            warning('ita_soundInsulationIndex:input', msgSpec);
        end
    end
    if sum(strcmp(varargin, 'create plot')) == 1
        createPlot = 1;
        if nargin == 2
            spec = 'third';
            warning('ita_soundInsulationIndex:input', msgSpec);
        end
    else
        createPlot = 0;
    end
else
    error('ita_soundInsulationIndex:input', msgIn)
end

if nargout > 1
    error('ita_soundInsulationIndex:output', msgOut)
end

%% additional parameters
if strcmp(spec, 'third'), refSurf = 32;
else refSurf = 10;
end
refFreq = 500;

%% data preparation
if strcmp(spec, 'octave')
    refCurve = [36, 45, 52, 55, 56];
    freq = [125, 250, 500, 1000, 2000]; % Oktavfrequenzen nach ISO 717
    lFreq = length(refCurve);
else
    freq = [100, 125, 160, 200, 250, 315, 400, 500, 630, 800, 1000, 1250, 1600, 2000, 2500, 3150]; % Terzfrequenzen nach ISO 717-1
    refCurve = [33, 36, 39, 42, 45, 48, 51, 52, 53, 54, 55, 56, 56, 56, 56, 56]; % Referenzkurve aus IS0 717-1
    lFreq = length(refCurve);
end

if isa(soundInsulationIn, 'itaResult') % || isa(soundInsulationIn,'itaAudio') %to do for Markus
    soundInsulation = interp1(soundInsulationIn.freqVector, soundInsulationIn.freqData(:, 1), freq, 'spline', 'extrap');
    soundInsulation = 20 * log10(soundInsulation);
    if isempty(find(soundInsulationIn.freqVector <= freq(1), 1, 'first')) || isempty(find(soundInsulationIn.freqVector >= freq(end), 1, 'first'))
        warning('ita_soundInsulationIndex:input', msgExtrap);
    end
else
    freq = linspace(0, 5000, 4096);
    soundInsulation = interp1(freqVector, soundInsulationIn, freq, 'spline', 'extrap');
    if isempty(find(freqVector <= freq(1), 1, 'first')) || isempty(find(freqVector >= freq(end), 1, 'first'))
        warning('ita_soundInsulationIndex:input', msgExtrap);
    end
    disp('SOUND INSULATION --> dB!')
end

%% sound insulation index
% wer Lust und Zeit hat, kann den Algorithmus gerne effektiver
% implementieren
abweichung = refCurve - soundInsulation;
soundInsulationIndexTest = sum(abweichung);
counter = 0; % Abbruchkriterium
while sum(soundInsulationIndexTest) < refSurf - 1 || sum(soundInsulationIndexTest) > refSurf % solange die Referenzkurve verschieben bis maximal 32dB
    if counter == 0 % Anpassung der refTerzkurve
        Diff = round(mean(abweichung)*10) / 10;
    elseif sum(soundInsulationIndexTest) < refSurf - 1
        Diff = Diff + 0.1;
    else
        Diff = Diff - 0.1;
    end
    
    abweichung = (refCurve + Diff) - soundInsulation;
    for i1 = 1:length(abweichung)
        if abweichung(i1) < 0
            abweichung(i1) = 0;
        end
    end
    soundInsulationIndexTest = sum(abweichung);
    
    counter = counter + 1;
    if counter > 10^6
        warning('ita_soundInsulationIndex:algorithm', 'algorithm is not stable.')
    end
end

pos = freq == refFreq;
soundInsulationFreq = refCurve + Diff;
soundInsulationIndex = round(soundInsulationFreq(pos)*100) / 100;

%% output
% disp(' ')
% disp(['surface: ' num2str(round(soundInsulationIndexTest*100)/100) 'dB/ 32dB '])
% disp(['shift = ' num2str(Diff) 'dB'])
% disp(['RW = ' num2str(soundInsulationIndex) 'dB'])

if createPlot == 1
    plotResult = itaResult;
    plotResult.freqVector = freq;
    plotResult.freqData(:, 1) = 10.^((refCurve + Diff) / 20);
    plotResult.freqData(:, 3) = 10.^(soundInsulation / 20);
    plotResult.freqData(:, 2) = ones(lFreq, 1) * 10.^(soundInsulationIndex / 20);
    
    plotResult.channelNames{3} = 'sound insulation';
    plotResult.channelNames{1} = 'fitted reference curve';
    plotResult.channelNames{2} = ['R_W = ', num2str(soundInsulationIndex), 'dB'];
    
    % plotResult.freqData(:,4) = 10.^(refCurve/20);
    % plotResult.channelNames{4} = 'reference curve';
    plotResult.plot_freq;
    xlim([min(freq), max(freq)]);
end

varargout{1} = soundInsulationIndex;

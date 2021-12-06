function [ElementName] = SI_AssignMaterialProperties(Name)
%
% This Function Configures the Materials and the properties associated with each material Element
% 1. Type of Material
% 2. Density
% 3. Qausi Longitudnal Phase Velocity
% 4. Internal Loss Factor
% 5. Mass
% 6. Thickness
% 6. Dimentions (i.e. Length Width etc.)
% These are constant and could be found on Material Database
% The Available Material Data in this Code are as follows
% 1. Concrete
% 2 .Calcium
% 3. Autoclaved Concrete
% 4. Light Aggregate Blocks
% 5. Dense Aggregate Blocks
% 6. Bricks
% 7. Plaster Board Type 1 (Natural Gypsum)
% 8. Plaster Board Type 2 (Flue Gas and Natural Gypsum)
% 9. Chipboard
%
% Usage ofhe t Function is as folows:
%   [ElementName] = AssignMaterialProperties('Concrete');             or
%   [ElementName] = AssignMaterialProperties('Bricks');               or
%   [ElementName] = AssignMaterialProperties('LightAggregateBlocks');
%
% Author:         Muhammad Imran (mim@akustik.rwth-aachen.de)
% Version:        0.1
% First release:  2017
% Last revision:  2017
% Copyright:      Institute of Technical Acoustics, RWTH Aachen University
%

%% Material Properties
if (nargin >=2 || ~ischar(Name))
    error('Check Inputs: Must be a Charecter and Single Name of Material from the followings: Concrete,Calcium,AutoclavedConcrete,LightAggregateBlocks,DenseAggregateBlocks,Bricks,Plasterboard,Plasterboard2,Chipboard')
end
%
% EN12354-1 Data: Example Data for Sound Reduction Index from En 12354-1 for some speciman Material
if exist('ReductionData.mat', 'file') == 2
    load ReductionData;
end
%
if strcmp(Name, 'Concrete')
    % 1
    Concrete.Type = 'Concrete';
    Concrete.Density = 2200;
    Concrete.QuasiLongPhaseVelocity = 3800;
    Concrete.InternalLossFactor = 0.005;
    ElementName = Concrete;
elseif strcmp(Name, 'Calcium')
    % 2
    Calcium.Type = 'Calcium';
    Calcium.Density = 1800;
    Calcium.QuasiLongPhaseVelocity = 2500;
    Calcium.InternalLossFactor = 0.01;
    ElementName = Calcium;
elseif strcmp(Name, 'AutoclavedConcrete')
    % 3
    AutoclavedConcrete.Type = 'AutoclavedConcrete';
    AutoclavedConcrete.Density = 600;
    AutoclavedConcrete.QuasiLongPhaseVelocity = 1900;
    AutoclavedConcrete.InternalLossFactor = 0.0125;
    ElementName = AutoclavedConcrete;
elseif strcmp(Name, 'LightAggregateBlocks')
    % 4
    LightAggregateBlocks.Type = 'LightAggregateBlocks';
    LightAggregateBlocks.Density = 1400;
    LightAggregateBlocks.QuasiLongPhaseVelocity = 2200;
    LightAggregateBlocks.InternalLossFactor = 0.01;
    ElementName = LightAggregateBlocks;
elseif strcmp(Name, 'DenseAggregateBlocks')
    % 5
    DenseAggregateBlocks.Type = 'DenseAggregateBlocks';
    DenseAggregateBlocks.Density = 2000;
    DenseAggregateBlocks.QuasiLongPhaseVelocity = 3200;
    DenseAggregateBlocks.InternalLossFactor = 0.01;
    ElementName = DenseAggregateBlocks;
elseif strcmp(Name, 'Bricks')
    % 6
    Bricks.Type = 'Bricks';
    Bricks.Density = 1600; %[1500:100:2000];
    Bricks.QuasiLongPhaseVelocity = 2700;
    Bricks.InternalLossFactor = 0.01;
    ElementName = Bricks;
elseif strcmp(Name, 'Plasterboard')
    % 7
    Plasterboard.Type = 'Plasterboard';
    Plasterboard.Density = 860;
    Plasterboard.QuasiLongPhaseVelocity = 1490;
    Plasterboard.InternalLossFactor = 0.014;
    ElementName = Plasterboard;
elseif strcmp(Name, 'Plasterboard2')
    % 8
    Plasterboard2.Type = 'Plasterboard2';
    Plasterboard2.Density = 680;
    Plasterboard2.QuasiLongPhaseVelocity = 1810;
    Plasterboard2.InternalLossFactor = 0.0125;
    ElementName = Plasterboard2;
elseif strcmp(Name, 'Chipboard')
    % 9
    Chipboard.Type = 'Chipboard';
    Chipboard.Density = 618;
    Chipboard.QuasiLongPhaseVelocity = 2200;
    Chipboard.InternalLossFactor = 0.01;
    ElementName = Chipboard;
elseif strcmp(Name, 'MDF')
    % 9
    Chipboard.Type = 'MDF';
    Chipboard.Density = 760;
    Chipboard.QuasiLongPhaseVelocity = 2200;
    Chipboard.InternalLossFactor = 0.01;
    ElementName = Chipboard;
elseif strcmp(Name, 'Layer')
    % 10
    Layer.Type = 'MineralWoll';
    Layer.Density = 2100;
    Layer.Stifness = 8;
    ElementName = Layer;
else
    ElementName = '';
    errordlg('Material not found.....Please Select Material Name form above string', 'Material Error');
end

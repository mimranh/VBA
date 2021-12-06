#
# This Function Configures the Materials and the properties associated with each material Element
# 1. Type of Material, 2. Density, 3. Qausi Longitudnal Phase Velocity, 4. Internal Loss Factor, 5. Mass, 6. Thikness, 7. Dimentions (i.e. Length Width etc.)
# The Available Material Data in this Code are as follows
# 1. Concrete, 2 .Calcium, 3. Autoclaved Concrete, 4. Light Aggregate Blocks, 5. Dense Aggregate Blocks, 6. Bricks, 7. Plaster Board Type 2, 8. Plaster Board Type 2, 9. Chipboard

from SI_Constants import SIConstants
import numpy as np

class Materials:
    
    def __init__(self, Length, Width, Thickness, Mass):
        self.Length = Length
        self.Width = Width
        self.Thickness = Thickness
        self.Mass = Mass

    def concrete(self, ElementName):
        self.ElementName = ElementName
        self.Density = 2200.0
        self.QuasiLongPhaseVelocity = 3800.0
        self.InternalLossFactor = 0.005
        self.Area = self.Length*self.Width
        self.Type = 'Concrete'
        const = SIConstants
        self.CriticalFrequency = (const.SoundVelocity**2)/(1.8*self.QuasiLongPhaseVelocity*self.Thickness)
        self.CriticalFrequencyCorrection = self.CriticalFrequency*(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity+np.sqrt(1+(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity)**2))

    def calcium(self, ElementName):
        self.ElementName = ElementName
        self.Type = 'Calcium'
        self.Density = 1800.0
        self.QuasiLongPhaseVelocity = 2500.0
        self.InternalLossFactor = 0.01
        self.Area = self.Length*self.Width
        const = SIConstants
        self.CriticalFrequency = (const.SoundVelocity**2)/(1.8*self.QuasiLongPhaseVelocity*self.Thickness)
        self.CriticalFrequencyCorrection = self.CriticalFrequency*(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity+np.sqrt(1+(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity)**2))

    def autoclavedConcrete(self, ElementName):
        self.ElementName = ElementName
        self.Type = 'AutoclavedConcrete'
        self.Density = 600.0
        self.QuasiLongPhaseVelocity = 1900.0
        self.InternalLossFactor = 0.0125
        self.Area = self.Length*self.Width
        const = SIConstants
        self.CriticalFrequency = (const.SoundVelocity**2)/(1.8*self.QuasiLongPhaseVelocity*self.Thickness)
        self.CriticalFrequencyCorrection = self.CriticalFrequency*(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity+np.sqrt(1+(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity)**2))

    def lightAggregateBlocks(self, ElementName):
        self.ElementName = ElementName
        self.Type = 'LightAggregateBlocks'
        self.Density = 1400.0
        self.QuasiLongPhaseVelocity = 2200.0
        self.InternalLossFactor = 0.01
        self.Area = self.Length*self.Width
        const = SIConstants
        self.CriticalFrequency = (const.SoundVelocity**2)/(1.8*self.QuasiLongPhaseVelocity*self.Thickness)
        self.CriticalFrequencyCorrection = self.CriticalFrequency*(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity+np.sqrt(1+(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity)**2))

    def denseAggregateBlocks(self, ElementName):
        self.ElementName = ElementName
        self.Type = 'DenseAggregateBlocks'
        self.Density = 2000.0
        self.QuasiLongPhaseVelocity = 3200.0
        self.InternalLossFactor = 0.01
        self.Area = self.Length*self.Width
        const = SIConstants
        self.CriticalFrequency = (const.SoundVelocity**2)/(1.8*self.QuasiLongPhaseVelocity*self.Thickness)
        self.CriticalFrequencyCorrection = self.CriticalFrequency*(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity+np.sqrt(1+(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity)**2))

    def bricks(self, ElementName):
        self.ElementName = ElementName
        self.Type = 'Bricks'
        self.Density = 1500.0
        self.QuasiLongPhaseVelocity = 2700.0
        self.InternalLossFactor = 0.01
        self.Area = self.Length*self.Width
        const = SIConstants
        self.CriticalFrequency = (const.SoundVelocity**2)/(1.8*self.QuasiLongPhaseVelocity*self.Thickness)
        self.CriticalFrequencyCorrection = self.CriticalFrequency*(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity+np.sqrt(1+(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity)**2))

    def plasterboard(self, ElementName):
        self.ElementName = ElementName
        self.Type = 'Plasterboard'
        self.Density = 860.0
        self.QuasiLongPhaseVelocity = 1490.0
        self.InternalLossFactor = 0.014
        self.Area = self.Length*self.Width
        const = SIConstants
        self.CriticalFrequency = (const.SoundVelocity**2)/(1.8*self.QuasiLongPhaseVelocity*self.Thickness)
        self.CriticalFrequencyCorrection = self.CriticalFrequency*(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity+np.sqrt(1+(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity)**2))

    def plasterboard2(self, ElementName):
        self.ElementName = ElementName
        self.Type = 'PlasterboardType2'
        self.Density = 680.0
        self.QuasiLongPhaseVelocity = 1810.0
        self.InternalLossFactor = 0.0125
        self.Area = self.Length*self.Width
        const = SIConstants
        self.CriticalFrequency = (const.SoundVelocity**2)/(1.8*self.QuasiLongPhaseVelocity*self.Thickness)
        self.CriticalFrequencyCorrection = self.CriticalFrequency*(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity+np.sqrt(1+(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity)**2))

    def chipboard(self, ElementName):
        self.ElementName = ElementName
        self.Type = 'Chipboard'
        self.Density = 760.0
        self.QuasiLongPhaseVelocity = 2200.0
        self.InternalLossFactor = 0.01
        self.Area = self.Length*self.Width
        const = SIConstants
        self.CriticalFrequency = (const.SoundVelocity**2)/(1.8*self.QuasiLongPhaseVelocity*self.Thickness)
        self.CriticalFrequencyCorrection = self.CriticalFrequency*(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity+np.sqrt(1+(4.05*self.Thickness*const.OneThirdOctaveFrequency/self.QuasiLongPhaseVelocity)**2))

class AdditionalLayers:

    def __init__(self, Length, Width, Thickness, Mass) -> None:
        self.Length = Length
        self.Width = Width
        self.Thickness = Thickness
        self.Mass = Mass

    def MineralWoll(self, ElementName):
        self.ElementName = ElementName
        self.Type = 'MineralWoll'
        self.Density = 2100.0
        self.Area = self.Length*self.Width
        self.Stifness = 8.0

# from SI_Constants import SIConstants
# const = SIConstants
# Mat1 = Materials(6, 5, 0.02, 484)
# Mat1.concrete('Concrete')
# # print(const.SoundVelocity*Mat1.Length)
# print(Mat1.CriticalFrequency)
# print(Mat1.CriticalFrequencyCorrection)

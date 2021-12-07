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
        self.absorption = np.array[0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.0133333,0.0166667,0.02,0.02,0.02,0.02,0.0233333,0.0266667,0.03,0.03,0.03,0.03,0.0333333,0.0366667,0.04,0.04]
        self.sacttering = np.array[0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05]

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
        self.absorption = np.array[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        self.scattering = np.array[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

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
        self.absorption = np.array[0.15,0.15,0.15,0.15,0.15,0.15,0.166667,0.183333,0.2,0.233333,0.266667,0.3,0.31,0.32,0.33,0.353333,0.376667,0.4,0.403333,0.406667,0.41,0.39,0.37,0.35,0.343333,0.336667,0.33,0.343333,0.356667,0.37,0.37]
        self.sacttering = np.array[0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.106667,0.113333,0.12,0.15,0.18,0.21,0.242,0.274,0.306,0.340667,0.375333,0.41,0.403333,0.396667,0.39,0.38,0.37,0.36,0.36]
        
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
        self.absorption = np.array[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        self.scattering = np.array[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

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
        self.absorption = np.array[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        self.scattering = np.array[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

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
        self.absorption = np.array[0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3]
        self.sacttering = np.array[0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2]
        
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
        self.absorption = np.array[0.12,0.12,0.12,0.13,0.14,0.15,0.15,0.15,0.15,0.183333,0.13,0.14,0.15,0.15,0.15,0.15,0.13,0.14,0.15,0.15,0.15,0.15,0.13,0.14,0.15,0.15,0.15,0.15,0.16,0.17,0.18]
        self.sacttering = np.array[0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1]
        
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
        self.absorption = np.array[0.12,0.12,0.12,0.13,0.14,0.15,0.15,0.15,0.15,0.183333,0.13,0.14,0.15,0.15,0.15,0.15,0.13,0.14,0.15,0.15,0.15,0.15,0.13,0.14,0.15,0.15,0.15,0.15,0.16,0.17,0.18]
        self.sacttering = np.array[0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1]
        
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
        self.absorption = np.array[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        self.scattering = np.array[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

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

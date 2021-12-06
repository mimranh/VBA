#
# ISO: EN 12354-1
# Building Acoustic Constants
# Authors:        Muhammad Imran (mim@akustik.rwth-aachen.de)
#

class SIConstants:
    import numpy as np
    SoundVelocity = 343.0  # Velocity of Sound in Air
    AirDensity = 1.29  # Density of air (kg/m3)
    RefFrequency = 1000.0  # Reference Frequency (Hz)
    RefMass = 1.0  # Reference Mass (Kg)
    OneThirdOctaveFrequency = np.array([50, 63, 80, 100, 125, 160, 200, 250, 315, 400,500, 630, 800, 1000, 1250, 1600, 2000, 2500, 3150, 4000, 5000])  # 1/3 Oct Frequency Band
    OneThirdOctaveFrequencyFull = np.array([20, 25, 31.5, 40, 50, 63, 80, 100, 125, 160, 200, 250, 315, 400,500, 630, 800, 1000, 1250, 1600, 2000, 2500, 3150, 4000, 5000, 6300, 8000, 10000, 12500, 16000, 20000])
    WaveNumberOctOneThird = (2*np.pi*OneThirdOctaveFrequency)/SoundVelocity  # Wave Number Octave Band
    WaveNumberOctOneThirdFull = (2*np.pi*OneThirdOctaveFrequencyFull)/SoundVelocity
    SabineConstant = 0.16  # Sabine Constant
    
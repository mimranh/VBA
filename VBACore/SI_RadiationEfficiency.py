#
# This Faction Calculates the RadiEfficiency, the radiation factor for free waves and the radiation,
# factor for forced transmission for airborne in accordance with ISO 717-1
# These equations are valid for a plate surrounded by an infinite baffle in the same plane. However, in
# buildings walls and floors are usually surrounded by orthogonal elements which will increase the
# radiation efficiency well below the critical frequency by a factor of 2 (edge modes) to 4 (corner modes)


from SI_MaterialProperties import Materials
from SI_Constants import SIConstants
import numpy as np
import matplotlib.pyplot as plt

class SI_RadiationEfficiency:
    def forcedTransmission(Element):
        Delta = -0.964-(0.5+(Element.Length/(np.pi*Element.Width)))*np.log(Element.Width/Element.Length)+((5*Element.Width)/(2*np.pi*Element.Length))-(1/(4*np.pi*Element.Length*Element.Width*(const.WaveNumberOctOneThird**2)))
        SigmaForced = 0.5*(np.log(const.WaveNumberOctOneThird*np.sqrt(Element.Length*Element.Width))-Delta) # Radiation factor for forced transmission
        for index in range(len(const.OneThirdOctaveFrequency)):
            if SigmaForced[index] >= 2:
                SigmaForced[index] = 2
        RadiEfficiencyForced = 10*np.log10(SigmaForced)
        return RadiEfficiencyForced, SigmaForced

    def freeWaveTransmission(Element):
        Sigma1 = 1/np.sqrt(1-(Element.CriticalFrequency/const.OneThirdOctaveFrequency))
        Sigma2 = 4*Element.Length*Element.Width*((const.OneThirdOctaveFrequency/const.SoundVelocity)**2)
        Sigma3 = np.sqrt((2*np.pi*const.OneThirdOctaveFrequency*(Element.Length+Element.Width))/(16*const.SoundVelocity))
        F11 = ((const.SoundVelocity**2)/(4*Element.CriticalFrequency))*((1/Element.Length**2)+(1/Element.Width**2))
        SigmaFreeWave = np.zeros(len(const.OneThirdOctaveFrequency)) # Radiation factor for Free bending waves
        for index in range(len(const.OneThirdOctaveFrequency)):
            if F11 <= Element.CriticalFrequency/2:
                if const.OneThirdOctaveFrequency[index] >= Element.CriticalFrequency:
                    SigmaFreeWave[index] = Sigma1[index]
                elif const.OneThirdOctaveFrequency[index] < Element.CriticalFrequency:
                    Lemda = np.sqrt(const.OneThirdOctaveFrequency[index]/Element.CriticalFrequency)
                    Delta1 = (((1-Lemda**2)*np.log((1+Lemda)/(1-Lemda)))+2*Lemda)/((4*np.pi**2)*(1-Lemda**2)**1.5)
                    if const.OneThirdOctaveFrequency[index] > Element.CriticalFrequency/2:
                        Delta2 = 0
                    elif const.OneThirdOctaveFrequency[index] <= Element.CriticalFrequency/2:
                        Delta2 = (8*const.SoundVelocity**2*(1-2*Lemda**2))/((Element.CriticalFrequency**2)*(np.pi**4)*Element.Length*Element.Width*Lemda*(np.sqrt(1-Lemda**2)))
                    SigmaFreeWave[index] = ((2*(Element.Length+Element.Width))/(Element.Length*Element.Width))*(const.SoundVelocity/Element.CriticalFrequency)*Delta1+Delta2
                if F11>const.OneThirdOctaveFrequency[index] and F11<Element.CriticalFrequency/2 and SigmaFreeWave[index] > Sigma2[index]:
                    SigmaFreeWave[index] = Sigma2[index]
            elif F11 > Element.CriticalFrequency/2:
                if const.OneThirdOctaveFrequency[index] < Element.CriticalFrequency and Sigma2[index] < Sigma3[index]:
                    SigmaFreeWave[index] = Sigma2[index]
                elif const.OneThirdOctaveFrequency[index] > Element.CriticalFrequency and Sigma1[index] < Sigma3[index]:
                    SigmaFreeWave[index] = Sigma1[index]
                else:
                    SigmaFreeWave[index] = Sigma3[index]
        for index in range(len(const.OneThirdOctaveFrequency)):
            if SigmaFreeWave[index] >= 2:
                SigmaFreeWave[index] = 2
        RadiEfficiencyFreeWave = 10*np.log10(SigmaFreeWave)
        return RadiEfficiencyFreeWave, SigmaFreeWave


# Element = Materials(3, 2.5, 0.02, 484)
# Element.concrete('Concrete')
# const = SIConstants
# RE = SI_RadiationEfficiency
# RadiEfficiencyForced, SigmaForced = RE.forcedTransmission(Element)
# RadiEfficiencyFreeWave, SigmaFreeWave = RE.freeWaveTransmission(Element)

# plt.plot(const.OneThirdOctaveFrequency,SigmaForced, color='blue', label='Sigma Forced')
# plt.plot(const.OneThirdOctaveFrequency,SigmaFreeWave, color='red', label='Sigma Free Wave')
# plt.legend()
# plt.grid(True)
# plt.xlabel('Frequency (Hz)')
# plt.ylabel('Radiation Factor')
# plt.title('Radiation Transmission Coefficients')
# plt.xscale('log')
# plt.show()

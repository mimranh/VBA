#
# This Function Calculates the Weighted Sound Reduction Index for airborne in accordance with ISO 717-1

from SI_MaterialProperties import AdditionalLayers, Materials
from SI_Constants import SIConstants
import numpy as np

def WeightedSoundReduction(Element):
    if Element.Type == 'Concrete' or Element.Type == 'Calcium' or Element.Type == 'Bricks':
        if Element.Mass >= 65 and Element.Mass <= 720:
            WeightedReduction = 30.9*np.log10(Element.Mass/const.RefMass)-22.2
            C = -1.6
            Ctr = -4.6
        else:
            WeightedReduction = 37.5*np.log10(Element.Mass/const.RefMass)-42
            C = -1  # or -2
            Ctr = 16-9*np.log10(Element.Mass/const.RefMass)
            if Ctr >= -1:
                Ctr = -1
            elif Ctr < -7:
                Ctr = -7
    else:
        WeightedReduction = 37.5*np.log10(Element.Mass/const.RefMass)-42
        C = -1  # or -2
        Ctr = 16-9*np.log10(Element.Mass/const.RefMass)
        if Ctr >= -1:
            Ctr = -1
        elif Ctr < -7:
            Ctr = -7
    return WeightedReduction, C, Ctr


Element = Materials(6, 5, 0.2, 600)
Element.plasterboard('Pls')
const = SIConstants
Rw, C, Ctr = WeightedSoundReduction(Element)
print(Rw, C, Ctr)


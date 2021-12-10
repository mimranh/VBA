#
# Main Programe

from SI_Constants import SIConstants
from SI_ConstructGeometry import SI_ConstructGeometry
from SI_RadiationEfficiency import SI_RadiationEfficiency
from SI_MaterialProperties import Materials

Element = SI_ConstructGeometry("VBACore\geometryConfigurations.json", "Construction")
Element.create()
print(Element.Wall1)
# print(Element.Junction1["JunctionID"])

Element1 = Element.Wall1





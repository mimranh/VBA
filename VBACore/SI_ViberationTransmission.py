#
# Viberation Transmission over Junction for Heavy Weighted Elements

import numpy as np
from SI_Constants import SIConstants
import json
from SI_MaterialProperties import Materials

class SI_ViberationTransmission(Materials):
    
    
    def readGeometry(self, GeometryFile):
        self.GeometryFile = GeometryFile #"VBACore/geometryConfigurations.json"
        self.open_Geometry = open(self.GeometryFile)
        self.read_Geometry = self.open_Geometry.read()
        self.Geometry = json.loads(self.read_Geometry)


    

    def viberationTransmissionElement(self, Element, Method):
        for index in range(4):
            if Method == "Emprical":
                JunctionType = Element
            
            elif Method == "Numerical":
                for index in range(len(const.OneThirdOctaveFrequency)):
                    pass






    def viberationTransmissionConstruction(self, Element, Method):
        pass

        




if __name__ == '__main__':
    # print(help(SI_ViberationTransmission))
    # Room = Materials(4,3,0.2,484)
    Room = SI_ViberationTransmission(4,3,0.02,484)
    Room.concrete("Concrete")
    Room.readGeometry("VBACore/geometryConfigurations.json")

    const = SIConstants
    
    print("Done")
    # Room.concrete("Concrete")
    

    

    print(Room.Geometry["Walls"][0]["Dimensions"][0]["Length"]*Room.Geometry["Walls"][0]["Dimensions"][0]["Width"])

    # open_Geometry = open("VBACore/geometryConfigurations.json", "r")
    # read_Geometry = open_Geometry.read()
    # Geometry = json.loads(read_Geometry)

    # print(Geometry["Walls"][0]["Dimensions"][0]["Length"]*Geometry["Walls"][0]["Dimensions"][0]["Width"])
    # print(Geometry["Walls"][1]["Dimensions"][0]["Width"])
    # print(Geometry["Walls"][2]["Dimensions"][0]["Thickness"])






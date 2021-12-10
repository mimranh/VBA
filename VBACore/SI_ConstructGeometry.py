#
# Construct Room Geometry
import json
from SI_MaterialProperties import Materials


class SI_ConstructGeometry(Materials):

    def __init__(self, GeometryFile, Option: str = "Construction"):
        self.GeometryFile = GeometryFile  # "VBACore/geometryConfigurations.json"
        self.open_Geometry = open(self.GeometryFile)
        self.read_Geometry = self.open_Geometry.read()
        self.Geometry = json.loads(self.read_Geometry)
        self.Option = Option

    def create(self):
        if self.Option == "Construction":
            self.Rooms = self.Geometry
            self.Wall1 = self.Rooms["Walls"][0]
            self.Wall2 = self.Rooms["Walls"][1]
            self.Wall3 = self.Rooms["Walls"][2]
            self.Wall4 = self.Rooms["Walls"][3]
            self.Wall5 = self.Rooms["Walls"][4]
            self.Wall6 = self.Rooms["Walls"][5]
            self.Wall7 = self.Rooms["Walls"][6]
            self.Wall8 = self.Rooms["Walls"][7]
            self.Wall9 = self.Rooms["Walls"][8]
            self.Wall10 = self.Rooms["Walls"][9]
            self.Wall11 = self.Rooms["Walls"][10]
            self.Junction1 = self.Rooms["Junctions"][0]
            self.Junction2 = self.Rooms["Junctions"][1]
            self.Junction3 = self.Rooms["Junctions"][2]
            self.Junction4 = self.Rooms["Junctions"][3]
            self.Junction5 = self.Rooms["Junctions"][4]
            self.Junction6 = self.Rooms["Junctions"][5]
            self.Junction7 = self.Rooms["Junctions"][6]
            self.Junction8 = self.Rooms["Junctions"][7]
            self.Junction9 = self.Rooms["Junctions"][8]
            self.Junction10 = self.Rooms["Junctions"][9]
            self.Junction11 = self.Rooms["Junctions"][10]
            self.Junction12 = self.Rooms["Junctions"][11]
            self.Junction13 = self.Rooms["Junctions"][12]
            self.Junction14 = self.Rooms["Junctions"][13]
            self.Junction15 = self.Rooms["Junctions"][14]
            self.Junction16 = self.Rooms["Junctions"][15]
            self.Junction17 = self.Rooms["Junctions"][16]
            self.Junction18 = self.Rooms["Junctions"][17]
            self.Junction19 = self.Rooms["Junctions"][18]
            self.Junction20 = self.Rooms["Junctions"][19]

        elif self.Option == "Element":
            self.Elements = self.Geometry
            self.Wall = self.Elements["Walls"][0]
            self.Length = self.Elements["Walls"][0]["Length"]
            self.Width = self.Elements["Walls"][0]["Width"]
            self.Thickness = self.Elements["Walls"][0]["Thickness"]
            self.Mass = self.Elements["Walls"][0]["Mass"]
            self.Junction1 = self.Elements["Junctions"][0]
            self.Junction2 = self.Elements["Junctions"][1]
            self.Junction3 = self.Elements["Junctions"][2]
            self.Junction4 = self.Elements["Junctions"][3]
        else:
            # print("Select Option as 1). 'Construction' or 2). 'Element'")
            raise Exception(
                "Select Option as 1). 'Construction' or 2). 'Element'")


if __name__ == '__main__':
    Element = SI_ConstructGeometry("VBACore\geometryConfigurations.json", "Construction")
    # print(Element.Geometry["Walls"][0]["WallID"])
    # print(Element.Geometry["Walls"][0]["Length"])
    # print(Element.Geometry["Walls"][0]["Width"])
    # print(Element.Geometry["Walls"][0]["Thickness"])
    # Element.create()
    # print(Element.Wall1["Length"])
    # print(Element.Junction1["JunctionID"])

    Element1 = SI_ConstructGeometry("VBACore\elementConfigurations.json", "Element")
    # print(Element.Geometry["Walls"][0]["WallID"])
    Element1.create()
    # print(Element1.Wall["Length"])
    print(Element1.Length)
    print(Element1.Width)
    print(Element1.Thickness)
    print(Element1.Mass)
    
    print(Element1.Junction1["JunctionID"])

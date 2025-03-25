from pydantic import BaseModel

class HouseFeatures(BaseModel):
    INT_SQFT: int
    N_BEDROOM: int
    N_BATHROOM: int
    AREA_Adyar: int
    AREA_Anna_Nagar: int
    AREA_Chrompet: int
    AREA_KK_Nagar: int
    AREA_Karapakam: int
    AREA_T_Nagar: int
    AREA_Velachery: int
    PARK_FACIL_No: int
    PARK_FACIL_Yes: int
    BUILDTYPE_Commercial: int
    BUILDTYPE_House: int
    BUILDTYPE_Others: int
    UTILITY_AVAIL_No: int
    UTILITY_AVAIL_Yes: int
    STREET_Gravel: int
    STREET_No_Access: int
    STREET_Paved: int

class PricePrediction(BaseModel):
    prediction: float

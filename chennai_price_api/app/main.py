from fastapi import FastAPI
from app.model_loader import model
from app.schemas import HouseFeatures, PricePrediction
import pandas as pd

app = FastAPI(title="Chennai House Price Prediction API")

@app.get("/")
def root():
    return {"message": "Welcome to the Chennai House Price Prediction API!"}

@app.post("/predict", response_model=PricePrediction)
def predict_price(house: HouseFeatures):
    """Predicts house price based on input features"""

    # Convert the input Pydantic model into a pandas DataFrame
    input_data = pd.DataFrame([house.dict()])

    # Make the prediction
    prediction = model.predict(input_data)

    return {"predicted_price": round(prediction[0], 2)}

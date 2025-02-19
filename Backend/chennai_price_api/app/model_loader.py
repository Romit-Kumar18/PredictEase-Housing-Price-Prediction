import joblib
import os

MODEL_PATH = os.path.join(os.path.dirname(__file__), "../model/model.pkl")

def load_model():
    """Load the saved ML model from disk."""
    return joblib.load(MODEL_PATH)

model = load_model()

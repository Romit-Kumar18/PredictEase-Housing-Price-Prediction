# Base Image
FROM python:3.12

# Set working directory
WORKDIR /app

# Copy required files
COPY requirements.txt .
COPY app app/
COPY model/model.pkl model/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose FastAPI port
EXPOSE 8000

# Run FastAPI server
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
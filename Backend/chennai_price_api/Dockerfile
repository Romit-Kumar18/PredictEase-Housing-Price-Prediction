FROM python:3.12

WORKDIR /app

COPY requirements.txt .
COPY app app/
COPY model/model.pkl model/

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
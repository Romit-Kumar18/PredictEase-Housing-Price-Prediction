#!/bin/bash

yum update -y
yum install -y git curl python3-pip libffi libffi-devel openssl-devel

pip3 install docker-compose

service docker start

docker pull romitkumar18/predictease-housing-price-prediction-frontend:latest
docker pull romitkumar18/predictease-housing-price-prediction-backend:latest
docker pull romitkumar18/predictease-housing-price-prediction-ml-service:latest

git clone https://github.com/Romit-Kumar18/PredictEase-Housing-Price-Prediction.git /opt/predictease

cd /opt/predictease/terraform
docker-compose up -d
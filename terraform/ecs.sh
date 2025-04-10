#!/bin/bash
echo "ECS_CLUSTER=my-ecs-cluster" >> /etc/ecs/ecs.config
echo "ECS_BACKEND_HOST=ecs.amazonaws.com" >> /etc/ecs/ecs.config
systemctl stop ecs
sleep 5
systemctl start ecs
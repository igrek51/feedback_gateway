#!/bin/bash
# remote deploy
cd /home/debian/docker/

echo "[remote] Stopping old container..."
docker stop feedback_gateway
echo "[remote] Removing old container..."
docker rm feedback_gateway
echo "[remote] Removing old image..."
docker rmi feedback_gateway
echo "[remote] Loading new image..."
docker load -i feedback_gateway.tar.gz

# RUN
echo "[remote] Running new container..."
sudo docker run 	--name feedback_gateway 	-p 8006:8006 	--network host 	-d 	--restart always 	feedback_gateway

echo "[remote] Logs:"
sudo docker logs feedback_gateway


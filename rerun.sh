#!/bin/bash
export CONTAINER_NAME=feedback_gateway
export IMAGE_NAME=$CONTAINER_NAME

echo "Building image $IMAGE_NAME..."
sudo docker stop $CONTAINER_NAME
sudo docker rm $CONTAINER_NAME
sudo docker rmi $IMAGE_NAME
sudo docker build --tag $IMAGE_NAME .

echo "Running new container..."
sudo docker run \
	--name $CONTAINER_NAME \
	-p 8006:8006 \
	-d \
	$CONTAINER_NAME

echo "Logs:"
sudo docker logs $CONTAINER_NAME


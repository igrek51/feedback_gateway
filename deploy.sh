#!/bin/bash
export CONTAINER_NAME=feedback_gateway
export IMAGE_NAME=$CONTAINER_NAME

echo "Building image $IMAGE_NAME..."
sudo docker stop $CONTAINER_NAME
sudo docker rm $CONTAINER_NAME
sudo docker rmi $IMAGE_NAME
sudo docker build --tag $IMAGE_NAME .

echo "Saving image $IMAGE_NAME..."
rm -f $IMAGE_NAME.tar.gz
sudo docker save -o $IMAGE_NAME.tar $IMAGE_NAME
echo "Compressing image $IMAGE_NAME..."
gzip $IMAGE_NAME.tar
# copy image on remote
echo "Copying image on remote..."
scp $IMAGE_NAME.tar.gz root@51.38.128.10:/home/debian/docker/

# remote deploy script (inject $parameters)
cat <<EOF > deploy_remote.sh
#!/bin/bash
# remote deploy
cd /home/debian/docker/

echo "[remote] Stopping old container..."
docker stop $CONTAINER_NAME
echo "[remote] Removing old container..."
docker rm $CONTAINER_NAME
echo "[remote] Removing old image..."
docker rmi $IMAGE_NAME
echo "[remote] Loading new image..."
docker load -i $IMAGE_NAME.tar.gz

# RUN
echo "[remote] Running new container..."
sudo docker run \
	--name $CONTAINER_NAME \
	-p 8006:8006
	-d \
	--restart always \
	$CONTAINER_NAME

echo "[remote] Logs:"
sudo docker logs $CONTAINER_NAME

EOF

# copy script and execute it remotely
echo "Copying deploying script..."
scp deploy_remote.sh root@51.38.128.10:/home/debian/docker/
echo "Executing deploying script..."
ssh root@51.38.128.10 /home/debian/docker/deploy_remote.sh

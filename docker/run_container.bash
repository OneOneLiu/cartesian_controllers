xhost local:root
XAUTH=/tmp/.docker.xauth

## For fix issues in ssh, run the following manually in the host before starting the container
# sudo rm /tmp/.docker.xauth
# touch /tmp/.docker.xauth
# sudo xauth -f /tmp/.docker.xauth add $(xauth list $DISPLAY)

docker run --rm -it \
    --name=rcartersian_container \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="/home/$USER/.ssh_docker:/root/.ssh/" \
    --volume="/dev/bus/usb:/dev/bus/usb" \
    --volume="/tmp/.docker.xauth:/tmp/.docker.xauth:rw" \
    --net=host \
    --privileged \
    --env="NVIDIA_DRIVER_CAPABILITIES=all" \
    --runtime=nvidia \
    --gpus all \
    cartersian \
    bash

echo "Done."
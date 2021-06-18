#!/bin/bash

# NOTE: The dockerfile copies OpenPCDet and installs it when building the image. 
# This means that if you mount your local openpcdet, it fails to work. You actually
# gotta reinstall that mounted openpcdet to get it to work. 


KITTI_BASE_PATH="/media/darren/Samsung_T5/datasets/kitti/3d_object_detection"
CODE_PATH="/home/darren/Dropbox/code/perception/baraja_roi/OpenPCDet"

ENVS="  --env=NVIDIA_VISIBLE_DEVICES=all
        --env=NVIDIA_DRIVER_CAPABILITIES=all
        --env=DISPLAY
        --env=QT_X11_NO_MITSHM=1
        --gpus all"

XSOCK=/tmp/.X11-unix
XAUTH=$HOME/.Xauthority
VOLUMES="       --volume=$XSOCK:$XSOCK
                --volume=$XAUTH:/home/$(id -un)/.Xauthority
                --volume=$KITTI_BASE_PATH:/root/OpenPCDet/data/kitti"

xhost +local:docker

docker  run -it --rm \
        $VOLUMES \
        $ENVS \
        --privileged \
        --net=host \
	darrenjkt/openpcdet:latest bash

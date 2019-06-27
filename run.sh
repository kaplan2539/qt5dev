#!/bin/bash

#    -e QT_X11_NO_MITSHM=1 \
#    -v $HOME.xauthority:/root/.Xauthority \

IMAGE=qt5dev_${USER}
ENTRYPOINT=${1:-qtcreator}

docker inspect $IMAGE \
    || docker build -t ${IMAGE} \
            --build-arg USERNAME=${USER} \
            --build-arg UID=$(id -u) \
            --build-arg GID=$(id -g) \
            .

mkdir -p $PWD/src $PWD/_config

docker run \
    --user $(id -u):$(id -g) \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    -e QT_GRAPHICSYSTEM=native \
    -v /dev/shm:/dev/shm \
    -v $PWD/src:/home/${USER}/src \
    -v $PWD/_config:/home/${USER}/.config \
    --device /dev/dri \
    --name qt_creator \
    --rm \
    --entrypoint "${ENTRYPOINT}" \
    $IMAGE


#    --net=host \
#docker run \
#    --user $(id -u):$(id -g) \
#    -ti --rm \
#    -e DISPLAY \
#    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
#    -v $PWD:/work \
#    --net=host \
#    -w /work \
#    $CONTAINER $CMD

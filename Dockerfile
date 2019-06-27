FROM ubuntu:18.04 AS qt5dev_base

RUN apt-get update \
 && apt upgrade -y \
 && apt install -y \
        python3-pip mesa-common-dev libglu1-mesa-dev libfontconfig1 libxrender1 libxkbcommon-x11-0 \
        build-essential vim git tmux \
        qt5-default libqt5charts5-dev qtcreator \
 && pip3 install PySide2

ENV QT_DEBUG_PLUGINS=1

FROM qt5dev_base

ARG USERNAME=ubuntu
ARG UID=1000
ARG GID=1000

RUN addgroup --gid $GID ${USERNAME}
RUN adduser --disabled-password --gecos "" --gid $GID --uid $UID ${USERNAME}

USER $USERNAME

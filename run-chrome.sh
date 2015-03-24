#!/bin/sh

SUDO="sudo -E -u $CHROMIUMUSER_USERNAME"

groupadd --gid $CHROMIUMUSER_GID $CHROMIUMUSER_USERNAME

useradd -m $CHROMIUMUSER_USERNAME --uid $CHROMIUMUSER_UID --gid $CHROMIUMUSER_GID && \
	usermod -a -G audio $CHROMIUMUSER_USERNAME

export HOME=/home/$CHROMIUMUSER_USERNAME

PULSE_PATH=$LXC_ROOTFS_PATH/$HOME/.pulse_socket

$SUDO \
if [ ! -e "$PULSE_PATH" ] || [ -z "$(lsof -n $PULSE_PATH 2>&1)" ]; then \
    pactl load-module module-native-protocol-unix auth-anonymous=1 \
        socket=$PULSE_PATH; \
fi

$SUDO google-chrome --no-sandbox



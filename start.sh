#!/bin/bash

SUDO="gksudo --"
USER_UID=$(id -u)
USER_GID=$(id -g)
USER=$(whoami)

if [ "$1" == "sudo" ]; then
	SUDO=sudo 
	FLAGS=-t
fi

xhost +local:

if [ "$(which gksudo)" == "" ]; then
	echo gksudo is required. Please install before running.
	exit 0
fi

SNDDEVS=$(find /dev/snd -type c)
SNDDEVS+=" $(find /dev/dri -type c)"
SNDFLAGS=$(j=""; for i in $SNDDEVS; do j+="--device=\"$i:$i\" "; done; echo $j)

$SUDO \
	docker run $FLAGS -i --rm \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $HOME/google-chrome:/home/$USER \
	-v $HOME/.config/pulse:/home/$USER/.config/pulse \
	$SNDFLAGS \
	--lxc-conf='lxc.cgroup.devices.allow = c 116:* rwm' \
	-e DISPLAY=unix$DISPLAY \
	-e HOME=/home/$USER \
	-e CHROMIUMUSER_USERNAME=$USER \
	-e CHROMIUMUSER_UID=$USER_UID \
	-e CHROMIUMUSER_GID=$USER_GID \
	chrome $@




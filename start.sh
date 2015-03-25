#!/bin/bash

SUDO="gksudo --"
USER_UID=$(id -u)
USER_GID=$(id -g)
USER=$(whoami)

if [ "$1" == "sudo" ]; then
	SUDO=sudo
	FLAGS=-t
fi

if [ "$1" != "--norm" ]; then
	FLAGS+=--rm
else
	shift
fi

if [ "$(which gksudo)" == "" ]; then
	echo gksudo is required. Please install the gksu package before running.
	echo On Ubuntu, use:
	echo sudo apt-get install gksu
	exit 0
fi

xhost +local:

#Enumerate the sound devices in /dev/snd
SNDDEVS=$(find /dev/snd -type c)

#Enumerate DRI devices in /dev/dri. See:
#https://www.stgraber.org/2014/02/09/lxc-1-0-gui-in-containers/
#This is needed for WebGL to be able to access the video.
SNDDEVS+=" $(find /dev/dri -type c)"

SNDFLAGS=$(j=""; for i in $SNDDEVS; do j+="--device=\"$i:$i\" "; done; echo $j)

#	Note
#	--lxc-conf='lxc.cgroup.devices.allow = c 116:* rwm' \ #/dev/snd devices
#	--lxc-conf='lxc.cgroup.devices.allow = c 226:* rwm' \ #/dev/dri devices
#	grants LXC access to /dev/snd and /dev/dri

$SUDO \
	docker run $FLAGS -i \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $HOME/google-chrome:/home/$USER \
	-v $HOME/.config/pulse:/home/$USER/.config/pulse \
	$SNDFLAGS \
	--lxc-conf='lxc.cgroup.devices.allow = c 116:* rwm' \
	--lxc-conf='lxc.cgroup.devices.allow = c 226:* rwm' \
	-e DISPLAY=unix$DISPLAY \
	-e HOME=/home/$USER \
	-e CHROMIUMUSER_USERNAME=$USER \
	-e CHROMIUMUSER_UID=$USER_UID \
	-e CHROMIUMUSER_GID=$USER_GID \
	transistor1/chrome $@




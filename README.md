## Dockerized google-chrome with sound and WebGL

This is a dockerized version of Google Chrome, with sound and WebGL.

**Note**: Thist was tested on a Ubuntu Trusty host, with docker version 1.4.1 and also a VirtualBox host with Debian installed.  On the Debian host, WebGL only worked when forcing it (see Troubleshooting section).  On a different host OS, it is possible that you might have issues with shared devices in /dev, or with the required packages.

Comments and contributions are welcome!  Please comment if you have tested on a different host OS.

### Host requirements:

Your host requires the `gksu` package, to graphically authenticate you in order to run the Docker container.

On Ubuntu, this package is installed by:

    sudo apt-get update && sudo apt-get install gksu
    
Make sure you also have the latest Docker:

    wget -qO- https://get.docker.com/ | sh
    
For WebGL, make sure you have [supported hardware](https://support.google.com/chrome/answer/1220892?hl=en).

### Usage:

Make sure you are a normal, non-privileged user with sudo access.  Then run the following commands.

    sudo docker run transistor1/chrome config > start.sh
    sudo chmod +x start.sh
    ./start.sh

You will then be prompted for your sudo password to run the Docker container.  You will get some warnings on startup, but you can safely close them.

Once you have created the start.sh file, the next time you wish to run Chrome, you would just need to run `./start.sh`.

I use a symlink in my $PATH to the start.sh so I can start it more easily.

### Rationale:

Most of the dockerized Chromes I've found use some sort of ssh X forwarding and/or VNC server in them.  I wanted something that was a little more "native".

Newer versions of Docker support pass-through device nodes with the `--device` option, which is how we pass sound from the container to the host.  X is shared through UNIX sockets by sharing the /tmp/.X11-unix directory as a volume.  This may not be the most secure thing in the world, but it should certainly be more secure than running google-chrome directly in Ubuntu.

### Troubleshooting:

You can try to force WebGL rendering on unsupported machines by opening `chrome://flags/` in your instance of Chrome, and clicking "Enable" under the section "Override Software Rendering List".  Be warned, however, that this may result in very poor WebGL performance.  You may want to first ensure that WebGL works properly on your host in Iceweasel or Firefox first.

When Chrome launches, it adds an icon in your Taskbar.  If you want to exit Chrome, make sure you right-click this and select "Exit".  Otherwise, your Docker container will continue running.

![exit-chrome](https://cloud.githubusercontent.com/assets/5625360/6897071/7f641c80-d6e0-11e4-95c5-23133089b893.png)




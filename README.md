## Dockerized google-chrome with sound and WebGL

This is a dockerized version of Google Chrome, with sound and WebGL.

Note: Only tested on a Ubuntu Trusty host, with docker version 1.4.1.  On a different host OS, it is possible that you might have issues with shared devices in /dev, or with the required packages.

### Host requirements:

Your host requires the `gksu` package, to graphically authenticate you in order to run the Docker container.

On Ubuntu, this package is installed by:

    sudo apt-get update && sudo apt-get install gksu

### Usage:

Make sure you are a normal, non-privileged user with sudo access.  Then run the following commands.

    sudo docker pull transistor1/chrome
    sudo docker run transistor1/chrome config > start.sh
    sudo chmod +x start.sh
    ./start.sh

You will then be prompted for your sudo password to run the Docker container.  You will get some warnings on startup, but you can safely close them.

Once you have created the start.sh file, the next time you wish to run Chrome, you would just need to run `./start.sh`.

I use a symlink in my $PATH to the start.sh so I can start it more easily.

### Rationale:

Most of the dockerized Chromes I've found use some sort of ssh X forwarding and/or VNC server in them.  I wanted something that was a little more "native".

Newer versions of Docker support pass-through device nodes with the `--device` option, which is how we pass sound from the container to the host.  X is shared through UNIX sockets by sharing the /tmp/.X11-unix directory as a volume.  This may not be the most secure thing in the world, but it should certainly be more secure than running google-chrome directly in Ubuntu.

    

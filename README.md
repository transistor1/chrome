## Dockerized google-chrome with sound

This is a dockerized version of Google Chrome, with sound.

Tested on Ubuntu Trusty, docker version 1.4.1.

### Rationale:

Most of the dockerized Chromes I've found use some sort of X forwarding and/or VNC server in them.  I wanted something that felt a little more "native".

### Usage:

Make sure you are a normal, non-privileged user with sudo access.  Then run the following commands.

    sudo docker pull transistor1/chrome
    sudo docker run transistor1/chrome config > start.sh
    sudo chmod +x start.sh
    ./start.sh

You will then be prompted for your sudo password to run the Docker container.  You will get some warnings on startup, but you can safely close them.

I use a symlink in my $PATH to the start.sh so I can start it more easily.


    

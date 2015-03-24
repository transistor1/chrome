## Dockerized google-chrome with sound

This is a dockerized version of Google Chrome, with sound.

Tested on Ubuntu Trusty, docker version 1.4.1.

### Rationale:

Most of the dockerized Chromes I've found use some sort of X forwarding and/or VNC server in them.  I wanted something that felt a little more "native'.

### Usage:
    sudo docker build -t chrome .
    ./start.sh

I use a symlink in my $PATH to the start.sh so I can start it more easily.


    

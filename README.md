Docker image for Ghost
======================

Using [Docker](http://docker.io) for [**Ghost** blog engine](https://ghost.org/). This image contains nginx for serve Ghost instance and supervisor to run nginx and Ghost. 

## Usage.

You can pull image from Docker Central Registry. Just type:

``sudo docker pull aleksp/ghost``

in the command line and enjoy.

You can also build your own image:

``docker build -t yourname/cactus .``

Don't miss the dot in the end of command. 

### Why do you nedd to build image from Dockerfile?

If you want to config your future blog before install it (set right domain and email sending parameters), 
or edit nginx and/or supervisor parameters, refer to the *setup* folder. 

## Running container.

``docker run -p 80:80 -d -t yourname/cactus``

where 8000 - your host port, and 80 - container port. If you don't set host port, it'll be set automatically by docker. 


Olease refer to the great [Docker documentation](http://docs.docker.io) ti get help and more information.


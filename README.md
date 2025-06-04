This is a docker container for personal use code development!

To get started, get the repo and build the docker image!

 >   git clone https://github.com/arkrp/dev-container-base.git
 >   cd dev-container-base
 >   docker build -t dev-countainer-base .

After that, whenever you need to spin up your development environment simply type the following two commands into any X11 enabled terminal.

 >   docker run -d -p 9000:22 -v workspace:/home/hannahnelson/workspace -v ssh:/home/hannahnelson/.ssh dev-container-base
 >   ssh -X -p 9000 hannahnelson@localhost

Happy experimenting!

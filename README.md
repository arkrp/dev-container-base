This is a docker container for personal use code development!

To get started, get the repo and build the docker image, run the container, and then connect over ssh!
    git clone https://github.com/arkrp/dev-container-base.git
    cd dev-container-base
    docker build -t dev-countainer-base
    docker run -d -p 9000:22 dev-container-base
    ssh -X -p 9000 hannahnelson@localhost

Happy experimenting!

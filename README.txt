This is a docker container for personal use code development!

To get started, get the repo and build the docker image!

 >   git clone https://github.com/arkrp/dev-container-base.git
 >   bash ./dev-container-base/rebuild.sh

After that, whenever you need to spin up your development environment simply launch the container with launch.sh into any X11 enabled terminal.

 >   ./dev-contianer-base/launchdev.sh

 When you are done, make sure to close the container!!

 >   ./dev-container-base/stopdev.sh

The launchdev and stopdev scripts can be moved somewhere else if its convenient.

Happy experimenting!

The following programs are installed in the container:

Essential user programs:
    nvim - Primary text editor.
    git -  Version control system.
    ssh - Allows remote connection to and from the container.
    tmux - terminal multiplexer
    sshfs - allows mounting remote filesystems using ssh


Specific task:
    python 3.12 - programming language
    zathura - pdf viewer
    pdftex - allows compilation of tex files
    feh - image viewing utility

Other:
    http - hypertext requrests from the command line
    aider (maider) - experimental ai coding agent
    curl - downloads in command line
    fzf - file finding utility
    build-essential (may tools)
    man - documentation for linux utilities

Aliases:
    ocp - your friendly browser based ocp viewer!
    vimtarg - launches the default tmux target for nvim
    maider - launches aider with working configs

In addition to programs, the container pre-downloads several useful pip packages! If you are offline, then this package can download the following pacakges by appending the --no-index flag to pip like so: ```pip install --no-index torch```. Now you can spin up all the venvs you want while offline!

The following pip packages are pre-downloaded
    torch - machine learning
    matplotlib - graphing
    numpy - computation
    build123d - cad modeling
    scipy - extra stuff for numpy
    ipython - better interactive repl
    pandas - spreadsheets! (data table manipulation)
    ocp_vscode - used in tandem with ocp command to display 3d models
    cadquery-ocp - unclear dependency of ocp_vscode
    

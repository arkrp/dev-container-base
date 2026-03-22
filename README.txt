This is a docker container for personal use code development!

To get started, get the repo and build the docker image!

 >   git clone https://github.com/arkrp/dev-container-base.git
 >   bash ./dev-container-base/rebuild.sh

Next you need to place your public ssh key in the config/ssh/ and name it authorized_keys. This lets ssh authenticate your connections so you don't have to enter a password but still are secure from intrusion!

After that, whenever you need to spin up your development environment simply launch the container with launch.sh into any X11 enabled terminal.

 >   ./dev-container-base/launchdev.sh

 When you are done, make sure to close the container!!

 >   ./dev-container-base/stopdev.sh

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
    npm - node package manager
    zathura - pdf viewer
    pdftex - allows compilation of tex files
    quarto - renders quarto markdown documents
    feh - image viewing utility
    ncdu - figure out what files are taking up all of your space

Other:
    http - hypertext requrests from the command line
    aider (maider) - experimental ai coding agent
    curl - downloads in command line
    fzf - file finding utility
    build-essential (may tools)
    man - documentation for linux utilities
    cookiecutter - allows user to create projects from templates
    llm - program to access llms from command line

Aliases:
    ocp - your friendly browser based ocp viewer!
    vimtarg - launches the default tmux target for nvim
    maider - launches aider with working configs
    cookie - grabs a template from my templates folder
    csv - just displays csv files nicely from the command line

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
    

FROM ubuntu:24.04
WORKDIR /app

# install the basics
RUN yes | unminimize
RUN apt-get update && apt-get -y install sudo
RUN apt-get -y install ssh
RUN apt-get -y install neovim
RUN apt-get -y install git
RUN apt-get -y install curl
RUN apt-get -y install nano
RUN apt-get -y install tmux
RUN apt-get -y install python3.12-venv
RUN apt-get -y install fzf
RUN apt-get -y install feh
RUN apt-get -y install build-essential
RUN apt-get -y install python3-tk
RUN apt-get -y install sshfs
RUN apt-get -y install zathura
RUN apt-get -y install texlive-full

# dependency for build123d
RUN apt-get -y install libgl-dev

# install httpie
RUN curl -SsL https://packages.httpie.io/deb/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/httpie.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/httpie.gpg] https://packages.httpie.io/deb ./" | sudo tee /etc/apt/sources.list.d/httpie.list > /dev/null
RUN sudo apt-get update
RUN sudo apt-get -y install httpie

# install pipx
RUN sudo apt-get -y install pipx
RUN sudo pipx ensurepath

# create the user account
ARG USER_NAME="hannahnelson"
ARG USER_PASSWORD="palp"
ARG USER_EMAIL="nexec64@gmail.com"
ARG USER_FULL_NAME="Hannah Nelson"

RUN useradd ${USER_NAME}
RUN usermod -aG sudo ${USER_NAME}
RUN echo "$USER_NAME:$USER_PASSWORD" | chpasswd

# set up the user's home
RUN mkdir /home/${USER_NAME}
RUN chown ${USER_NAME} /home/${USER_NAME}
RUN mkdir /home/${USER_NAME}/workspace
RUN chown ${USER_NAME} /home/${USER_NAME}/workspace
RUN touch /home/${USER_NAME}/.hushlogin
RUN sudo -u ${USER_NAME} mkdir /home/${USER_NAME}/.config

# get pipx stuff working
RUN sudo -u ${USER_NAME} pipx ensurepath
RUN sudo -u ${USER_NAME} pipx install aider-chat

# configure bash
RUN chsh -s /usr/bin/bash ${USER_NAME}
COPY ./bash.bashrc /etc/bash.bashrc

COPY README.txt /home/${USER_NAME}/README.txt

# install nvim configuration
ARG NVIM_GIT_COMMIT="6d2491a"
RUN sudo -u ${USER_NAME} mkdir /home/${USER_NAME}/.config/nvim
RUN sudo -u ${USER_NAME} git clone https://github.com/arkrp/vimrc.git /home/${USER_NAME}/.config/nvim # bump
RUN cd /home/${USER_NAME}/.config/nvim/ && sudo -u ${USER_NAME} git remote set-url origin git@github.com:arkrp/vimrc.git
RUN cd /home/${USER_NAME}/.config/nvim/ && sudo -u ${USER_NAME} git checkout ${NVIM_GIT_COMMIT}
RUN sudo -u ${USER_NAME} nvim +q #this is needed to make the plugins work
RUN sudo -u ${USER_NAME} nvim +PlugInstall +qa #install the nvim plugins

# configure tmux
COPY tmux.conf /home/${USER_NAME}/.tmux.conf

# configure ssh and X11 forwarding!
RUN mkdir /var/run/sshd
RUN echo "ForwardX11 yes" >> /etc/ssh/ssh_config
RUN mkdir /home/${USER_NAME}/.ssh
RUN chown ${USER_NAME} /home/${USER_NAME}/.ssh

# configure git for you!
RUN sudo -u ${USER_NAME} git config --global user.email "${USER_EMAIL}"
RUN sudo -u ${USER_NAME} git config --global user.name "${USER_FULL_NAME}"
RUN sudo -u ${USER_NAME} git config --global core.editor "nvim"

# open the ports!
# 22 for ssh
EXPOSE 22
# 3939 for ocp_vscode
EXPOSE 3939

# summon the starting program!
COPY ./activate.sh .
CMD ["bash","./activate.sh"]

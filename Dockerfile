FROM ubuntu
WORKDIR /app

#install the basics
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

#create the user account
ARG USER_NAME="hannahnelson"
ARG USER_PASSWORD="palp"
ARG USER_EMAIL="nexec64@gmail.com"
ARG USER_FULL_NAME="Hannah Nelson"

RUN useradd ${USER_NAME}
RUN usermod -aG sudo ${USER_NAME}
RUN echo "$USER_NAME:$USER_PASSWORD" | chpasswd

#set up the user's home
RUN mkdir /home/${USER_NAME}
RUN chown hannahnelson /home/${USER_NAME}
RUN mkdir /home/${USER_NAME}/workspace
RUN chown hannahnelson /home/${USER_NAME}/workspace
RUN touch /home/${USER_NAME}/.hushlogin
RUN echo "PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> /etc/bash.bashrc
RUN echo "LS_COLORS=$LS_COLORS:':di=0;93:*.png=1;31;107:' ; export LS_COLORS" >> /etc/bash.bashrc
RUN echo "alias ls=\"ls --color\"" >> /etc/bash.bashrc
RUN chsh -s /usr/bin/bash ${USER_NAME}

#configure nvim
RUN sudo -u hannahnelson mkdir /home/${USER_NAME}/.config
RUN sudo -u hannahnelson mkdir /home/${USER_NAME}/.config/nvim
RUN sudo -u hannahnelson git clone https://github.com/arkrp/vimrc.git /home/${USER_NAME}/.config/nvim
RUN sudo -u hannahnelson nvim +q #this is needed to make the plugins work
RUN sudo -u hannahnelson nvim +PlugInstall +qa #install the nvim plugins

#configure ssh and X11 forwarding!
RUN mkdir /var/run/sshd
RUN echo "ForwardX11 yes" >> /etc/ssh/ssh_config
RUN mkdir /home/${USER_NAME}/.ssh
RUN chown hannahnelson /home/${USER_NAME}/.ssh

#configure git for you!
RUN sudo -u hannahnelson git config --global user.email "${USER_EMAIL}"
RUN sudo -u hannahnelson git config --global user.name "${USER_FULL_NAME}"
RUN sudo -u hannahnelson git config --global core.editor "nvim"

#open the ports!
EXPOSE 22

#summon the starting program!
COPY ./activate.sh .
CMD ["bash","./activate.sh"]



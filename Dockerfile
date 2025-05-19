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

#create the user account
ARG USER_NAME="hannahnelson"
ARG USER_PASSWORD="palp"
RUN useradd ${USER_NAME}
RUN usermod -aG sudo ${USER_NAME}
RUN echo "$USER_NAME:$USER_PASSWORD" | chpasswd

#set up the user's home
RUN mkdir /home/${USER_NAME}
RUN chown hannahnelson /home/${USER_NAME}
RUN touch /home/${USER_NAME}/.hushlogin
RUN echo "PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> /etc/bash.bashrc
RUN chsh -s /usr/bin/bash ${USER_NAME}

#configure nvim
RUN sudo -u hannahnelson mkdir /home/${USER_NAME}/.config
RUN sudo -u hannahnelson mkdir /home/${USER_NAME}/.config/nvim
RUN sudo -u hannahnelson git clone https://github.com/arkrp/vimrc.git /home/${USER_NAME}/.config/nvim
RUN sudo -u hannahnelson nvim +q #it doesn't work the first time so turn it on and off again

#configure ssh and X11 forwarding!
RUN mkdir /var/run/sshd
RUN echo "ForwardX11 yes" >> /etc/ssh/ssh_config

#open the ports!
EXPOSE 22

#summon the starting program!
COPY ./activate.sh .
CMD ["bash","./activate.sh"]



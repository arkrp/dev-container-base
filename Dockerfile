#section-start unminimized_ubuntu
#section-start header
FROM ubuntu:24.04 AS unminimized_ubuntu
WORKDIR /app
#section-end
#section-start unminimize os
RUN apt-get update
RUN yes | unminimize
#section-end
#section-end
#section-start python_package_predownload
#section-start header
FROM unminimized_ubuntu AS python_package_predownload
WORKDIR /app
#section-end
#section-start install python
RUN apt-get update
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN apt-get -y install python3.12-venv
#section-end
#section-start pre-download pip packages
RUN mkdir /app/hoard
RUN mkdir /app/hoard/python
RUN cd /app/hoard/python && echo "torch" > package_name.txt && python3 -m pip download -r package_name.txt
RUN cd /app/hoard/python && echo "matplotlib" > package_name.txt && python3 -m pip download -r package_name.txt
RUN cd /app/hoard/python && echo "numpy" > package_name.txt && python3 -m pip download -r package_name.txt
RUN cd /app/hoard/python && echo "build123d" > package_name.txt && python3 -m pip download -r package_name.txt
RUN cd /app/hoard/python && echo "scipy" > package_name.txt && python3 -m pip download -r package_name.txt
RUN cd /app/hoard/python && echo "ipython" > package_name.txt && python3 -m pip download -r package_name.txt
RUN cd /app/hoard/python && echo "pandas" > package_name.txt && python3 -m pip download -r package_name.txt
RUN cd /app/hoard/python && echo "cadquery-ocp" > package_name.txt && python3 -m pip download -r package_name.txt
RUN cd /app/hoard/python && echo "ocp_vscode" > package_name.txt && python3 -m pip download -r package_name.txt
RUN rm /app/hoard/python/package_name.txt
#section-end
#section-end
#section-start dev_container_base
#section-start header
FROM unminimized_ubuntu AS dev_container_base
WORKDIR /app
#section-end
#section-start install applications!
#section-start update package repository!
RUN apt-get update
#section-end
#section-start install essential system commands
RUN apt-get -y install sudo
RUN apt-get -y install ssh
RUN apt-get -y install git
RUN apt-get -y install curl
RUN apt-get -y install build-essential
#section-end
#section-start install languages
#section-start python
RUN apt-get -y install python3.12-venv
RUN apt-get -y install python3-tk
#section-end
#section-start latex
RUN apt-get -y install texlive-latex-base
RUN apt-get -y install texlive-latex-recommended
RUN apt-get -y install texlive-fonts-recommended
#section-end
#section-start quarto
# This is a pain to install tbh
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.8.27/quarto-1.8.27-linux-amd64.deb
RUN apt-get -y install ./quarto-1.8.27-linux-amd64.deb
RUN apt-get -y install r-base-core
RUN apt-get -y install texlive-luatex
RUN apt-get -y install texlive-latex-extra
RUN apt-get -y install r-cran-knitr
RUN apt-get -y install r-cran-rmarkdown
#section-end
#section-end
#section-start install user apps
RUN apt-get -y install neovim
RUN apt-get -y install tmux
RUN apt-get -y install sshfs
RUN apt-get -y install fzf
RUN apt-get -y install man
#section-start install aider
RUN python3 -m venv aider_venv
RUN /app/aider_venv/bin/python -m pip install -U --upgrade-strategy only-if-needed aider-chat
#section-end
#section-start install httpie
RUN curl -SsL https://packages.httpie.io/deb/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/httpie.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/httpie.gpg] https://packages.httpie.io/deb ./" | sudo tee /etc/apt/sources.list.d/httpie.list > /dev/null
RUN sudo apt-get update
RUN sudo apt-get -y install httpie
#section-end
#section-end
#section-start install file viewers
RUN apt-get -y install feh
RUN apt-get -y install zathura
#section-start install ocp_vscode server
RUN python3 -m venv ocp_vscode_venv
RUN /app/ocp_vscode_venv/bin/python -m pip install cadquery-ocp
RUN /app/ocp_vscode_venv/bin/python -m pip install ocp_vscode
COPY files/ocp_server.sh ocp_server.sh
RUN chmod 777 ocp_server.sh
#section-end
#section-end
#section-start install supporting libraries
#section-start install libgl-dev
#this is a dependency for build123d
RUN apt-get -y install libgl-dev
#section-end
#section-end
#section-end
#section-start download offline resources!
COPY --from=python_package_predownload /app/hoard /app/hoard
#section-end
#section-start set up user home
#section-start create user account!
ARG USER_NAME="hannahnelson"
ARG USER_PASSWORD="palp"
ARG USER_EMAIL="nexec64@gmail.com"
ARG USER_FULL_NAME="Hannah Nelson"

RUN useradd ${USER_NAME}
RUN usermod -aG sudo ${USER_NAME}
RUN echo "$USER_NAME:$USER_PASSWORD" | chpasswd
#section-end
#section-start set up user home!
RUN mkdir /home/${USER_NAME}
RUN chown ${USER_NAME} /home/${USER_NAME}
RUN mkdir /home/${USER_NAME}/workspace
RUN chown ${USER_NAME} /home/${USER_NAME}/workspace
RUN touch /home/${USER_NAME}/.hushlogin
RUN sudo -u ${USER_NAME} mkdir /home/${USER_NAME}/.config
#section-end
#section-start copy readme to home!
COPY README.txt /home/${USER_NAME}/README.txt
#section-end
#section-end
#section-start configure applications!
#section-start load pip configuration
RUN mkdir /home/${USER_NAME}/.config/pip
COPY ./files/pip.conf /home/${USER_NAME}/.config/pip/pip.conf
#section-end
#section-start configure bash
RUN chsh -s /usr/bin/bash ${USER_NAME}
COPY ./files/bash.bashrc /etc/bash.bashrc
#section-end
#section-start install nvim configuration
ARG NVIM_GIT_COMMIT="90f2c55"
RUN sudo -u ${USER_NAME} mkdir /home/${USER_NAME}/.config/nvim
RUN sudo -u ${USER_NAME} git clone https://github.com/arkrp/vimrc.git /home/${USER_NAME}/.config/nvim # bump
RUN cd /home/${USER_NAME}/.config/nvim/ && sudo -u ${USER_NAME} git remote set-url origin git@github.com:arkrp/vimrc.git
RUN cd /home/${USER_NAME}/.config/nvim/ && sudo -u ${USER_NAME} git checkout ${NVIM_GIT_COMMIT}
RUN sudo -u ${USER_NAME} nvim +q #this is needed to make the plugins work
RUN sudo -u ${USER_NAME} nvim +PlugInstall +qa #install the nvim plugins
#section-end
#section-start configure tmux
COPY ./files/tmux.conf /home/${USER_NAME}/.tmux.conf
#section-end
#section-start configure ssh for X11 forwarding!
RUN mkdir /var/run/sshd
RUN echo "ForwardX11 yes" >> /etc/ssh/ssh_config
RUN mkdir /home/${USER_NAME}/.ssh
RUN chown ${USER_NAME} /home/${USER_NAME}/.ssh
#section-end
#section-start configure git!
RUN sudo -u ${USER_NAME} git config --global user.email "${USER_EMAIL}"
RUN sudo -u ${USER_NAME} git config --global user.name "${USER_FULL_NAME}"
RUN sudo -u ${USER_NAME} git config --global core.editor "nvim"
#section-end
#section-end
#section-start expose the ports!
# 22 for ssh
EXPOSE 22
# 3939 for ocp_vscode
EXPOSE 3939
#section-end
#section-start summon the starting program!
COPY ./files/activate.sh .
CMD ["bash","./activate.sh"]
#section-end
#section-end

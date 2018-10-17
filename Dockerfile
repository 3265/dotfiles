FROM ubuntu:18.04

MAINTAINER mgoldchild

ENV USER mgoldchild
ENV HOME /home/${USER}
ENV SHELL /bin/bash
ENV TERM xterm
ENV LANG C.UTF-8
ENV LANGUAGE en_US:
# to avoid choosing time zone
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd -m ${USER}
RUN echo "${USER}:pw" | chpasswd
RUN adduser ${USER} sudo

RUN apt-get update && \
    apt-get install make -y

WORKDIR ${HOME}

RUN mkdir -p ./dotfiles
COPY . ./dotfiles
RUN chown ${USER}:${USER} -R .
RUN chmod +x -R .

RUN cd ./dotfiles && make guest
RUN chown ${USER}:${USER} -R ${HOME}

USER ${USER}

CMD ${SHELL}

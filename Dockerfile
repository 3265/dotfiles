FROM ubuntu:18.04

MAINTAINER mgoldchild

ENV USER mgoldchild
ENV HOME /home/${USER}
ENV SHELL /bin/bash
# to avoid choosing time zone
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd -m ${USER}
RUN echo "${USER}:pw" | chpasswd
RUN adduser ${USER} sudo

RUN apt-get update && \
    apt-get install git -y && \
    apt-get install make -y

WORKDIR ${HOME}

RUN git clone https://github.com/mgoldchild/dotfiles.git
RUN chown ${USER}:${USER} -R .
RUN chmod +x -R .

RUN cd ./dotfiles && make guest
RUN chown ${USER}:${USER} -R ${HOME}

USER ${USER}

CMD ${SHELL}

# Run to build docker image:
#   docker build --build-arg VERSION=v0.2.3 -t bethington/jormungandr:v0.2.3 .
# Must use jormungandr as the container name like so:
#   docker run --name jormungandr -v ./data:/data bethington/jormungandr
FROM ubuntu:18.04
MAINTAINER Ben Ethington <benaminde@gmail.com>

ARG USER_ID
ARG GROUP_ID

ENV HOME /jormungandr

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${GROUP_ID} jormungandr \
	&& useradd -u ${USER_ID} -g jormungandr -s /bin/bash -m -d $HOME jormungandr

# Install necessary tools and libraries
RUN apt-get update
RUN apt-get -y install git nano curl wget net-tools \
 && apt-get clean
RUN apt-get -y install build-essential libssl-dev pkg-config \
 && apt-get clean

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
 && rustup install stable \
 && rustup default stable
 
ENV PATH=/usr/local/cargo/bin:$PATH
   
ARG VERSION
ENV VERSION ${VERSION}

RUN cd $HOME \
 && git clone https://github.com/input-output-hk/jormungandr --branch ${VERSION} --single-branch

# Install and make the executables available in the PATH and Make scripts exectuable
WORKDIR $HOME/jormungandr
RUN cargo install --path jormungandr \
 && cargo install --path jcli \
 && chmod +x ./scripts/bootstrap
 
ENV PATH=$HOME/jormungandr/scripts:$PATH

VOLUME $HOME

EXPOSE 9332 9333 19332 19333

WORKDIR $HOME

CMD bash

# Run to build docker image:
#   docker build --build-arg VERSION=v0.2.3 --build-arg USER_ID=1000 --build-arg GROUP_ID=1000 -t bethington/jormungandr:v0.2.4 .
# Must use jormungandr as the container name like so:
#   docker run -it --name jormungandr --hostname jormungandr -v ./data:/jormungandr/data -p 8443:8443 -p 8299:8299 bethington/jormungandr:v0.2.4
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

WORKDIR $HOME

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH=$HOME/.cargo/bin:$PATH

RUN rustup install stable \
 && rustup default stable
   
ARG VERSION
ENV VERSION ${VERSION}

# Build the Jormungandr executables and make them available by setting the PATH and them make scripts exectuable
RUN git clone --recurse-submodules https://github.com/input-output-hk/jormungandr --branch ${VERSION} --single-branch \
 && cd jormungandr \
 && ls
RUN cargo install --verbose --path jormungandr
RUN cargo install --verbose --path jcli \
 && chmod +x ./scripts/bootstrap \
 && cd ..
 
ENV PATH=$HOME/jormungandr/scripts:$PATH
 
# Final setup of Docker container
VOLUME $HOME/data

EXPOSE 8299 8443

WORKDIR $HOME
COPY start.sh start.sh
RUN chmod +x start.sh

CMD ./start.sh

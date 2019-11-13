# Run to build docker image:
#   docker build -t bethington/jormungandr:v0.7.0 --build-arg PREFIX=/app --build-arg BUILD=true --build-arg VER=v0.7.0 .
# Must use jormungandr as the container name like so:
#   docker run -it --name jormungandr --hostname jormungandr -v ./data:/jormungandr/data -p 8443:8443 -p 8299:8299 bethington/jormungandr:v0.7.0
FROM ubuntu:cosmic
MAINTAINER Ben Ethington <benaminde@gmail.com>
LABEL description="Jormungandr a Cardano node implementation"

ARG PREFIX=/app
ENV ENV_PREFIX=${PREFIX}
ARG REST_PORT=8448
ARG BUILD=false
ENV ENV_BUILD=${BUILD}
ARG VER=v0.7.0
ENV ENV_VER=${VER}

# prepare the environment
RUN apt-get update && \
    apt-get install -y git curl nano && \
    mkdir -p ${ENV_PREFIX} && \
    mkdir -p ${ENV_PREFIX}/src && \
    mkdir -p ${ENV_PREFIX}/bin && \
    cd ${ENV_PREFIX} && \
    git clone --recurse-submodules https://github.com/input-output-hk/jormungandr src && \
    cd src && git checkout ${ENV_VER} && \
    cp scripts/bootstrap scripts/faucet-send-money.shtempl scripts/faucet-send-certificate.shtempl \
    scripts/create-account-and-delegate.shtempl scripts/jcli-helpers ${ENV_PREFIX}/bin 

# install the node and jcli from binary
RUN if [ "${ENV_BUILD}" = "false" ]; then \
    echo "[INFO] - you have selected to install binaries" && \
    cd ${ENV_PREFIX}/bin && \
    curl -s -O -L https://github.com/input-output-hk/jormungandr/releases/download/${ENV_VER}/jormungandr-${ENV_VER}-x86_64-unknown-linux-gnu.tar.gz && \
    tar xzf jormungandr-${ENV_VER}-x86_64-unknown-linux-gnu.tar.gz && rm jormungandr-${ENV_VER}-x86_64-unknown-linux-gnu.tar.gz ; fi 

# install the node and jcli from source
RUN if [ "${ENV_BUILD}" = "true" ]; then \
    echo "[INFO] - you have selected to build and install from source" && \
    apt-get install -y build-essential pkg-config libssl-dev && \
    bash -c "curl https://sh.rustup.rs -sSf | bash -s -- -y" && \
    export PATH=$HOME/.cargo/bin:$PATH && \
    rustup install stable && \
    rustup default stable && \
    cd ${ENV_PREFIX}/src && \
    git submodule update --init --recursive && \
    cargo build --release && \
    cargo install --force --path jormungandr && \
    cargo install --force --path jcli && \
    cp $HOME/.cargo/bin/jormungandr $HOME/.cargo/bin/jcli ${ENV_PREFIX}/bin && \
    rm -rf $HOME/.cargo $HOME/.rustup ; fi

# cleanup
RUN rm -rf ${ENV_PREFIX}/src && \
    RM_ME=`apt-mark showauto` && \
    apt-get remove --purge --auto-remove -y git curl build-essential pkg-config libssl-dev ${RM_ME} && \
    apt-get install -y --no-install-recommends libssl1.1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=${ENV_PREFIX}/bin:${PATH}
WORKDIR ${ENV_PREFIX}/bin

EXPOSE ${REST_PORT}

COPY config.yaml ./

# CMD [ "sh", "startup_script.sh" ]
CMD ./jormungandr --config config.yaml --genesis-block-hash adbdd5ede31637f6c9bad5c271eec0bc3d0cb9efb86a5b913bb55cba549d0770

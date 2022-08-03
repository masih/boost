FROM golang:1.18@sha256:5417b4917fa7ed3ad2678a3ce6378a00c95bfd430c2ffa39936fce55130b5f2c AS go-builder

WORKDIR /root

RUN apt-get update && apt-get install -y jq ocl-icd-opencl-dev libhwloc-dev

# TODO: Grep the lotus version from boost go.mod.
RUN git clone --depth 1 --branch v1.15.2 https://github.com/filecoin-project/lotus.git && \
    cd lotus && \
    make debug install && \
    install -C ./lotus-seed /usr/local/bin/lotus-seed

RUN git clone https://github.com/filecoin-project/boost.git && \
    cd boost &&  \
    make debug install

FROM node:16 As node-builder

FROM ubuntu:20.04

USER root
RUN apt update && apt upgrade -y && apt -y install curl build-essential g++-aarch64-linux-gnu libc6-dev-arm64-cross

RUN useradd -ms /bin/bash builder

USER builder
WORKDIR /home/builder/app

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN ~/.cargo/bin/rustup update
 
RUN ~/.cargo/bin/rustup target add aarch64-unknown-linux-gnu 
RUN ~/.cargo/bin/rustup toolchain install stable-aarch64-unknown-linux-gnu
 
ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc CC_aarch64_unknown_linux_gnu=aarch64-linux-gnu-gcc CXX_aarch64_unknown_linux_gnu=aarch64-linux-gnu-g++
 
CMD ~/.cargo/bin/cargo build --target aarch64-unknown-linux-gnu

FROM ubuntu:20.04 as builder

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq &&\
    apt-get -y install build-essential &&\
    apt-get -y install curl wget git cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

WORKDIR /build

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y

ENV PATH=/root/.cargo/bin:$PATH

RUN git clone https://github.com/alacritty/alacritty &&\
    cd alacritty &&\
    cargo install cargo-deb &&\
    cargo build --release &&\
    cargo deb -p alacritty 

FROM ubuntu:20.04 as final
WORKDIR /alacritty
COPY --from=builder /build/alacritty/target/debian/alacritty_*.deb .

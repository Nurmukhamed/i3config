# Compile and build debian package for alacritty
FROM ubuntu:20.04 as alacritty

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

# Compile and build debian package for bat
FROM ubuntu:20.04 as batcat

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq &&\
    apt-get -y install build-essential &&\
    apt-get -y install curl wget git 

WORKDIR /build

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y

ENV PATH=/root/.cargo/bin:$PATH

RUN git clone https://github.com/sharkdp/bat &&\
    cd bat &&\
    cargo install cargo-deb &&\
    cargo install --locked bat &&\
    cargo deb -p bat

# Compile and build debian package for broot
FROM ubuntu:20.04 as broot

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq &&\
    apt-get -y install build-essential &&\
    apt-get -y install curl wget git

WORKDIR /build

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y

ENV PATH=/root/.cargo/bin:$PATH

RUN git clone https://github.com/Canop/broot &&\
    cd broot &&\
    cargo install cargo-deb &&\
    cargo deb -p broot

# Compile and build debian package for dust
FROM ubuntu:20.04 as dust

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq &&\
    apt-get -y install build-essential &&\
    apt-get -y install curl wget git

WORKDIR /build

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y

ENV PATH=/root/.cargo/bin:$PATH

RUN git clone https://github.com/bootandy/dust &&\
    cd dust &&\
    cargo install cargo-deb &&\
    cargo deb -p du-dust

# Compile and build debian package for exa
FROM ubuntu:20.04 as exa

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq &&\
    apt-get -y install build-essential &&\
    apt-get -y install curl wget git libgit2-dev cmake libz-dev pandoc

WORKDIR /build

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y

ENV PATH=/root/.cargo/bin:$PATH

RUN git clone https://github.com/ogham/exa.git &&\
    cd exa &&\
    cargo install cargo-deb &&\
    cargo install just &&\
    just man &&\ 
    cargo deb -p exa

# Compile and build debian package for ripgrep
FROM ubuntu:20.04 as ripgrep

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq &&\
    apt-get -y install build-essential &&\
    apt-get -y install curl wget git libgit2-dev cmake libz-dev pandoc \
    asciidoctor zsh xz-utils liblz4-tool musl-tools tree

WORKDIR /build

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y

ENV PATH=/root/.cargo/bin:$PATH

RUN git clone https://github.com/BurntSushi/ripgrep &&\
    cd ripgrep &&\
    cargo install cargo-deb &&\
    cargo build --release &&\
    mkdir -p ./deployment/deb &&\
    find ./target -name rg.1 -exec cp {} ./deployment/deb \; &&\ 
    find ./target -name rg.bash -exec cp {} ./deployment/deb \; &&\ 
    find ./target -name rg.fish -exec cp {} ./deployment/deb \; &&\ 
    cp ./complete/_rg ./deployment/deb &&\
    cargo deb -p ripgrep

# Compile and build debian package for i3status-rust
FROM ubuntu:20.04 as i3status

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq &&\
    apt-get -y install build-essential &&\
    apt-get -y install curl wget git libdbus-1-dev libpulse-dev libsensors-dev libnotmuch-dev libssl-dev pandoc

WORKDIR /build

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y

ENV PATH=/root/.cargo/bin:$PATH

RUN git clone https://github.com/greshake/i3status-rust &&\
    cd i3status-rust &&\
    cargo build --release &&\
    ls -al . ./target ./target/release 

FROM ubuntu:20.04 as final
WORKDIR /debs
COPY --from=alacritty /build/alacritty/target/debian/alacritty_*.deb .
COPY --from=batcat /build/bat/target/debian/bat_*.deb .
COPY --from=broot /build/broot/target/debian/broot_*.deb .
COPY --from=dust /build/dust/target/debian/du-dust_*.deb .
COPY --from=exa /build/exa/target/debian/exa_*.deb .
COPY --from=ripgrep /build/ripgrep/target/debian/ripgrep_*.deb .
COPY --from=i3status /build/i3status-rust/target/release/i3status-rust .

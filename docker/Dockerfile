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

RUN git clone https://github.com/greshake/i3status-rust

COPY ./i3status-rust/Cargo.toml ./i3status-rust/
COPY ./i3status-rust/install.sh ./i3status-rust/

RUN cd i3status-rust &&\
    ./man/generate.sh &&\
    cargo install cargo-deb &&\
    cargo deb -p i3status-rs &&\
    ls -al . ./target  

# Compile and build debian nix package for zellij
FROM ubuntu:20.04 as zellij-nix

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq &&\
    apt-get -y install build-essential &&\
    apt-get -y install curl wget git 

RUN addgroup --system nixbld && \
  adduser --home /home/nix --disabled-password --gecos "" --shell /bin/bash nix && \
  adduser nix nixbld && \
  mkdir -m 0755 /nix && chown nix /nix && \
  mkdir -p /etc/nix && echo 'sandbox = false' > /etc/nix/nix.conf

WORKDIR /home/nix
USER nix
ENV USER=nix

RUN touch .bash_profile && \
     wget https://nixos.org/nix/install &&\
     sh ./install --no-daemon

RUN mkdir -p $HOME/.config/nix/ &&\
    echo "experimental-features = nix-command flakes" | tee $HOME/.config/nix/nix.conf &&\
    . /home/nix/.nix-profile/etc/profile.d/nix.sh && \
    nix bundle --bundler github:NixOS/bundlers#toDEB "github:zellij-org/zellij/?v26.1#zellij-native"

# Compile and build zellij
FROM ubuntu:20.04 as zellij-build

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq &&\
    apt-get -y install build-essential &&\
    apt-get -y install curl wget git libdbus-1-dev libpulse-dev libsensors-dev libnotmuch-dev libssl-dev pandoc musl-tools

WORKDIR /build

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y

ENV PATH=/root/.cargo/bin:$PATH

RUN git clone https://github.com/zellij-org/zellij

# Build zellij debian binary package
FROM ubuntu:20.04 as zellij

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq &&\
    apt-get -y install build-essential &&\
    apt-get -y install curl wget git libdbus-1-dev libpulse-dev libsensors-dev libnotmuch-dev libssl-dev pandoc dpkg

WORKDIR /build

RUN mkdir -p ./zellij_0.26.1-1_amd64/DEBIAN &&\
    mkdir -p ./zellij_0.26.1-1_amd64/usr/bin &&\
    mkdir -p ./zellij_0.26.1-1_amd64/usr/share &&\
    mkdir -p ./zellij_0.26.1-1_amd64/usr/share/applications &&\
    mkdir -p ./zellij_0.26.1-1_amd64/usr/share/man/man1 &&\
    mkdir -p ./zellij_0.26.1-1_amd64/usr/share/icons/hicolor/scalable/apps/ &&\
    mkdir -p ./zellij_0.26.1-1_amd64/usr/share/doc/zellij &&\
    mkdir -p ./zellij_0.26.1-1_amd64/usr/share/zellij/layouts &&\
    mkdir -p ./zellij_0.26.1-1_amd64/usr/share/zellij/plugins &&\
    mkdir -p ./zellij_0.26.1-1_amd64/usr/share/bash-completion/completions &&\
    mkdir -p ./zellij_0.26.1-1_amd64/usr/share/fish/vendor_completions.d &&\
    mkdir -p ./zellij_0.26.1-1_amd64/usr/share/zsh/vendor-completions

COPY --from=zellij-nix /home/nix/deb-single-zellij-bin-zellij/zellij-bin-zellij_1.0_amd64.deb .    

RUN dpkg -i ./zellij-bin-zellij_1.0_amd64.deb &&\
    cd /nix/store/*-zellij/share &&\
    cp ./applications/zellij.desktop /build/zellij_0.26.1-1_amd64/usr/share/applications &&\
    cp ./bash-completion/completions/zellij.bash /build/zellij_0.26.1-1_amd64/usr/share/bash-completion/completions &&\
    cp ./fish/vendor_completions.d/zellij.fish /build/zellij_0.26.1-1_amd64/usr/share/fish/vendor_completions.d &&\
    cp ./icons/hicolor/scalable/apps/zellij.png /build/zellij_0.26.1-1_amd64/usr/share/icons/hicolor/scalable/apps/ &&\
    cp ./man/man1/zellij.1.gz /build/zellij_0.26.1-1_amd64/usr/share/man/man1 &&\
    cp ./zsh/site-functions/_zellij /build/zellij_0.26.1-1_amd64/usr/share/zsh/vendor-completions &&\
    apt remove -y zellij-bin-zellij &&\
    cd /build &&\
    wget https://github.com/zellij-org/zellij/releases/download/v0.26.1/zellij-x86_64-unknown-linux-musl.tar.gz -O "zellij-x86_64-unknown-linux-musl.tar.gz" &&\
    ls -al . &&\
    tar zxvf zellij-x86_64-unknown-linux-musl.tar.gz &&\
    mv zellij zellij_0.26.1-1_amd64/usr/bin

COPY zellij/control ./zellij_0.26.1-1_amd64/DEBIAN
COPY --from=zellij-build /build/zellij/assets/plugins ./zellij_0.26.1-1_amd64/usr/share/zellij/plugins
COPY --from=zellij-build /build/zellij/example/layouts ./zellij_0.26.1-1_amd64/usr/share/zellij/layouts
COPY --from=zellij-build /build/zellij/LICENSE.md ./zellij_0.26.1-1_amd64/usr/share/doc/zellij
COPY --from=zellij-build /build/zellij/GOVERNANCE.md ./zellij_0.26.1-1_amd64/usr/share/doc/zellij
COPY --from=zellij-build /build/zellij/README.md ./zellij_0.26.1-1_amd64/usr/share/doc/zellij

RUN cd /build &&\
    chmod 755 ./zellij_0.26.1-1_amd64/usr/bin/zellij &&\
    chmod 644 ./zellij_0.26.1-1_amd64/usr/share/applications/zellij.desktop &&\
    chmod 644 ./zellij_0.26.1-1_amd64/usr/share/bash-completion/completions/zellij.bash &&\
    chmod 644 ./zellij_0.26.1-1_amd64/usr/share/fish/vendor_completions.d/zellij.fish &&\
    chmod 644 ./zellij_0.26.1-1_amd64/usr/share/icons/hicolor/scalable/apps/zellij.png &&\
    chmod 644 ./zellij_0.26.1-1_amd64/usr/share/man/man1/zellij.1.gz &&\
    chmod 644 ./zellij_0.26.1-1_amd64/usr/share/zsh/vendor-completions/_zellij &&\
    chmod 644 ./zellij_0.26.1-1_amd64/usr/share/doc/zellij/*.md &&\
    chmod 644 ./zellij_0.26.1-1_amd64/usr/share/zellij/plugins/*.wasm &&\
    chmod 644 ./zellij_0.26.1-1_amd64/usr/share/zellij/layouts/*.yaml &&\
    dpkg-deb --build --root-owner-group zellij_0.26.1-1_amd64


FROM ubuntu:20.04 as final
WORKDIR /packages
COPY --from=alacritty /build/alacritty/target/debian/alacritty_*.deb .
COPY --from=batcat /build/bat/target/debian/bat_*.deb .
COPY --from=broot /build/broot/target/debian/broot_*.deb .
COPY --from=dust /build/dust/target/debian/du-dust_*.deb .
COPY --from=exa /build/exa/target/debian/exa_*.deb .
COPY --from=ripgrep /build/ripgrep/target/debian/ripgrep_*.deb .
COPY --from=i3status /build/i3status-rust/target/debian/i3status-rs_*.deb .
COPY --from=zellij /build/zellij_0.26.1-1_amd64.deb .

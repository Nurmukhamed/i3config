# Compile and build base package
FROM ubuntu:20.04 AS basebuild

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq &&\
    apt-get -qq -y install \
      asciidoctor \
      build-essential \
      cmake \
      curl \
      git \
      libdbus-1-dev \
      libfontconfig1-dev \
      libfreetype6-dev \
      libgit2-dev \
      liblz4-tool \
      libnotmuch-dev \
      libpulse-dev \
      libsensors-dev \
      libssl-dev \
      libxcb-xfixes0-dev \
      libxkbcommon-dev \
      libz-dev \
      musl-tools \
      pandoc \
      pkg-config \
      python3 \
      python3-dev \
      tree \
      wget \
      xz-utils \
      zsh

WORKDIR /build

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y

ENV PATH=/root/.cargo/bin:$PATH

RUN rustup update stable &&\
    cargo install cargo-deb &&\
    cargo install just

# Compile and build debian package for alacritty
FROM basebuild AS alacritty

RUN git clone https://github.com/alacritty/alacritty &&\
    cd alacritty &&\
    git checkout v0.16.1 &&\
    cargo build --release &&\
    cargo deb -p alacritty 

# Compile and build debian package for bat
FROM basebuild AS batcat

RUN git clone https://github.com/sharkdp/bat &&\
    cd bat &&\
    git checkout v0.26.0 &&\
    cargo install --locked bat &&\
    cargo deb -p bat

# Compile and build debian package for broot
FROM basebuild AS broot

RUN git clone https://github.com/Canop/broot &&\
    cd broot &&\
    git checkout v1.53.0 &&\
    cargo deb -p broot

# Compile and build debian package for dust
FROM basebuild AS dust

RUN git clone https://github.com/bootandy/dust &&\
    cd dust &&\
    git checkout v1.2.3 &&\
    cargo deb -p du-dust

# Compile and build debian package for exa
FROM basebuild as eza

RUN git clone https://github.com/eza-community/eza.git &&\
    cd eza &&\
    git checkout v0.23.4 &&\
    just man &&\ 
    cargo deb -p eza

# Compile and build debian package for i3status-rust
FROM basebuild AS i3status

RUN git clone https://github.com/greshake/i3status-rust &&\
    cd i3status-rust &&\
    git checkout v0.34.0 &&\
    cargo deb -p i3status-rs

FROM nixos/nix AS zellij-nix

WORKDIR /build

RUN nix-channel --update &&\
    nix-shell -p zellij
 
## Compile and build debian nix package for zellij
FROM basebuild AS zellij-build

ARG RUST_BACKTRACE=1

RUN git clone https://github.com/zellij-org/zellij &&\
    cd zellij &&\
    git checkout v0.43.1

# Build zellij debian binary package
FROM basebuild as zellij

RUN mkdir -p ./zellij_0.43.1-1_amd64/DEBIAN &&\
    mkdir -p ./zellij_0.43.1-1_amd64/usr/bin &&\
    mkdir -p ./zellij_0.43.1-1_amd64/usr/share &&\
    mkdir -p ./zellij_0.43.1-1_amd64/usr/share/applications &&\
    mkdir -p ./zellij_0.43.1-1_amd64/usr/share/man/man1 &&\
    mkdir -p ./zellij_0.43.1-1_amd64/usr/share/icons/hicolor/scalable/apps/ &&\
    mkdir -p ./zellij_0.43.1-1_amd64/usr/share/doc/zellij &&\
    mkdir -p ./zellij_0.43.1-1_amd64/usr/share/zellij/layouts &&\
    mkdir -p ./zellij_0.43.1-1_amd64/usr/share/zellij/plugins &&\
    mkdir -p ./zellij_0.43.1-1_amd64/usr/share/bash-completion/completions &&\
    mkdir -p ./zellij_0.43.1-1_amd64/usr/share/fish/vendor_completions.d &&\
    mkdir -p ./zellij_0.43.1-1_amd64/usr/share/zsh/vendor-completions &&\
    wget -q https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-x86_64-unknown-linux-musl.tar.gz &&\
    tar zxvf zellij-x86_64-unknown-linux-musl.tar.gz &&\
    rm zellij-x86_64-unknown-linux-musl.tar.gz &&\
    mv zellij ./zellij_0.43.1-1_amd64/usr/bin

COPY zellij/control ./zellij_0.43.1-1_amd64/DEBIAN

#COPY --from=zellij-nix /nix/store/vv16rai6qp2kxpml5fzfv1p4y84jq04c-zellij-0.43.1/bin/zellij ./zellij_0.43.1-1_amd64/usr/bin
COPY --from=zellij-nix /nix/store/vv16rai6qp2kxpml5fzfv1p4y84jq04c-zellij-0.43.1/share/fish/vendor_completions.d/zellij.fish ./zellij_0.43.1-1_amd64/usr/share/fish/vendor_completions.d
COPY --from=zellij-nix /nix/store/vv16rai6qp2kxpml5fzfv1p4y84jq04c-zellij-0.43.1/share/zsh/site-functions/_zellij ./zellij_0.43.1-1_amd64/usr/share/zsh/vendor-completions/_zellij
COPY --from=zellij-nix /nix/store/vv16rai6qp2kxpml5fzfv1p4y84jq04c-zellij-0.43.1/share/man/man1/zellij.1.gz ./zellij_0.43.1-1_amd64/usr/share/man/man1
COPY --from=zellij-nix /nix/store/vv16rai6qp2kxpml5fzfv1p4y84jq04c-zellij-0.43.1/share/bash-completion/completions/zellij.bash ./zellij_0.43.1-1_amd64/usr/share/bash-completion/completions
COPY --from=zellij-build /build/zellij/example/layouts ./zellij_0.43.1-1_amd64/usr/share/zellij/layouts
COPY --from=zellij-build /build/zellij/example/themes ./zellij_0.43.1-1_amd64/usr/share/zellij/themes
COPY --from=zellij-build /build/zellij/LICENSE.md ./zellij_0.43.1-1_amd64/usr/share/doc/zellij
COPY --from=zellij-build /build/zellij/GOVERNANCE.md ./zellij_0.43.1-1_amd64/usr/share/doc/zellij
COPY --from=zellij-build /build/zellij/README.md ./zellij_0.43.1-1_amd64/usr/share/doc/zellij
COPY --from=zellij-build /build/zellij/assets/zellij.desktop ./zellij_0.43.1-1_amd64/usr/share/applications
COPY --from=zellij-build /build/zellij/assets/logo.png ./zellij_0.43.1-1_amd64/usr/share/icons/hicolor/scalable/apps/zellij.png

RUN cd /build &&\
    chmod 755 ./zellij_0.43.1-1_amd64/usr/bin/zellij &&\
    chmod 644 ./zellij_0.43.1-1_amd64/usr/share/applications/zellij.desktop &&\
    chmod 644 ./zellij_0.43.1-1_amd64/usr/share/bash-completion/completions/zellij.bash &&\
    chmod 644 ./zellij_0.43.1-1_amd64/usr/share/fish/vendor_completions.d/zellij.fish &&\
    chmod 644 ./zellij_0.43.1-1_amd64/usr/share/icons/hicolor/scalable/apps/zellij.png &&\
    chmod 644 ./zellij_0.43.1-1_amd64/usr/share/man/man1/zellij.1.gz &&\
    chmod 644 ./zellij_0.43.1-1_amd64/usr/share/zsh/vendor-completions/_zellij &&\
    chmod 644 ./zellij_0.43.1-1_amd64/usr/share/doc/zellij/*.md &&\
    chmod 644 ./zellij_0.43.1-1_amd64/usr/share/zellij/layouts/*.kdl &&\
    dpkg-deb --build --root-owner-group zellij_0.43.1-1_amd64

FROM ubuntu:20.04 AS final

WORKDIR /output

COPY --from=alacritty /build/alacritty/target/debian/alacritty_*.deb .
COPY --from=batcat /build/bat/target/debian/bat_*.deb .
COPY --from=broot /build/broot/target/debian/broot_*.deb .
COPY --from=dust /build/dust/target/debian/du-dust_*.deb .
COPY --from=eza /build/eza/target/debian/eza_*.deb .
COPY --from=i3status /build/i3status-rust/target/debian/i3status-rs_*.deb .
COPY --from=zellij /build/zellij_0.43.1-1_amd64.deb .

CMD ["/bin/sh", "-c", "cp /output/*.deb /packages/"]

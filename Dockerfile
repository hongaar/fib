FROM amd64/ubuntu:20.04

USER root
RUN mkdir -p /root/app
WORKDIR /root/app

# prerequisite packages
RUN apt-get update -qq && \
    apt-get upgrade -qq -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
            automake \
            autoconf \
            binutils \
            bison \
            bubblewrap \
            build-essential \
            curl \
            file \
            git \
            gnupg2 \
            libc6-dev \
            libcurl4 \
            libedit2 \
            libgcc-9-dev \
            libpython2.7 \
            libstdc++-9-dev \
            libxml2 \
            libz3-dev \
            libgd-dev \
            libpcre3-dev \
            libonig-dev \
            libsqlite3-0 \
            libsqlite3-dev \
            libpq-dev \
            libedit-dev \
            libreadline-dev \
            libgdbm-dev \
            libcurl4-openssl-dev \
            libncurses5-dev \
            libunistring-dev \
            libgc-dev \
            libpng-dev \
            libssl-dev \
            libyaml-dev \
            libxslt-dev \
            libffi-dev \
            libgmp3-dev \
            libtool \
            libncurses-dev \
            libssh-dev \
            unixodbc-dev \
            libzip-dev \
            libbz2-dev \
            libevent-dev \
            libicu-dev \
            liblzma-dev \
            locales \
            pkg-config \
            apt-transport-https \
            ca-certificates \
            gnupg2 \
            software-properties-common \
            vim \
            jq \
            re2c \
            time \
            tzdata \
            wget \
            xorg-dev \
            zlib1g-dev \
            unzip && \
    apt-get clean -qq -y && \
    apt-get autoclean -qq -y && \
    apt-get autoremove -qq -y

# locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# apt languages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
            cython \
            fp-compiler \
            gcc-10 \
            gfortran \
            guile \
            open-cobol \
            rakudo \
            sbcl \
            tcl

# Mono
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt update
RUN apt-get install -qq -y mono-devel

#Powershell
RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install -y powershell
RUN rm packages-microsoft-prod.deb

# QB64
RUN wget -q https://github.com/QB64Team/qb64/releases/download/v1.5/qb64_1.5_lnx.tar.gz
RUN tar xzf qb64_1.5_lnx.tar.gz
RUN mv qb64 /usr/share/qb64
RUN rm qb64_1.5_lnx.tar.gz

# asdf languages
RUN git clone https://github.com/asdf-vm/asdf.git /root/.asdf --branch v0.8.0
RUN chmod 755 /root/.asdf/asdf.sh
RUN echo "/root/.asdf/asdf.sh" >> /etc/bash.bashrc

# Add asdf and qb64 to PATH
ENV PATH="${PATH}:/root/.asdf/shims:/root/.asdf/bin:/usr/share/qb64"

COPY .tool-versions /root/app/.

RUN asdf plugin-add java https://github.com/halcyon/asdf-java.git
RUN asdf install java

RUN asdf plugin-add clojure
RUN asdf install clojure

RUN asdf plugin-add crystal
RUN asdf install crystal

RUN asdf plugin-add dart
RUN asdf install dart

RUN asdf plugin-add dmd https://github.com/sylph01/asdf-dmd.git
RUN asdf install dmd

RUN asdf plugin-add dotnet-core
RUN asdf install dotnet-core

RUN asdf plugin-add elm
RUN asdf install elm

RUN asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
RUN asdf install elixir

RUN asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
RUN asdf install erlang

RUN asdf plugin-add golang
RUN asdf install golang

#RUN asdf plugin-add guile https://github.com/indiebrain/asdf-guile.git
#RUN asdf install guile

RUN asdf plugin-add haskell
RUN asdf install haskell

RUN asdf plugin-add janet https://github.com/Jakski/asdf-janet.git
RUN asdf install janet

RUN asdf plugin-add julia https://github.com/rkyleg/asdf-julia.git
RUN asdf install julia

RUN asdf plugin-add kotlin https://github.com/missingcharacter/asdf-kotlin.git
RUN asdf install kotlin

RUN asdf plugin-add groovy https://github.com/weibemoura/asdf-groovy.git
RUN asdf install groovy

RUN asdf plugin-add lua https://github.com/Stratus3D/asdf-lua.git
RUN asdf install lua

RUN asdf plugin-add luaJIT
RUN asdf install luaJIT

RUN asdf plugin-add nim
RUN asdf install nim

RUN asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
RUN asdf install nodejs

RUN asdf plugin-add ocaml
RUN asdf install ocaml

RUN asdf plugin add perl https://github.com/ouest/asdf-perl.git
RUN asdf install perl

RUN asdf plugin-add php
RUN asdf install php

RUN asdf plugin-add pony https://github.com/enilsen16/asdf-pony.git
RUN asdf install pony

RUN asdf plugin-add python
RUN asdf install python

RUN asdf plugin-add pypy3
RUN asdf install pypy3

RUN asdf plugin-add R
RUN asdf install R

#RUN asdf plugin-add raku
#RUN asdf install raku

RUN asdf plugin-add ruby
RUN asdf install ruby

RUN asdf plugin-add rust
RUN asdf install rust

#RUN asdf plugin-add sbcl
#RUN asdf install sbcl

RUN asdf plugin-add scala
RUN asdf install scala

RUN asdf plugin-add swift https://github.com/fcrespo82/asdf-swift.git
RUN asdf install swift

#RUN asdf plugin-add tcl
#RUN asdf install tcl

RUN asdf plugin-add v
RUN asdf install v


COPY . /root/app
CMD ["/bin/bash", "-c", "./run.sh"]

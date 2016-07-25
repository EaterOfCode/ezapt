#!/usr/bin/env bash

set -e;

gems="";
pips="";
dependencies="";

main() {
    local __package="$1";

    echo "Including facts about ${__package}";
    . "./pkgs/${__package}";
    echo "Installing dependencies for ${__package}"
    install_dependencies;
    echo "Downloading source for ${__package}"
    download_source;
    echo "Running before build hook for ${__package}"
    before_build;
    echo "Running build hook for ${__package}"
    build;
    echo "Running build deb hook for ${__package}"
    build_deb;
}

before_build(){ :; }

build() { :; }

build_deb() { :; }

download_source() {
    case "$source" in
        git)
            git clone "${git}" /source
            ;;
        http|https)
            wget -O/tmp/ezapt "${url}";
            cd /source;
            tar -xf /tmp/ezapt;
            ;;
     esac

     cd /source;
}

install_dependencies() {
    if [ ! -z "${dependencies}" ]; then
        apt-get install -qy $dependencies;
    fi

    if [ ! -z "${gems}" ]; then
        gem install --no-ri --no-rdoc $gems;
    fi

    if [ ! -z "${pips}" ]; then
        pip install $pips;
    fi
}

main $@;
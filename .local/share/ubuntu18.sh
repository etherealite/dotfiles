#!/usr/bin/env bash

### setup ubuntu 18.04

## APT packages

#admin packages
PCKG_ADMIN="\
tree
htop
samba
xauth"

# shell packages
PCKG_SHELL="\
zsh
jq
silversearcher-ag
byobu
expect
ranger
thefuck
"

# development packages
PCKG_DEVEL="\
vim
mysql-client
lftp
php-cli
php-curl
php-zip
php-yaml
php-xml
php-json
php-pdo
php-readline
php-mbstring
unzip"

### Stuff to install manually
# composer
# docker
# docker-compose
# fzf
# dynamic-colors

## stuff that at least needs to be conifgured manually - for now.
# byobu
# ranger
# samba - make template smb.conf and copy to /etc/samba
# sshd - uncomment stuff to allow key based, no login auth

setup_env() {
    export DEBIAN_FRONTEND=noninteractive
}

install_apt_pkgs() {

    # Prevent apt from prompting the user
    



    PCKG_ALL="$PCKG_ADMIN $PCKG_SHELL $PCKG_DEVEL"

    sudo apt-get update 

    echo "Installing aptitude"

    sudo apt-get install aptitude || exit 1

    sudo aptitude install debconf-utils

    echo "Installing APT Packages"

    PACKAGES=$(echo "$PCKG_ALL" | tr '\n' ' ')

    #echo $PACKAGES
    sudo aptitude -y install $PACKAGES || exit 1
}

install_docker() {

    # install apt dependancies
    sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

    # install ppa keyring
    curl -fsSL \
    https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # Add the Docker repository to APT sources:
    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

    sudo apt-get update

    sudo apt-get -y install docker-ce

    sudo groupadd docker

    sudo usermod -aG docker $USER

    sudo chown "$USER":"$USER" /home/"$USER"/.docker -R

    sudo chmod g+rwx "/home/$USER/.docker" -R

    sudo systemctl enable docker
}

install_composer() {
    EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('SHA384', 'composer-setup.php');")"

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
    then
        >&2 echo 'ERROR: Invalid installer signature'
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php --install-dir="$HOME/.local/bin" --filename=composer --quiet
    FAILED=$?

    rm composer-setup.php

    exit $FAILED
}
setup_env

#install_apt_pkgs

#install_docker

install_composer


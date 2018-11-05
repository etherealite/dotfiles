#!/usr/bin/env bash

# Use this to bootstrap dotfiles when yadm isn't locally
# available or isntalled.

unset CDPATH
set -Eeuo pipefail

bindir=~/.local/bin
yadm=""
yadmtemp=/tmp/yadmsrc
repo="https://github.com/etherealite/dotfiles.git"
yadmsrc="\
https://raw.githubusercontent.com/TheLocehiliosan/yadm/master/yadm" 
yadmsha256="5d1fb19a0a10679908df8cf1864659aedd7ff699c4a6178cf1a7c65cec569f44"


install_git() {

  if ! command -v apt-get &> /dev/null; then
    echo "Couldn't find apt-get"
    return 1
  fi

  sudo apt-get install git -y
}


ensure_git() {
  if ! command -v git &> /dev/null; then
    ask "GIT not found, install?"
    test ! $answer && exit
  fi

  install_git
  if [ $? -gt 0 ]; then
      echo "Unable to install GIT, exiting"
      exit 1
  fi

  echo "GIT installed"
}


ask() {
  answer=

  while true; do
    read -p "$1 Type [y] or [n]: " yn
    case $yn in
      [Yy]* ) 
        answer=y; break;
        ;;
      [Nn]* )
        return
        ;;
    esac
  done
}


install_yadm() {

  mkdir -p ~/.local/bin
  wget "$yadmsrc" -O $yadmtemp || {
    echo "wget failed to down load yadm src from github"
    exit 1
  }

  if ! [ $yadmsha256 != $(sha256sum "$yadmtemp")]; then
    echo "\
  The sha256 of the YADM src code did not match, exiting"
  fi
  
  echo "\
  opening downloaded yadm source code for inspection
  in the editor. If the source is clean enter yes
  in the next screen and it will be copied to ~/.local/bin"
  if test -z $EDITOR; then
    EDITOR=vi
  fi
  $EDITOR $yadmtemp

  ask "Use this code to clone dotfiles into \$HOME ?
  "
  test -n $answer || exit 0

  mv /tmp/yadmsrc $yadm
  chmod u+x $yadm

  cd ~

  $yadm clone "$repo"

  # TODO this is cruf at the moment
  if test -f ~/.gitmodules; then
    $yadm submodule init && $yadm submodule update || {
      echo "failed to clone git submodules" && exit
    }
  fi

  echo "warning: about to overwrite local dot files conflicting
  with those in the repository"

  ask "Overwrite files?
  test -n $answer && $yadm reset --hard


  echo "Hard reset looks like it worked, will decrypt secret
  files

  "

  $yadm decrypt

  echo "attemping to run yadm bootstrap script"

  $yadm bootstrap
}


#!/usr/bin/env sh

### probably deprecated permantnly
# I'm thinking of canning ansible altogether for setting up my workstation.
# will be working towards doing everything in bash from here on out.

# TODO: remove this file along with workstation.yml

install_ansible() {
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -y -qq
  apt-get install -y -qq software-properties-common python-software-properties
  add-apt-repository ppa:ansible/ansible -y
  apt-get update -y -qq
  apt-get install -y -qq ansible
}


#!/bin/bash
if [ `id -u` != "0" ]; then
   echo "This script must be run as root" 
   exit 1
fi


if ! hash ansible-playbook 2>/dev/null; then
  echo "Looks like ansible-play book is not avaiable, adding PPA
and installing"
  install_ansible
fi


export USERNAME="evan"

ansible-playbook $@ -i "localhost," -c local $(dirname $0)/workstation.yml

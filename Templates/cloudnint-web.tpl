#!/usr/bin/env bash
set -x
source /etc/lsb-release

sudo DEBIAN_FRONTEND="noninteractive" apt-get -y dist-upgrade

sudo apt-get update -y
sudo apt-get install apache2 -y



sudo apt-get install python-pip software-properties-common jq -y


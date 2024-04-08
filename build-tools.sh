#!/bin/bash

### Install Python build tools in an Azure Pipelines self-hosted agent's tool
#   cache
#
# Stack used
#
# - Raspberry Pi 4 8Gb
# - Ubuntu server 22.04.3 LTS jammy (arm64).
#   Comes with Python 3.10.12 pre-installed.
# - Tested on ubuntu:jammy Docker image (amd64)
#
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get update
sudo -E apt-get -y install python3.8 python3.8-venv \
python3.9 python3.9-venv \
python3.10-venv \
python3.11 python3.11-venv \
build-essential

### Install Python versions in virtual environments in the agent's tool cache
#
versions=('3.8' '3.9' '3.10' '3.11')
for version in ${versions[@]}; do
    full_version=$(eval "python${version} -V"| cut -d ' ' -f 2)
    mkdir -p Python/${full_version}
    ln -s $(pwd)/Python/${full_version} $(pwd)/Python/$version
    eval "python${version} -m venv Python/${full_version}/x64"
    touch Python/${full_version}/x64.complete
done
#!/bin/bash

set -e

ATLANTIS_VERSION=v0.24.4
ATLANTIS_PACKAGE=atlantis_linux_386.zip

echo "Download Atlantis Library"
brew install atlantis

brew install --cask ngrok

echo "random"        
echo $RANDOM | md5sum | head -c 20; echo;
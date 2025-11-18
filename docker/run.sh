#!/usr/bin/env bash

mkdir -p packages

docker build -t i3status/builder 

docker run -it --rm -v ./packages:/packages i3status/builder


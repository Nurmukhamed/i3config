#!/usr/bin/env bash

docker build -t i3status/builder .
docker run --name builder i3status/builder bash
docker cp builder:/packages .
docker rm builder
docker rmi i3status/builder

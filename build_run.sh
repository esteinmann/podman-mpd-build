#!/bin/bash

echo "Build image localhost/mpd-build"
podman build -t mpd-build build-container

echo "Build image localhost/mpd-run"
# Needs --format docker to support SHELL ["/bin/bash", "-l", "-c"]
podman build --format docker -t mpd-run exec-container

echo "Run localhost/mpd-run detached on port 6601 as container named mpd"
podman run --replace -d -v ./music-db:/music-db -p 6601:6600 --name mpd localhost/mpd-run

echo "Communicate with mpd on port 6601. i.e. mpc --port 6601. Place audio files in folder music-db."
